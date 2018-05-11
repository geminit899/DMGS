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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        //listenerService.updatePM2_5();

        JSONArray nlltp = indexService.getAllCityNLLTP();
        JSONArray earthquakeInfo = indexService.getEarthquakeInfo();
        Map<String, double[]> geocoordMap=new HashMap<>();

        insertIntoGeocoordMapByList(nlltp,geocoordMap);
        insertIntoGeocoordMapByList(earthquakeInfo,geocoordMap);
        JSONObject geoJsonObject = new JSONObject();
        geoJsonObject.putAll(geocoordMap);

        List<News> newsList = indexService.getIndexNews();
        List<Law> lawList = indexService.getIndexLaws();
        List<Knowledge> knowledgeList = indexService.getIndexKnowledges();
        List<String> shareList = indexService.getResourceNames();

        model.addAttribute("nlltp", nlltp);
        model.addAttribute("earthquakeInfo", earthquakeInfo);
        model.addAttribute("geoJsonObject", geoJsonObject);
        model.addAttribute("newsList", newsList);
        model.addAttribute("lawList", lawList);
        model.addAttribute("knowledgeList", knowledgeList);
        model.addAttribute("shareList", shareList);

        return "index";

    }

    private void insertIntoGeocoordMapByList(JSONArray jsonArray, Map<String, double[]> geocoordMap){
        for ( int i = 0; i < jsonArray.size(); i++ ) {
            JSONObject jsonObject = (JSONObject)jsonArray.get(i);
            double lng = Double.parseDouble(jsonObject.get("lng").toString());
            double lat = Double.parseDouble(jsonObject.get("lat").toString());
            double[] location = { lng, lat };
            String name = jsonObject.get("name").toString();
            geocoordMap.put( name, location);
        }
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
