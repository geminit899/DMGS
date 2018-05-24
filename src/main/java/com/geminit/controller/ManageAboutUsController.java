package com.geminit.controller;

import com.geminit.dao.AboutUsDao;
import com.geminit.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ManageAboutUsController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    AboutUsDao aboutUsDao;

    //映射一个action
    @RequestMapping("/manageAboutUs")
    public String manageAboutUs(Model model, HttpServletRequest request) {

        String lawStatement = new String();
        String privacyProtection = new String();
        String websiteMap = new String();
        String contactUs = new String();

        try {
            lawStatement = aboutUsDao.getLawStatement();
            privacyProtection = aboutUsDao.getPrivacyProtection();
            websiteMap = aboutUsDao.getWebsiteMap();
            contactUs = aboutUsDao.getContactUs();
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        model.addAttribute("user", user.getName());

        model.addAttribute("prefix", "aboutUs");
        model.addAttribute("lawStatement", lawStatement);
        model.addAttribute("privacyProtection", privacyProtection);
        model.addAttribute("websiteMap", websiteMap);
        model.addAttribute("contactUs", contactUs);

        return "back/manageAboutUs";
    }

    @RequestMapping("/manageAboutUs/edit")
    @ResponseBody
    public String edit(HttpServletRequest request, HttpServletResponse response){

        String prefix = request.getParameter("prefix");
        String content = request.getParameter("content");

        try {
            switch (prefix){
                case "lawStatement":
                    aboutUsDao.setLawStatement(content);
                    break;
                case "privacyProtection":
                    aboutUsDao.setPrivacyProtection(content);
                    break;
                case "websiteMap":
                    aboutUsDao.setWebsiteMap(content);
                    break;
                case "contactUs":
                    aboutUsDao.setContactUs(content);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

}
