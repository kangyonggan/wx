package com.kangyonggan.wx.freemarker;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.util.List;
import java.util.UUID;

/**
 * @author kangyonggan
 * @since 5/4/18
 */
public class FuncTag extends AbstractFunctionTag {

    /**
     * 获取UUID
     *
     * @param arguments 参数
     * @return 返回UUID
     */
    public String uuid(List arguments) {
        if (!hasLessTwoArgs(arguments)) {
            throw new RuntimeException("获取UUID, 时没有指定前缀");
        }
        String prefix = arguments.get(1).toString();
        return prefix + UUID.randomUUID().toString().replaceAll("-", "");
    }

    /**
     * URL编码
     *
     * @param arguments 参数
     * @return 返回编码后的URL
     * @throws ScriptException
     */
    public String encode(List arguments) throws ScriptException {
        if (!hasLessTwoArgs(arguments)) {
            throw new RuntimeException("编码时没有指定URL");
        }
        String url = arguments.get(1).toString();
        ScriptEngineManager manager = new ScriptEngineManager();
        ScriptEngine engine = manager.getEngineByName("javascript");
        return (String) engine.eval("encodeURI('" + url + "')");
    }

}
