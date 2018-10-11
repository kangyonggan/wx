package com.kangyonggan.wx.controller.api;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.common.Response;
import com.kangyonggan.wx.controller.BaseController;
import com.kangyonggan.wx.model.Novel;
import com.kangyonggan.wx.model.Section;
import com.kangyonggan.wx.service.NovelService;
import com.kangyonggan.wx.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author kangyonggan
 * @since 10/5/18
 */
@RestController
@RequestMapping("book")
public class ApiBookController extends BaseController {

    @Autowired
    private NovelService novelService;

    @Autowired
    private SectionService sectionService;

    /**
     * 书籍列表
     *
     * @param pageNum
     * @return
     */
    @GetMapping("list")
    public Response novels(@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
        Response response = Response.getSuccessResponse();
        List<Novel> novels = novelService.findNovels(pageNum);

        response.put("pageInfo", new PageInfo<>(novels));
        return response;
    }

    /**
     * 章节列表
     *
     * @param novelCode
     * @param pageNum
     * @return
     */
    @GetMapping("sections")
    public Response sections(@RequestParam("novelCode") int novelCode,
                             @RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum) {
        Response response = Response.getSuccessResponse();
        List<Section> sections = sectionService.findSections(novelCode, pageNum);

        response.put("pageInfo", new PageInfo<>(sections));
        return response;
    }

    /**
     * 章节详情
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    @GetMapping("{novelCode:[\\d]+}/section/{sectionCode:[\\d]+}")
    public Response section(@PathVariable("novelCode") int novelCode, @PathVariable("sectionCode") int sectionCode) {
        Response response = Response.getSuccessResponse();
        Section section = sectionService.findSection(novelCode, sectionCode);
        Section nextSection = sectionService.findNextSectionByCode(novelCode, sectionCode);
        Section prevSection = sectionService.findPrevSectionByCode(novelCode, sectionCode);

        response.put("section", section);
        response.put("nextSection", nextSection);
        response.put("prevSection", prevSection);
        return response;
    }

    /**
     * 拉取最新章节
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    @GetMapping("{novelCode:[\\d]+}refresh/{sectionCode:[\\d]+}")
    public Response refresh(@PathVariable("novelCode") int novelCode, @PathVariable("sectionCode") int sectionCode) {
        Section section = sectionService.findSectionByCode(novelCode, sectionCode);
        sectionService.updateSections(section.getNovelCode());
        return Response.getSuccessResponse();
    }

}
