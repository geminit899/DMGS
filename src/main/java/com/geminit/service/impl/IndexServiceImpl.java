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
    TaifengDao taifengDao;

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    @Autowired
    ResourceDao resourceDao;

    @Override
    public String getSalt(String userName){
        String salt = new String();

        try {
            salt = userDao.getSaltByName(userName);
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        if ( salt == null )
            return "error";

        return salt;

    }

    @Override
    public boolean login(String name, String password){
        String md5 = userDao.getMd5ByName(name);

        if ( md5.equals(password) )
            return true;
        else
            return false;
    }

    @Override
    public JSONArray getDataList(String type) {
        JSONArray jsonArray = new JSONArray();
        List<DataList> dataList = new ArrayList<>();

        try {
            switch (type) {
                case "earthquake":
                    dataList = earthquakeDao.getEarthquakeList();
                    int totle = earthquakeDao.getEarthquakeNum();
                    int here = 0;
                    for (int i = 0; i < dataList.size(); i++)
                        here += Integer.parseInt(dataList.get(i).getNum());
                    int left = totle - here;
                    DataList leftData = new DataList();
                    leftData.setValue("其它");
                    leftData.setNum(Integer.toString(left));
                    dataList.add(leftData);
                    break;
                case "taifeng":
                    dataList = taifengDao.getTaifengList();
                    break;
            }

        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        for (int i = 0; i < dataList.size(); i++) {
            JSONObject jsonObject = new JSONObject();
            String value = dataList.get(i).getValue();
            String num = dataList.get(i).getNum();

            jsonObject.put("value", value);
            jsonObject.put("num", num);

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

    @Override
    public List<String> getResourceNames(){

        List<String> resourceName;

        try {
            resourceName = resourceDao.getResourceName(0,10);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return resourceName;
    }

    @Override
    public JSONArray getIndexImg(){

        JSONArray indexImg = new JSONArray();

        List<MainNews> mainNewsList = new ArrayList<>();

        try {
            mainNewsList = newsDao.getMainNews();
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        for ( int i = 0; i < mainNewsList.size(); i++) {
            JSONObject jsonObject = new JSONObject();

            jsonObject.put("img", mainNewsList.get(i).getImg());
            jsonObject.put("a", "/content?type=news&id=" + mainNewsList.get(i).getNews_id());

            indexImg.add(jsonObject);
        }

        return indexImg;
    }
}
