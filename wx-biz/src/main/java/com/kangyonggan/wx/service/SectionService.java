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
    Section findSectionByCode(Integer sectionCode);

    /**
     * 拉取最新章节
     *
     * @param novelCode
     */
    void updateSections(Integer novelCode);

    /**
     * 查找上一章
     *
     * @param code
     * @return
     */
    Section findPrevSectionByCode(Integer code);

    /**
     * 查找下一章
     *
     * @param code
     * @return
     */
    Section findNextSectionByCode(Integer code);

    /**
     * 更新书籍章节
     *
     * @param novelCodes
     */
    void updateNovelSections(List<Integer> novelCodes);

    /**
     * 章节列表
     *
     * @param novelCode
     * @param pageNum
     * @return
     */
    List<Section> findSections(int novelCode, int pageNum);

    /**
     * 章节详情
     *
     * @param sectionCode
     * @return
     */
    Section findSection(int sectionCode);

}
