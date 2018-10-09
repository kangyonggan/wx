package com.kangyonggan.wx.service;


import com.kangyonggan.common.Params;
import com.kangyonggan.wx.model.Novel;

import java.util.List;

/**
 * @author kangyonggan
 * @since 6/7/18
 */
public interface NovelService {

    /**
     * 笔趣阁地址
     */
    String BI_QU_GE_URL = "https://www.qu.la/";

    /**
     * 搜索小说
     *
     * @param params
     * @return
     */
    List<Novel> searchNovels(Params params);

    /**
     * 更新小说
     *
     * @param novel
     */
    void updateNovel(Novel novel);

    /**
     * 根据小说代码查找小说
     *
     * @param code
     * @return
     */
    Novel findNovelByCode(Integer code);

    /**
     * 拉取小说
     */
    void pullNovels();

    /**
     * 拉取指定小说
     *
     * @param novelCode
     */
    void pullNovel(int novelCode);

    /**
     * 查询小说
     *
     * @param pageNum
     * @return
     */
    List<Novel> findNovels(int pageNum);
}
