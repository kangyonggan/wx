package cn.net.crazykart.controller;

import cn.net.crazykart.constants.EmailType;
import cn.net.crazykart.model.Email;
import cn.net.crazykart.model.UserProfile;
import cn.net.crazykart.payment.service.RespRelService;
import cn.net.crazykart.service.*;
import cn.net.crazykart.util.IdNoUtil;
import com.kangyonggan.app.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @author kangyonggan
 * @since 8/9/18
 */
@Controller
@RequestMapping("validate")
public class ValidateController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private DictService dictService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private RespRelService respRelService;

    @Autowired
    private UserProfileService userProfileService;

    @Autowired
    private EmailService emailService;

    @Value("${email.expireTime}")
    private String emailExpireTime;

    /**
     * 校验手机号是否可用
     *
     * @param mobileNo
     * @param oldMobileNo
     * @return
     */
    @PostMapping("mobileNo")
    @ResponseBody
    public boolean validateMobileNo(@RequestParam("mobileNo") String mobileNo,
                                    @RequestParam(value = "oldMobileNo", required = false, defaultValue = "") String oldMobileNo) {
        if (oldMobileNo.equals(mobileNo)) {
            // 当修改手机号时，老的手机号和新的手机号一致，表示没修改，所以算作可用
            return true;
        }

        return !userService.existsMobileNo(mobileNo);
    }

    /**
     * 校验角色代码是否可用
     *
     * @param roleCode
     * @param oldRoleCode
     * @return
     */
    @PostMapping("roleCode")
    @ResponseBody
    public boolean validateRoleCode(@RequestParam("roleCode") String roleCode,
                                    @RequestParam(value = "oldRoleCode", required = false, defaultValue = "") String oldRoleCode) {
        if (oldRoleCode.equals(roleCode)) {
            // 当修改角色时，老的角色代码和新的角色代码一致，表示没修改，所以算作可用
            return true;
        }

        return !roleService.existsRoleCode(roleCode);
    }

    /**
     * 校验菜单代码是否可用
     *
     * @param menuCode
     * @param oldMenuCode
     * @return
     */
    @PostMapping("menuCode")
    @ResponseBody
    public boolean validateMenuCode(@RequestParam("menuCode") String menuCode,
                                    @RequestParam(value = "oldMenuCode", required = false, defaultValue = "") String oldMenuCode) {
        if (oldMenuCode.equals(menuCode)) {
            // 当修改菜单时，老的菜单代码和新的菜单代码一致，表示没修改，所以算作可用
            return true;
        }

        return !menuService.existsMenuCode(menuCode);
    }

    /**
     * 校验字典代码是否可用
     *
     * @param dictType
     * @param dictCode
     * @param oldDictCode
     * @return
     */
    @PostMapping("dictCode")
    @ResponseBody
    public boolean validateDictCode(@RequestParam("dictType") String dictType, @RequestParam("dictCode") String dictCode,
                                    @RequestParam(value = "oldDictCode", required = false, defaultValue = "") String oldDictCode) {
        if (oldDictCode.equals(dictCode)) {
            // 当修改字典时，老的字典代码和新的字典代码一致，表示没修改，所以算作可用
            return true;
        }

        return !dictService.existsDictCode(dictType, dictCode);
    }

    /**
     * 校验栏目代码是否可用
     *
     * @param categoryCode
     * @param oldCategoryCode
     * @return
     */
    @PostMapping("categoryCode")
    @ResponseBody
    public boolean validateCategoryCode(@RequestParam("categoryCode") String categoryCode,
                                    @RequestParam(value = "oldCategoryCode", required = false, defaultValue = "") String oldCategoryCode) {
        if (oldCategoryCode.equals(categoryCode)) {
            // 当修改字典时，老的字典代码和新的字典代码一致，表示没修改，所以算作可用
            return true;
        }

        return !categoryService.existsCategoryCode(categoryCode);
    }

    /**
     * 校验响应码是否可用
     *
     * @param channelNo
     * @param respCo
     * @param oldRespCo
     * @return
     */
    @PostMapping("respCo")
    @ResponseBody
    public boolean validateRespCo(@RequestParam("channelNo") String channelNo, @RequestParam("respCo") String respCo,
                                    @RequestParam(value = "oldRespCo", required = false, defaultValue = "") String oldRespCo) {
        if (oldRespCo.equals(respCo)) {
            // 当修改响应码时，老的响应码和新的响应码一致，表示没修改，所以算作可用
            return true;
        }

        return !respRelService.existsRespCo(channelNo, respCo);
    }

    /**
     * 校验电子邮箱是否可用
     *
     * @param email
     * @param oldEmail
     * @return
     */
    @PostMapping("email")
    @ResponseBody
    public boolean validateEmail(@RequestParam("email") String email,
                                 @RequestParam(value = "oldEmail", required = false, defaultValue = "") String oldEmail) {
        if (oldEmail.equals(email)) {
            // 当修改电子邮箱时，老的电子邮箱和新的电子邮箱一致，表示没修改，所以算作可用
            return true;
        }

        return !userProfileService.existsEmail(email);
    }

    /**
     * 校验身份证是否可用
     *
     * @param idNo
     * @return
     */
    @PostMapping("idNo")
    @ResponseBody
    public boolean validateIdNo(@RequestParam("idNo") String idNo) {
        return IdNoUtil.isIdNo18(idNo);
    }

    /**
     * 邮箱验证
     *
     * @param token
     * @param model
     * @return
     */
    @GetMapping("email")
    public String validateEmail(@RequestParam("token") String token, Model model) {
        Email email = emailService.findEmailByToken(token);
        if (email != null) {
            // 判断是否失效
            if (new Date().after(DateUtil.plusHours(email.getCreatedTime(), Long.parseLong(emailExpireTime)))) {
                return "web/email/invalid-email";
            }

            if (EmailType.BIND.getType().equals(email.getType())) {
                // 判断此用户是不是已经绑定了
                UserProfile userProfile = userProfileService.findUserProfileByUserId(email.getUserId());
                if (userProfile.getEmailValid() == 1) {
                    model.addAttribute("email", userProfile.getEmail());

                    // 逻辑删除邮件
                    emailService.deleteEmail(email);
                    return "web/email/already-bind-self";
                }

                // 判断邮箱是否已被别人绑定了
                if (userProfileService.existsEmail(email.getToEmail())) {
                    model.addAttribute("email", email.getToEmail());

                    // 逻辑删除邮件
                    emailService.deleteEmail(email);
                    return "web/email/already-bind";
                }

                // 绑定邮箱
                model.addAttribute("email", email.getToEmail());
                emailService.bindEmail(email);
                return "web/email/bind-success";
            } else if (EmailType.FORGOT.getType().equals(email.getType())) {
                // TODO 找回密码邮件
            }

            // 逻辑删除邮件
            emailService.deleteEmail(email);
            // 未知类型的邮件
            return "web/email/unknown-email";
        } else {
            // 链接不存在
            return "web/email/empty-email";
        }
    }

}
