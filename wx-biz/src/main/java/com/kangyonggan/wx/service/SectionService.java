package com.kangyonggan.wx.service;


import com.kangyonggan.common.Params;
import com.kangyonggan.wx.model.Section;

import java.util.List;

/**
 * @author kangyonggan
 * @since 6/7/18
 */
public interface SectionService {
    /**
     * 查找小说全部章节
     *
     * @param params
     * @return
     */
    List<Section> findNovelSections(Params params);

    /**
     * 查找章节详情
     *
     * @param sectionCode
     * @return
     */
    Section findSectionByCode(String novelCode, String sectionCode);

    /**
     * 拉取最新章节
     *
     * @param novelCode
     */
    void updateSections(String novelCode);

    /**
     * 查找上一章
     *
     * @param novelCode
     * @param code
     * @return
     */
    Section findPrevSectionByCode(String novelCode, String code);

    /**
     * 查找下一章
     *
     * @param novelCode
     * @param code
     * @return
     */
    Section findNextSectionByCode(String novelCode, String code);

    /**
     * 更新书籍章节
     *
     * @param novelCodes
     */
    void updateNovelSections(List<String> novelCodes);

    /**
     * 章节列表
     *
     * @param novelCode
     * @param pageNum
     * @return
     */
    List<Section> findSections(String novelCode, int pageNum);

    /**
     * 章节详情
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    Section findSection(String novelCode, String sectionCode);

}
