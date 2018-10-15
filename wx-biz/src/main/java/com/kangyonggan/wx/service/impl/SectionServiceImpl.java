package com.kangyonggan.wx.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.app.util.HtmlUtil;
import com.kangyonggan.app.util.StringUtil;
import com.kangyonggan.common.BaseService;
import com.kangyonggan.common.Params;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.wx.model.Novel;
import com.kangyonggan.wx.model.Section;
import com.kangyonggan.wx.service.NovelService;
import com.kangyonggan.wx.service.SectionService;
import lombok.extern.log4j.Log4j2;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 6/7/18
 */
@Service
@Log4j2
public class SectionServiceImpl extends BaseService<Section> implements SectionService {

    @Autowired
    private NovelService novelService;

    /**
     * 更新标识
     */
    private static Map<String, Boolean> flagMap = new HashMap<>();

    @Override
    @Log
    public List<Section> findNovelSections(Params params) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", params.getQuery().getInteger("novelCode"));

        example.selectProperties("id", "code", "title", "novelCode", "createdTime");

        String sort = params.getSort();
        String order = params.getOrder();
        if (!StringUtil.hasEmpty(sort, order)) {
            example.setOrderByClause(sort + " " + order.toUpperCase());
        }
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public Section findSectionByCode(String novelCode, String sectionCode) {
        Section section = new Section();
        section.setNovelCode(novelCode);
        section.setCode(sectionCode);
        return myMapper.selectOne(section);
    }


    @Override
    @Log
    public Section findPrevSectionByCode(String novelCode, String code) {
        Section section = findSectionByCode(novelCode, code);
        if (section == null) {
            return null;
        }
        Example example = new Example(Section.class);

        example.createCriteria().andEqualTo("novelCode", section.getNovelCode()).andLessThan("id", section.getId());

        example.selectProperties("code", "title");

        example.setOrderByClause("id desc");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }

        return sections.get(0);
    }

    @Override
    @Log
    public Section findNextSectionByCode(String novelCode, String code) {
        Section section = findSectionByCode(novelCode, code);
        if (section == null) {
            return null;
        }
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", section.getNovelCode()).andGreaterThan("id", section.getId());

        example.selectProperties("code", "title");

        example.setOrderByClause("id asc");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }

        return sections.get(0);
    }

    @Override
    public void updateNovelSections(List<String> novelCodes) {
        for (String novelCode : novelCodes) {
            try {
                pullSections(novelCode);
            } catch (Exception e) {
                log.warn("更新小说{}章节异常", novelCode, e);
            }
        }
    }

    @Override
    public List<Section> findSections(String novelCode, int pageNum) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", novelCode);

        example.selectProperties("code", "novelCode", "title");

        example.setOrderByClause("id asc");

        PageHelper.startPage(pageNum, 100);
        return myMapper.selectByExample(example);
    }

    @Override
    public Section findSection(String novelCode, String sectionCode) {
        Section section = new Section();
        section.setNovelCode(novelCode);
        section.setCode(sectionCode);
        return myMapper.selectOne(section);
    }

    @Override
    @Log
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void updateSections(String novelCode) {
        Boolean flag = flagMap.get(novelCode);
        if (flag != null && flag) {
            log.info("小说{}正在更新, 不可再次更新", novelCode);
            return;
        }
        flagMap.put(novelCode, true);

        new Thread() {
            @Override
            public void run() {
                try {
                    pullSections(novelCode);
                } catch (Exception e) {
                    log.warn("更新小说{}章节异常", novelCode, e);
                } finally {
                    flagMap.put(novelCode, false);
                }
            }
        }.start();
    }

    /**
     * 拉取小说章节
     *
     * @param novelCode
     */
    private void pullSections(String novelCode) {
        Novel novel = novelService.findNovelByCode(novelCode);

        if (novel == null) {
            log.info("小说{}不存在，退出章节更新", novelCode);
            return;
        }

        try {
            // 最新章节
            Section lastSection = findLastSectionByNovelCode(novelCode);
            String url = NovelService.BI_QU_GE_URL + "book/" + novelCode;
            if ("106513".equals(novelCode)) {
                url = "http://www.800txt.net/book_" + novelCode;
            } else if ("2722".equals(novelCode)) {
                url = "http://www.biquge.cn/book/" + novelCode;
            } else if ("37_37457".equals(novelCode)) {
                url = "https://www.biquga.com/" + novelCode;
            } else if ("774".equals(novelCode)) {
                url = "http://www.xianqihaotianmi.com/book/774.html";
            }

            Document bookDoc = HtmlUtil.parseUrl(url);
            Elements elements = bookDoc.select(".list-charts li a");

            int startNum = 0;

            if ("37_37457".equals(novelCode)) {
                startNum = 9;
            } else if ("66788".equals(novelCode)) {
                startNum = 12;
            }

            if (lastSection != null) {
                for (int i = 0; i < elements.size(); i++) {
                    Element element = elements.get(i);
                    String scode = element.attr("href");
                    scode = scode.substring(scode.lastIndexOf("/") + 1, scode.lastIndexOf("."));
                    if (lastSection.getCode().equals(scode)) {
                        startNum = i + 1;
                        break;
                    }
                }
            }

            log.info("从第{}章节开始更新", startNum);
            for (int i = startNum; i < elements.size(); i++) {
                Element element = elements.get(i);
                String scode = element.attr("href");
                scode = scode.substring(scode.lastIndexOf("/") + 1, scode.lastIndexOf("."));
                parseSection(novelCode, scode);
            }
        } catch (Exception e) {
            log.warn("抓取章节异常", e);
        }
        log.info("小说更新完毕:{}", novelCode);
    }

    /**
     * 查找最后章节
     *
     * @param code
     * @return
     */
    @Log
    private Section findLastSectionByNovelCode(String code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", code);
        example.setOrderByClause("id desc");

        example.selectProperties("id", "code", "title", "novelCode");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }
        return sections.get(0);
    }

    /**
     * 解析章节
     *
     * @param novelCode
     * @param sectionCode
     */
    private void parseSection(String novelCode, String sectionCode) {
        String url = NovelService.BI_QU_GE_URL + "/book/" + novelCode + "/" + sectionCode + ".html";
        if ("106513".endsWith(novelCode)) {
            url = "http://www.800txt.net/book_" + novelCode + "/" + sectionCode + ".html";
        } else if ("2722".equals(novelCode)) {
            url = "http://www.biquge.cn/book/" + novelCode + "/" + sectionCode + ".html";
        } else if ("37_37457".equals(novelCode)) {
            url = "https://www.biquga.com/37_37457/" + sectionCode + ".html";
        } else if ("774".equals(novelCode)) {
            parseXiaoQi(novelCode, sectionCode);
            return;
        }
        Document doc = HtmlUtil.parseUrl(url);

        String title = doc.select(".bookname h1").html().trim();
        String content = doc.select("#content").html();
        content = content.replaceAll("……", "...");
        content = content.replaceAll("———", "");

        Section section = new Section();
        section.setNovelCode(novelCode);
        section.setCode(sectionCode);
        section.setTitle(title);
        section.setContent(content);

        log.info("章节【{}】保存成功", section.getTitle());
        myMapper.insertSelective(section);
    }

    private void parseXiaoQi(String novelCode, String sectionCode) {
        String url = "http://www.xianqihaotianmi.com/read/" + sectionCode + ".html";
        Document doc = HtmlUtil.parseUrl(url);

        String title = doc.select(".panel-heading").html().trim();
        String content = doc.select(".content-body").html();

        Section section = new Section();
        section.setNovelCode(novelCode);
        section.setCode(sectionCode);
        section.setTitle(title);
        section.setContent(content);

        log.info("章节【{}】保存成功", section.getTitle());
        myMapper.insertSelective(section);
    }
}
