package com.kangyonggan.wx.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.app.util.Collections3;
import com.kangyonggan.app.util.HtmlUtil;
import com.kangyonggan.common.BaseService;
import com.kangyonggan.common.Params;
import com.kangyonggan.extra.core.annotation.Log;
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
    public Novel findNovelByCode(Integer code) {
        Novel novel = new Novel();
        novel.setCode(code);
        return myMapper.selectOne(novel);
    }

    @Override
    public void pullNovel(Integer code) {
        Novel novel = new Novel();
        novel.setCode(code);

        if (exists(novel)) {
            log.info("小说已存在");
            return;
        }

        if (isPull) {
            log.info("小说更新中，请稍后再试！");
            return;
        }

        isPull = true;

        if (code == null) {
            code = 1;
        }
        try {
            List<Dict> categoryCodes = dictService.findDictsByDictType("NOVEL");
            Document document = HtmlUtil.parseUrl(BI_QU_GE_URL + "book/" + code);
            parseNovel(document, code, Collections3.extractToList(categoryCodes, "dictCode"));
        } catch (Exception e) {
            log.error("小说解析异常, 继续解析下一本", e);
        } finally {
            isPull = false;
        }
    }

    /**
     * 解析小说
     *
     * @param document
     * @param code
     * @param categoryCodes
     * @throws Exception
     */
    public void parseNovel(Document document, int code, List<String> categoryCodes) throws Exception {
        String name = document.select("#maininfo #info h1").html().trim();
        String author = document.select("#maininfo #info p").get(0).html().trim();
        String categoryCode = document.select(".box_con .con_top a").get(1).attr("href").replaceAll("/", "");
        if (!categoryCodes.contains(categoryCode)) {
            categoryCode = "qita";
        }

        String picUrl = document.select("#fmimg img").attr("src");
        author = author.substring(author.indexOf("：") + 1);
        String descp = document.select("#intro p").get(0).html().trim();

        Novel novel = new Novel();
        novel.setCode(code);
        novel.setName(name);
        novel.setAuthor(author);
        novel.setDescp(descp);
        novel.setCategoryCode(categoryCode);

        String filePath = "cover/" + code + picUrl.substring(picUrl.lastIndexOf("."));
        try {
            FileUtil.downloadFromUrl(picUrl, fileUploadPath + filePath);
        } catch (Exception e) {
            filePath = "app/images/nocover.jpg";
        }
        novel.setPicUrl(filePath);

        log.info("抓取小说{}", novel);
        myMapper.insertSelective(novel);
    }

}
