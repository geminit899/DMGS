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
public class DisasterController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    //映射一个action
    @RequestMapping("/disaster")
    public String disaster(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null )
            return null;

        String prefix = request.getParameter("prefix");
        String currentPage = "1";

        if ( request.getParameter("page") != null )
            currentPage = request.getParameter("page");
        String type = "";

        try {
            switch (prefix){
                case "temperature":
                    type = "温度监测";
                    break;
                case "taifeng":
                    type = "台风监测";
                    break;
                case "pm2_5":
                    type = "空气监测";
                    break;
                case "earthquake":
                    type = "地震监测";
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        model.addAttribute("prefix", prefix);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("type", type);

        return "disaster";
    }

}
