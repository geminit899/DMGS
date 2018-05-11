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
import java.io.*;
import java.util.ArrayList;
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
    @RequestMapping("/testUpload")
    public String testUpload(Model model, HttpServletRequest request){

        String path = "/Users/geminit/未命名文件夹/xlsx/";

        File fdir = new File(path);
        File[] allFile = fdir.listFiles();

        for (int i=0; i<allFile.length; i++){
            String name = allFile[i].getName();
            if(name.charAt(0) == '.' || name.charAt(0) == '~')    //过滤类似 .DS_Store 的文件
                continue;
            if (allFile[i].isFile()){   //判断是否为文件
                byte[] content = new byte[0];
                try {
                    File newFile = new File( path + name );
                    FileInputStream fin = new FileInputStream(newFile);
                    BufferedInputStream bis = new BufferedInputStream(fin);
                    byte[] slice = new byte[10240];
                    int flag = 0;

                    while( ( flag = bis.read(slice) ) != -1 ){
                        byte[] oldContent = content;
                        content = new byte[ content.length + flag ];
                        System.arraycopy(oldContent, 0, content, 0, oldContent.length);
                        System.arraycopy(slice, 0, content, oldContent.length, flag);
                    }

                    resourceDao.insertResource(name, content);

                } catch ( Exception e ) {
                    e.printStackTrace();
                    continue;
                }
            }
        }

        return null;
    }

    //映射一个action
    @RequestMapping("/manageShare")
    public String manageShare(Model model, HttpServletRequest request) {

        int currentPage = 1;

        if ( request.getParameter("page") != null )
            currentPage = Integer.parseInt( request.getParameter("page") );

        int start = (currentPage - 1) * 20;

        List<String> resourceName;
        int totalNum = 0;

        try {
            resourceName = resourceDao.getResourceName(start,10);
            totalNum = resourceDao.getAllResourceNum();
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        int pageNum;

        if( totalNum%10 == 0 )
            pageNum = totalNum/10;
        else
            pageNum = totalNum/10 + 1;

        model.addAttribute("list", resourceName);
        model.addAttribute("prefix", "share");
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalNum", totalNum);
        model.addAttribute("pageNum", pageNum);

        return "back/manageShare";
    }

    @RequestMapping("/manageShare/check")
    @ResponseBody
    public String check(HttpServletRequest request) {

        String name = request.getParameter("name");
        int size;

        try {
            size = resourceDao.getResourceByName(name).size();
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        if ( size == 0 )
            return "success";
        else
            return "error";
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
            request.getSession().removeAttribute(name);
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }
        return "success";
    }

    @RequestMapping("/manageShare/delete")
    @ResponseBody
    public String delete(HttpServletRequest request) {

        String name = request.getParameter("name");

        try {
            if ( request.getSession().getAttribute(name) != null )
                request.getSession().removeAttribute(name);
            else
                if ( resourceDao.getResourceByName(name).size() != 0 )
                    resourceDao.deleteResourceByName(name);
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }
        return "success";
    }
}
