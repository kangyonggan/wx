package com.kangyonggan.wx.service;

import com.kangyonggan.wx.model.Record;

import java.util.List;

/**
 * @author kangyonggan
 * @since 10/3/18
 */
public interface RecordService {
    /**
     * 保存记录
     *
     * @param record
     */
    void saveRecord(Record record);

    /**
     * 查找记录
     *
     * @param openid
     * @param pageNum
     * @return
     */
    List<Record> findRecords(String openid, int pageNum);
}
