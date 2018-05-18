package com.geminit.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.NewsDao;
import com.geminit.entity.MainNews;
import com.geminit.service.DisasterService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class DisasterController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    DisasterService disasterService;

    @Autowired
    NewsDao newsDao;

    //映射一个action
    @RequestMapping("/disaster")
    public String disaster(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null )
            return null;

        String prefix = request.getParameter("prefix");

        Map<String, double[]> geocoordMap = disasterService.getGeocoordMapByPrefix(prefix);
        JSONObject geoJsonObject = new JSONObject();
        geoJsonObject.putAll(geocoordMap);

        JSONArray jsonArray = disasterService.getJSONArrayByPrefix(prefix);

        String type = disasterService.getTyprByPrefix(prefix);

        JSONArray listArray = disasterService.getList(prefix);

        List<MainNews> leftSideMainNewsList = newsDao.getMainNews();

        model.addAttribute("leftSideMainNewsList", leftSideMainNewsList);
        model.addAttribute("list", listArray);
        model.addAttribute("prefix", prefix);
        model.addAttribute("geoJsonObject", geoJsonObject);
        model.addAttribute("jsonArray", jsonArray);
        model.addAttribute("type", type);

        return "disaster";
    }

}
