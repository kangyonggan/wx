package com.kangyonggan.wx.service.impl;

import com.github.ofofs.jca.annotation.Log;
import com.github.pagehelper.PageHelper;
import com.kangyonggan.common.BaseService;
import com.kangyonggan.wx.constants.AppConstants;
import com.kangyonggan.wx.exception.ValidException;
import com.kangyonggan.wx.model.Record;
import com.kangyonggan.wx.service.RecordService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @since 10/3/18
 */
@Service
public class RecordServiceImpl extends BaseService<Record> implements RecordService {

    @Override
    @Log
    public void saveRecord(Record record) {
        if (StringUtils.isEmpty(record.getContent()) && StringUtils.isEmpty(record.getFileNames())) {
            throw new ValidException();
        }
        if (StringUtils.isEmpty(record.getContent())) {
            record.setContent("");
        }
        myMapper.insertSelective(record);
    }

    @Override
    @Log
    public List<Record> findRecords(String openid, int pageNum) {
        Example example = new Example(Record.class);
        if (StringUtils.isNotEmpty(openid)) {
            example.createCriteria().andEqualTo("openid", openid);
        }

        example.setOrderByClause("id desc");
        PageHelper.startPage(pageNum, AppConstants.SALT_SIZE);
        return myMapper.selectByExample(example);
    }
}
