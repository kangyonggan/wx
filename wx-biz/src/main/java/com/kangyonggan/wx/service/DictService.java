package com.kangyonggan.wx.service;

import com.kangyonggan.common.Params;
import com.kangyonggan.wx.model.Dict;

import java.util.List;

/**
 * @author kangyonggan
 * @since 8/11/18
 */
public interface DictService {

    /**
     * 根据字典类型查找字典
     *
     * @param dictType
     * @return
     */
    List<Dict> findDictsByDictType(String dictType);

    /**
     * 搜索字典
     *
     * @param params
     * @return
     */
    List<Dict> searchDicts(Params params);

    /**
     * 查找字典
     *
     * @param dictId
     * @return
     */
    Dict findDictByDictId(Long dictId);

    /**
     * 更新字典
     *
     * @param dict
     */
    void updateDict(Dict dict);

    /**
     * 保存字典
     *
     * @param dict
     */
    void saveDict(Dict dict);

    /**
     * 物理删除字典
     *
     * @param dictId
     */
    void deleteDict(Long dictId);

    /**
     * 判断字典代码是否存在
     *
     * @param dictType
     * @param dictCode
     * @return
     */
    boolean existsDictCode(String dictType, String dictCode);

    /**
     * 查找字典
     *
     * @param dictType
     * @param dictCode
     * @return
     */
    Dict findDictByDictTypeAndDictCode(String dictType, String dictCode);
}
