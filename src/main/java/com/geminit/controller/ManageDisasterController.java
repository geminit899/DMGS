package com.geminit.controller;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ManageDisasterController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    //映射一个action
    @RequestMapping("/manageDisaster")
    public String manageDisaster(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null )
            return null;

        String prefix = request.getParameter("prefix");

        switch (prefix){
            case "temperature":
                break;
            case "taifeng":
                break;
            case "pm2_5":
                break;
            case "earthquake":
                break;

        }


        return "back/manageDisaster";
    }
}
