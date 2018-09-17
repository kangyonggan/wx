package com.kangyonggan.wx.config;

import com.kangyonggan.freemarker.BlockDirective;
import com.kangyonggan.freemarker.ExtendsDirective;
import com.kangyonggan.freemarker.OverrideDirective;
import com.kangyonggan.freemarker.SuperDirective;
import com.kangyonggan.wx.freemarker.DictTag;
import com.kangyonggan.wx.freemarker.EnumTag;
import com.kangyonggan.wx.freemarker.FuncTag;
import freemarker.template.TemplateModelException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

/**
 * @author kangyonggan
 * @since 8/6/18
 */
@Configuration
public class FreemarkerConfigure {

    @Autowired
    freemarker.template.Configuration configuration;

    @Autowired
    private DictTag dictTag;

    @Autowired
    private EnumTag enumTag;

    @Value("${app.name}")
    private String appName;

    @PostConstruct
    public void setSharedVariable() throws TemplateModelException {
        configuration.setSharedVariable("block", new BlockDirective());
        configuration.setSharedVariable("override", new OverrideDirective());
        configuration.setSharedVariable("extends", new ExtendsDirective());
        configuration.setSharedVariable("super", new SuperDirective());

        configuration.setSharedVariable("func", new FuncTag());
        configuration.setSharedVariable("enum", enumTag);
        configuration.setSharedVariable("dict", dictTag);
        configuration.setSharedVariable("appName", appName);
    }

}
