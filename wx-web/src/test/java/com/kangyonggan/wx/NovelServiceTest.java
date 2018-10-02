package com.kangyonggan.wx;

import com.kangyonggan.wx.service.NovelService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author kangyonggan
 * @since 10/2/18
 */
public class NovelServiceTest extends AbstractTest {

    @Autowired
    private NovelService novelService;

    @Test
    public void testPullNovel() {
        novelService.pullNovel(2722);
    }

}
