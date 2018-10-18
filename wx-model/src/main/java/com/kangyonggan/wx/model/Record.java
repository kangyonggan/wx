package com.kangyonggan.wx.model;

import java.util.Date;
import javax.persistence.*;

import com.github.ofofs.jca.annotation.Serial;
import lombok.Data;

/**
 * @author kangyonggan
 * @since 8/8/18
 */
@Table(name = "tb_record")
@Data
@Serial
public class Record {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 内容
     */
    private String content;

    /**
     * 图片
     */
    @Column(name = "file_names")
    private String fileNames;

    /**
     * 视频
     */
    @Column(name = "video_names")
    private String videoNames;

    /**
     * openid
     */
    private String openid;

    /**
     * 状态:{0:可用, 1:禁用}
     */
    private Byte status;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;

    /**
     * 更新时间
     */
    @Column(name = "updated_time")
    private Date updatedTime;
}