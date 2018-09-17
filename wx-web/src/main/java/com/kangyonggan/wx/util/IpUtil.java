package com.kangyonggan.wx.util;

import com.github.ofofs.jca.annotation.Util;
import com.kangyonggan.common.web.ParamsInterceptor;

import javax.servlet.http.HttpServletRequest;

/**
 * @author kangyonggan
 * @since 8/10/18
 */
@Util
public class IpUtil {

    private static final int DEFALUT_PORT = 80;

    /**
     * 获取主机地址
     *
     * @param request
     * @return
     */
    public static String getServerHost(HttpServletRequest request) {
        String path = "http://" + request.getServerName();
        int port = request.getServerPort();
        if (port != DEFALUT_PORT) {
            path += ":" + request.getServerPort();
        }

        return path;
    }

    /**
     * 获取主机地址
     *
     * @return
     */
    public static String getServerHost() {
        return getServerHost(ParamsInterceptor.getRequest());
    }

}
