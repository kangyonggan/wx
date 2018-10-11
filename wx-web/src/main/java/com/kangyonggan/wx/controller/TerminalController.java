package com.kangyonggan.wx.controller;

import com.kangyonggan.common.Response;
import com.kangyonggan.wx.service.NovelService;
import com.kangyonggan.wx.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author kangyonggan
 * @since 10/5/18
 */
@RestController
@RequestMapping("terminal")
public class TerminalController {

    @Autowired
    private NovelService novelService;

    @Autowired
    private SectionService sectionService;

    /**
     * 拉取小说
     *
     * @param novelCode
     * @return
     */
    @GetMapping("pullNovel")
    public Response pullNovel(@RequestParam("novelCode") String novelCode) {
        novelService.pullNovel(novelCode);
        return Response.getSuccessResponse();
    }

    /**
     * 拉取章节
     *
     * @param novelCode
     * @return
     */
    @GetMapping("pullSection")
    public Response pullSection(@RequestParam("novelCode") String novelCode) {
        sectionService.updateSections(novelCode);
        return Response.getSuccessResponse();
    }

}
