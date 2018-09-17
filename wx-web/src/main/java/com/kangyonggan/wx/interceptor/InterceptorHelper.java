package com.kangyonggan.wx.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.github.ofofs.jca.annotation.Util;
import com.kangyonggan.common.Response;
import lombok.extern.log4j.Log4j2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * @author kangyonggan
 * @since 8/11/18
 */
@Log4j2
@Util
public class InterceptorHelper {

    /**
     * 判断是否是异步请求
     *
     * @return
     */
    public static boolean isAjaxRequest(HttpServletRequest request) {
        return request.getHeader("accept") != null && request.getHeader("accept").contains("application/json")
                || (request.getHeader("X-Requested-With") != null && request.getHeader("X-Requested-With").contains("XMLHttpRequest"));
    }

    /**
     * 写响应
     *
     * @param response
     * @param resp
     */
    public static void writeResponse(HttpServletResponse response, Response resp) {
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = null;
        try {
            writer = response.getWriter();
            writer.write(JSONObject.toJSONString(resp));
            writer.flush();
        } catch (Exception e) {
            log.error("写响应异常", e);
        } finally {
            if (writer != null) {
                writer.close();
            }
        }
    }
}
