package com.kangyonggan.wx.controller;

import com.kangyonggan.app.util.DateUtil;
import com.kangyonggan.app.util.FileUpload;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * @author kangyonggan
 * @since 5/4/18
 */
@Controller
@RequestMapping("file")
@Log4j2
public class FileUploadController {

    /**
     * 文件跟路径
     */
    @Value("${app.file.upload}")
    private String fileUploadPath;

    /**
     * 图片上传
     *
     * @param file    文件
     * @param request 请求
     * @return 响应
     */
    @PostMapping("upload")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        ServletContext context = request.getServletContext();

        //上传本地文件
        try {
            String fileName = DateUtil.formatNowToDate() + UUID.randomUUID().toString().replaceAll("-", "");
            // 上传到本地
            FileUpload.upload(fileUploadPath, fileName, file);

            // 上传到文件服务器
            fileName += "." + FilenameUtils.getExtension(file.getOriginalFilename());
            return context.getContextPath() + "/upload/" + fileName;
        } catch (Exception e) {
            log.error("编辑器上传文件失败", e);
        }

        return null;
    }
}
