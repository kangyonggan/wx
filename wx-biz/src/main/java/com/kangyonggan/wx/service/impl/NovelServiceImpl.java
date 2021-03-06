package com.kangyonggan.wx.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.app.util.Collections3;
import com.kangyonggan.app.util.HtmlUtil;
import com.kangyonggan.common.BaseService;
import com.kangyonggan.common.Params;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.wx.constants.YesNo;
import com.kangyonggan.wx.mapper.NovelMapper;
import com.kangyonggan.wx.model.Dict;
import com.kangyonggan.wx.model.Novel;
import com.kangyonggan.wx.service.DictService;
import com.kangyonggan.wx.service.NovelService;
import com.kangyonggan.wx.util.FileUtil;
import lombok.extern.log4j.Log4j2;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @since 6/7/18
 */
@Service
@Log4j2
public class NovelServiceImpl extends BaseService<Novel> implements NovelService {

    @Autowired
    private NovelMapper novelMapper;

    private boolean isPull;

    @Autowired
    private DictService dictService;

    @Value("${app.file.upload}")
    private String fileUploadPath;

    @Override
    @Log
    public List<Novel> searchNovels(Params params) {
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        return novelMapper.searchNovels(params.getQuery());
    }

    @Override
    @Log
    public void updateNovel(Novel novel) {
        myMapper.updateByPrimaryKeySelective(novel);
    }

    @Override
    @Log
    public Novel findNovelByCode(String code) {
        Novel novel = new Novel();
        novel.setCode(code);
        return myMapper.selectOne(novel);
    }

    @Override
    public void pullNovels() {
        if (isPull) {
            log.info("小说更新中，请稍后再试！");
            return;
        }

        isPull = true;

        List<Dict> categories = dictService.findDictsByDictType("NOVEL");
        List<String> categoryCodes = Collections3.extractToList(categories, "dictCode");
        int errCnt = 0;
        int code = 1;
        while (true) {
            try {
                Novel novel = new Novel();
                novel.setCode(String.valueOf(code));
                if (super.exists(novel)) {
                    code++;
                    continue;
                }

                Document document = HtmlUtil.parseUrl(BI_QU_GE_URL + "book/" + code);
                parseNovel(document, String.valueOf(code++), categoryCodes);
            } catch (Exception e) {
                log.error("小说解析异常, 继续解析下一本", e);
                if (errCnt++ > 5) {
                    log.info("连续解析5次，退出");
                    break;
                }
            }
        }
        isPull = false;
    }

    @Override
    @Log
    public void pullNovel(String novelCode) {
        if (isPull) {
            log.info("小说更新中，请稍后再试！");
            return;
        }

        isPull = true;

        List<Dict> categories = dictService.findDictsByDictType("NOVEL");
        List<String> categoryCodes = Collections3.extractToList(categories, "dictCode");
        try {
            Novel novel = new Novel();
            novel.setCode(novelCode);
            if (super.exists(novel)) {
                isPull = false;
                log.error("小说{}已存在，无须抓取", novelCode);
                return;
            }

            if (novelCode.equals("37_37457")) {
                // 许你浮生若梦 - https://www.biquga.com/37_37457/
                Document document = HtmlUtil.parseUrl("https://www.biquga.com/37_37457/");
                parseNovel(document, novelCode, categoryCodes);
            } else if ("774".equals(novelCode)) {
                // 灵魂客栈 - http://www.xianqihaotianmi.com/book/774.html
                Document document = HtmlUtil.parseUrl("http://www.xianqihaotianmi.com/book/774.html");
                parseXiaoqiNovel(document, novelCode, categoryCodes);
            } else if ("2722".equals(novelCode) || "380".equals(novelCode)) {
                // 逆天邪神 - https://www.biqubao.com/book/2722/
                //  || 九星霸体诀
                Document document = HtmlUtil.parseUrl("https://www.biqubao.com/book/" + novelCode);
                parseNovel(document, novelCode, categoryCodes);
            } else if ("106513".equals(novelCode)) {
                // 充个会员当武神 - http://www.800txt.net/book_106513/
                Document document = HtmlUtil.parseUrl("http://www.800txt.net/book_106513/");
                parseNovel(document, novelCode, categoryCodes);
            } else {
                // 灵剑尊 - https://www.qu.la/book/66788/
                Document document = HtmlUtil.parseUrl(BI_QU_GE_URL + "book/" + novelCode);
                parseNovel(document, novelCode, categoryCodes);
            }
        } catch (Exception e) {
            log.error("抓取小说{}异常", novelCode, e);
        }
        isPull = false;
    }

    /**
     *
     * @param document
     * @param novelCode
     * @param categoryCodes
     */
    private void parseXiaoqiNovel(Document document, String novelCode, List<String> categoryCodes) {
        String name = document.select(".info2 h1").html().trim();
        String author = document.select(".info2 h3").html().trim();
        String categoryCode = "qita";
        String picUrl = document.select(".info1 img").attr("src");
        author = author.substring(author.indexOf(":") + 1);
        String descp = document.select(".info2 div p").html().trim();

        Novel novel = new Novel();
        novel.setCode(novelCode);
        novel.setName(name);
        novel.setAuthor(author);
        novel.setDescp(descp);
        novel.setCategoryCode(categoryCode);

        String filePath = "cover/" + novelCode + picUrl.substring(picUrl.lastIndexOf("."));
        try {
            FileUtil.downloadFromUrl(picUrl, fileUploadPath + filePath);
            filePath = "upload/" + filePath;
        } catch (Exception e) {
            filePath = "app/images/nocover.jpg";
        }
        novel.setPicUrl(filePath);

        log.info("抓取小说{}", novel);
        myMapper.insertSelective(novel);
    }

    @Override
    @Log
    public List<Novel> findNovels(int pageNum) {
        Example example = new Example(Novel.class);
        example.createCriteria().andEqualTo("status", YesNo.NO.getCode());

        example.setOrderByClause("id desc");
        PageHelper.startPage(pageNum, 10);
        return myMapper.selectByExample(example);
    }

    /**
     * 解析小说
     *
     * @param document
     * @param code
     * @param categoryCodes
     * @throws Exception
     */
    public void parseNovel(Document document, String code, List<String> categoryCodes) throws Exception {
        String name = document.select("#maininfo #info h1").html().trim();
        String author = document.select("#maininfo #info p").get(0).html().trim();
        String categoryCode;
        try {
            categoryCode = document.select(".box_con .con_top a").get(1).attr("href").replaceAll("/", "");
        } catch (Exception e) {
            categoryCode = "qita";
        }
        if (!categoryCodes.contains(categoryCode)) {
            categoryCode = "qita";
        }

        String picUrl = document.select("#fmimg img").attr("src");
        author = author.substring(author.indexOf("：") + 1);
        String descp = document.select("#intro").html().trim();

        Novel novel = new Novel();
        novel.setCode(code);
        novel.setName(name);
        novel.setAuthor(author);
        novel.setDescp(descp);
        novel.setCategoryCode(categoryCode);

        String filePath = "cover/" + code + picUrl.substring(picUrl.lastIndexOf("."));
        try {
            FileUtil.downloadFromUrl(picUrl, fileUploadPath + filePath);
            filePath = "upload/" + filePath;
        } catch (Exception e) {
            filePath = "app/images/nocover.jpg";
        }
        novel.setPicUrl(filePath);

        log.info("抓取小说{}", novel);
        myMapper.insertSelective(novel);
    }
}
