package com.geminit.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.CityDao;
import com.geminit.dao.EarthquakeDao;
import com.geminit.dao.UserDao;
import com.geminit.entity.City;
import com.geminit.entity.Earthquake;
import com.geminit.service.IndexService;
import com.geminit.util.PasswordUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public List<Map> getAllCityLLT(){
        List<Map> llt = new ArrayList<>();

        List<City> cities = new ArrayList<>();

        try {
            cities = cityDao.getCities();
        } catch ( Exception e ) {
            return null;
        }

        for (int i = 0; i < cities.size(); i++) {
            String lng = cities.get(i).getLng();
            String lat =  cities.get(i).getLat();
            String temperature = cities.get(i).getTemperature();

            Map map = new HashMap();
            map.put("lng", lng);
            map.put("lat", lat);
            map.put("temperature", temperature);

            llt.add(map);
        }

        return llt;
    }

    @Override
    public List<Map> getEarthquakeInfo() {

        List<Map> earthquakeInfo = new ArrayList<>();

        List<Earthquake> earthquakeList = new ArrayList<>();

        try {
            earthquakeList = earthquakeDao.getEarthquakeInfo();
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        for ( int i = 0; i < earthquakeList.size(); i++ ) {

            Earthquake earthquake = earthquakeList.get(i);

            Map map = new HashMap();
            map.put("name", earthquake.getName());
            map.put("lat", earthquake.getLat());
            map.put("lng", earthquake.getLng());
            map.put("time", earthquake.getTime());
            earthquakeInfo.add(map);
        }

        return earthquakeInfo;
    }

}
