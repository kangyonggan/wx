package com.kangyonggan.wx.controller.api;

import com.alibaba.fastjson.JSONObject;
import com.kangyonggan.app.util.HttpUtil;
import com.kangyonggan.common.Response;
import com.kangyonggan.wx.controller.BaseController;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author kangyonggan
 * @since 9/25/18
 */
@RestController
@RequestMapping("wx")
@Log4j2
public class WxController extends BaseController {

    @Value("${wx.appid}")
    private String appid;

    @Value("${wx.secret}")
    private String secret;

    /**
     * 获取微信的openid
     *
     * @param jsCode
     * @return
     */
    @GetMapping("getOpenId")
    public Response getOpenId(String jsCode) {
        Response response = Response.getSuccessResponse();
        try {
            String res = HttpUtil.get("https://api.weixin.qq.com/sns/jscode2session",
                    "appid=" + appid + "&secret=" + secret + "&js_code=" + jsCode + "&grant_type=authorization_code");
            log.info("获取openid响应：{}", res);
            JSONObject jsonObject = JSONObject.parseObject(res);
            response.put("openid", jsonObject.getString("openid"));
            response.put("sessionKey", jsonObject.getString("session_key"));
        } catch (Exception e) {
            log.error("获取openid异常", e);
            response.failure("获取openid异常");
        }

        return response;
    }

}
