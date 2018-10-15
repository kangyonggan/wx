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
        // 逆天邪神2722
//        novelService.pullNovel(2722);
        // 圣墟12564
//        novelService.pullNovel(12564);
        // 充个会员当武神37_37457
//        novelService.pullNovel("37_37457");
        // 灵剑尊66788
//        novelService.pullNovel("66788");
        // 灵魂客栈774
        novelService.pullNovel("774");
    }

    @Test
    public void testPullSections() throws IOException {
//        sectionService.updateSections(2722);
//        sectionService.updateSections(12564);
//        sectionService.updateSections(81968);
//        sectionService.updateSections("37_37457");
//        sectionService.updateSections("66788");
        sectionService.updateSections("774");
        System.in.read();
    }

}
