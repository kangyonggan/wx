package com.kangyonggan.wx.controller.web;

import com.kangyonggan.common.web.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author kangyonggan
 * @since 8/6/18
 */
@Controller
@RequestMapping("/")
public class IndexController extends BaseController {

    /**
     * 首页
     *
     * @return
     */
    @GetMapping
    public String index() {
        return "web/index";
    }

}
