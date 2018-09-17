package com.kangyonggan.wx.controller;

import com.kangyonggan.wx.service.DictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author kangyonggan
 * @since 8/9/18
 */
@Controller
@RequestMapping("validate")
public class ValidateController {

    @Autowired
    private DictService dictService;

    /**
     * 校验字典代码是否可用
     *
     * @param dictType
     * @param dictCode
     * @param oldDictCode
     * @return
     */
    @PostMapping("dictCode")
    @ResponseBody
    public boolean validateDictCode(@RequestParam("dictType") String dictType, @RequestParam("dictCode") String dictCode,
                                    @RequestParam(value = "oldDictCode", required = false, defaultValue = "") String oldDictCode) {
        if (oldDictCode.equals(dictCode)) {
            // 当修改字典时，老的字典代码和新的字典代码一致，表示没修改，所以算作可用
            return true;
        }

        return !dictService.existsDictCode(dictType, dictCode);
    }

}
