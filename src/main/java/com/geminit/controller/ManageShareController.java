package com.geminit.controller;

import com.geminit.dao.ResourceDao;
import com.geminit.util.MergeByteArray;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ManageShareController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    ResourceDao resourceDao;

    //映射一个action
    @RequestMapping("/manageShare")
    public String manageShare(Model model, HttpServletRequest request) {


        model.addAttribute("prefix", "aboutUs");

        return "back/manageShare";
    }

    @RequestMapping("/manageShare/upload")
    @ResponseBody
    public String upload(@RequestParam("slice")MultipartFile slice, @RequestParam("name")String name, HttpServletRequest request) {

        try {
            byte[] newSlice = slice.getBytes();
            if ( request.getSession().getAttribute(name) == null ) {
                //第一次上传
                request.getSession().setAttribute(name, newSlice);
            } else {
                //中间上传
                byte[] oldSlice = (byte[]) request.getSession().getAttribute(name);
                newSlice = MergeByteArray.merge(newSlice, oldSlice);
                request.getSession().setAttribute(name, newSlice);
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }
        return "success";
    }

    @RequestMapping("/manageShare/merge")
    @ResponseBody
    public String merge(@RequestParam("name")String name, HttpServletRequest request) {

        try {
            byte[] file = (byte[]) request.getSession().getAttribute(name);
            resourceDao.insertResource(name, file);
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }
        return "success";
    }
}
