package com.geminit.controller;

import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.*;
import com.geminit.service.PageService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-14
 * @modify 2018-5-14
 */

@Controller
public class ManageMainNewsController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    NewsDao newsDao;

    //映射一个action
    @RequestMapping("/manageMainNews")
    public String manageMainNews(Model model, HttpServletRequest request) {

        List<MainNews> neswList;

        List<String> todayNews;

        try {

            neswList = newsDao.getMainNews();

            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String time = sdf.format(date);

            todayNews = newsDao.getTodayNews(time);

        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        model.addAttribute("user", user.getName());

        model.addAttribute("list", neswList);
        model.addAttribute("todayNews", todayNews);

        return "back/manageMainNews";
    }

    @RequestMapping("/manageMainNews/add")
    @ResponseBody
    public String add(HttpServletRequest request, HttpServletResponse response){

        String name = request.getParameter("name");
        String img = request.getParameter("img");

        try {
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String time = sdf.format(date);

            News news = newsDao.getTodayNewsByName(name, time);

            String id = Integer.toString(news.getId());

            newsDao.insertMainNews(id, img);

        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

    @RequestMapping("/manageMainNews/edit")
    @ResponseBody
    public String edit(HttpServletRequest request, HttpServletResponse response){

        String id = request.getParameter("id");
        String href = request.getParameter("href");

        try {

            newsDao.updateMainNews(id, href);

        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

    @RequestMapping("/manageMainNews/delete")
    @ResponseBody
    public String delete(HttpServletRequest request, HttpServletResponse response){

        String id = request.getParameter("id");

        try {

            newsDao.deleteMainNews(id);

        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

}
