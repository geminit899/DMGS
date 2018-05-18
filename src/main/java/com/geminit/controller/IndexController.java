package com.geminit.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;
import com.geminit.service.IndexService;
import com.geminit.service.ListenerService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-7
 */

@Controller
public class IndexController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    IndexService indexService;

    @Autowired
    ListenerService listenerService;

    //映射一个action
    @RequestMapping("/index")
    public String index(Model model, HttpServletRequest request) {
        JSONArray earthquakeList = indexService.getDataList("earthquake");
        JSONArray taifengList = indexService.getDataList("taifeng");

        List<News> newsList = indexService.getIndexNews();
        List<Law> lawList = indexService.getIndexLaws();
        List<Knowledge> knowledgeList = indexService.getIndexKnowledges();
        List<String> shareList = indexService.getResourceNames() ;

        JSONArray indexImgArray = indexService.getIndexImg();

        model.addAttribute("earthquakeList", earthquakeList);
        model.addAttribute("taifengList", taifengList);
        model.addAttribute("newsList", newsList);
        model.addAttribute("lawList", lawList);
        model.addAttribute("knowledgeList", knowledgeList);
        model.addAttribute("shareList", shareList);
        model.addAttribute("indexImgArray", indexImgArray);

        return "index";

    }

    //映射一个action
    @RequestMapping("/index/login/getSalt")
    @ResponseBody
    public String getSalt(@RequestParam("userName")String userName, HttpServletRequest request) {
        String salt = indexService.getSalt(userName);
        return salt;
    }

    //映射一个action
    @RequestMapping("/index/login")
    @ResponseBody
    public String login(HttpServletRequest request, HttpServletResponse response) {

        String username = request.getParameter("userName");
        String password = request.getParameter("password");

        boolean flag = false;

        try {
            flag = indexService.login(username, password);
        } catch (Exception e){
            e.printStackTrace();
        }

        if ( flag )
            return "success";
        else
            return "error";
    }

    //映射一个action
    @RequestMapping("/logout")
    public void logout(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.sendRedirect("/index");
    }

}
