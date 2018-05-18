package com.geminit.controller;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Geminit
 * @create 2018-5-18
 * @modify 2018-5-18
 */

@Controller
public class ResourceNotFoundController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    //映射一个action
    @RequestMapping("/404")
    public String resourceNotFound(Model model, HttpServletRequest request) {
        return "/util/404";
    }

}
