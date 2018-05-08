package com.geminit.controller;

import com.geminit.service.IndexService;
import com.geminit.service.ListenerService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        List<Map> llt = indexService.getAllCityLLT();

        List<Map> earthquakeInfo = indexService.getEarthquakeInfo();

        model.addAttribute("llt", llt);
        model.addAttribute("earthquakeInfo", earthquakeInfo);

        return "index";

    }

    //映射一个action
    @RequestMapping("/index/login")
    @ResponseBody
    public String login(HttpServletRequest request, HttpServletResponse response) {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean flag = false;

        try {
            flag = indexService.login(username, password);
        } catch (Exception e){
            e.printStackTrace();
        }

        if ( flag )
            return "true";
        else
            return "false";
    }

}
