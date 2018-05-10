package com.geminit.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.*;
import com.geminit.entity.*;
import com.geminit.service.IndexService;
import com.geminit.util.PasswordUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.jms.Session;
import javax.json.JsonObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-4
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class IndexServiceImpl implements IndexService{


    @Autowired
    UserDao userDao;

    @Autowired
    CityDao cityDao;

    @Autowired
    EarthquakeDao earthquakeDao;

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    @Override
    public boolean login(String name, String password){

        if ( userDao.getUserByName(name) == null)
            return false;

        String salt = userDao.getSaltByName(name);
        String md5 = userDao.getMd5ByName(name);

        String inputMd5 = PasswordUtil.generateMd5BySalt(password, salt);

        if ( md5.equals(inputMd5) )
            return true;
        else
            return false;
    }

    @Override
    public JSONArray getAllCityNLLTP(){

        JSONArray jsonArray = new JSONArray();

        List<City> cities;

        try {
            cities = cityDao.getCities();
        } catch ( Exception e ) {
            return null;
        }

        for (int i = 0; i < cities.size(); i++) {
            String name = cities.get(i).getName();
            String lng = cities.get(i).getLng();
            String lat =  cities.get(i).getLat();
            String temperature = cities.get(i).getTemperature();
            String pm2_5 = cities.get(i).getPm2_5();

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", name);
            jsonObject.put("lng", lng);
            jsonObject.put("lat", lat);
            jsonObject.put("temperature", temperature);
            jsonObject.put("pm2_5", pm2_5);

            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }

    @Override
    public JSONArray getEarthquakeInfo() {

        JSONArray jsonArray = new JSONArray();

        List<Earthquake> earthquakeList;

        try {
            earthquakeList = earthquakeDao.getEarthquakeInfo(0,10);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        for ( int i = 0; i < earthquakeList.size(); i++ ) {

            Earthquake earthquake = earthquakeList.get(i);

            if ( Double.parseDouble(earthquake.getDegree()) < 3 )
                continue;

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", earthquake.getName());
            jsonObject.put("lat", earthquake.getLat());
            jsonObject.put("lng", earthquake.getLng());
            jsonObject.put("degree", earthquake.getDegree());
            jsonObject.put("time", earthquake.getTime());
            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }

    @Override
    public List<News> getIndexNews(){

        List<News> news;

        try {
            news = newsDao.getNews(0,10);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return news;
    }

    @Override
    public List<Law> getIndexLaws(){

        List<Law> laws;

        try {
            laws = lawDao.getLaws(0, 5);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return laws;
    }

    @Override
    public List<Knowledge> getIndexKnowledges(){

        List<Knowledge> knowledges;

        try {
            knowledges = knowledgeDao.getKnowledges(0, 5);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return knowledges;
    }

}
