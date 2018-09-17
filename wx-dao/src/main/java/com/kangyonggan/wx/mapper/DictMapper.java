package com.kangyonggan.wx.mapper;

import com.kangyonggan.common.mybatis.MyMapper;
import com.kangyonggan.wx.model.Dict;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author kangyonggan
 * @since 8/8/18
 */
@Mapper
public interface DictMapper extends MyMapper<Dict> {
}