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
    String BI_QU_GE_URL = "http://www.biquge.cn/";

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
     *
     * @param code
     */
    void pullNovel(Integer code);
}
