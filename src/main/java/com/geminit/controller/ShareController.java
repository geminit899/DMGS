package com.geminit.controller;

import com.geminit.dao.ResourceDao;
import com.geminit.entity.Resource;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ShareController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    ResourceDao resourceDao;

    //映射一个action
    @RequestMapping("/share")
    public String share(Model model, HttpServletRequest request) {

        int currentPage = 1;
        int num;

        if ( request.getParameter("page") != null )
            currentPage = Integer.parseInt( request.getParameter("page") );

        List<String> resourceName;

        int numPerPage = 10;

        int start = (currentPage - 1) * numPerPage;

        try {
            resourceName = resourceDao.getResourceName(start, numPerPage);
            num = resourceDao.getAllResourceNum();
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        int pageNum;

        if( num%10 == 0 )
            pageNum = num/10;
        else
            pageNum = num/10 + 1;


        model.addAttribute("type", "数据分享");
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("list", resourceName);

        return "share";
    }

    @RequestMapping("/share/download")
    @ResponseBody
    public void download(@RequestParam("name")String name, HttpServletResponse response) {

        List<Resource> resources = resourceDao.getResourceByName(name);

        Resource resource = resources.get(0);

        byte[] content = resource.getContent();

        try {
            // 以流的形式下载文件
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + name + "\"");
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            toClient.write(content);
            toClient.flush();
            toClient.close();
        } catch ( Exception e ) {
            e.printStackTrace();
        }

    }

}
