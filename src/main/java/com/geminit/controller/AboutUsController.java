package com.geminit.controller;

import com.geminit.dao.AboutUsDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.MainNews;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class AboutUsController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    AboutUsDao aboutUsDao;

    @Autowired
    NewsDao newsDao;

    //映射一个action
    @RequestMapping("/aboutUs")
    public String lawStatement(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null)
            return null;

        String prefix = request.getParameter("prefix");
        String content = new String();
        String type = new String();

        try {
            switch (prefix){
                case "lawStatement":
                    content = aboutUsDao.getLawStatement();
                    type = "法律声明";
                    break;
                case "privacyProtection":
                    content = aboutUsDao.getPrivacyProtection();
                    type = "隐私保护";
                    break;
                case "websiteMap":
                    content = aboutUsDao.getWebsiteMap();
                    type = "网站地图";
                    break;
                case "contactUs":
                    content = aboutUsDao.getContactUs();
                    type = "联系我们";
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        List<MainNews> leftSideMainNewsList = newsDao.getMainNews();

        model.addAttribute("leftSideMainNewsList", leftSideMainNewsList);
        model.addAttribute("prefix", prefix);
        model.addAttribute("type", type);
        model.addAttribute("content", content);

        return "aboutUs";
    }
}
