package com.kangyonggan.wx.mapper;

import com.kangyonggan.common.Query;
import com.kangyonggan.common.mybatis.MyMapper;
import com.kangyonggan.wx.model.Novel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author kangyonggan
 * @since 2018/04/02
 */
@Mapper
public interface NovelMapper extends MyMapper<Novel> {

    /**
     * 搜索小说
     *
     * @param query
     * @return
     */
    List<Novel> searchNovels(@Param("query") Query query);
}