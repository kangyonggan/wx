package com.kangyonggan.wx;

import com.kangyonggan.wx.service.NovelService;
import com.kangyonggan.wx.service.SectionService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;

/**
 * @author kangyonggan
 * @since 10/2/18
 */
public class NovelServiceTest extends AbstractTest {

    @Autowired
    private NovelService novelService;

    @Autowired
    private SectionService sectionService;

    @Test
    public void testPullNovels() {
        novelService.pullNovels();
    }

    @Test
    public void testPullNovel() {
        // 逆天邪神
//        novelService.pullNovel(2722);
        // 圣墟
//        novelService.pullNovel(12564);
        // 充个会员当武神
        novelService.pullNovel("81968");
    }

    @Test
    public void testPullSections() throws IOException {
//        sectionService.updateSections(2722);
//        sectionService.updateSections(12564);
//        sectionService.updateSections(81968);
        sectionService.updateSections("106513");
        System.in.read();
    }

}
