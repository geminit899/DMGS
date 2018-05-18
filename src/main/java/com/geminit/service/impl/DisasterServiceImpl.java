package com.geminit.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.*;
import com.geminit.entity.*;
import com.geminit.service.DisasterService;
import com.sun.jmx.snmp.tasks.TaskServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class DisasterServiceImpl implements DisasterService {

    @Autowired
    CityDao cityDao;

    @Autowired
    EarthquakeDao earthquakeDao;

    @Autowired
    TaifengDao taifengDao;

    @Override
    public String getTyprByPrefix(String prefix) {
        String type = "";

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

        return type;
    }

    @Override
    public Map<String, double[]> getGeocoordMapByPrefix(String prefix) {

        Map<String, double[]> geocoordMap = new HashMap<>();

        try {
            if ( prefix.equals("temperature") || prefix.equals("pm2_5") ) {
                List<City> cities = cityDao.getCities();

                for ( int i = 0; i < cities.size(); i++ ) {
                    City city = cities.get(i);
                    double lng = Double.parseDouble(city.getLng());
                    double lat = Double.parseDouble(city.getLat());
                    double[] location = {lng, lat};

                    geocoordMap.put(city.getName(), location);
                }
            } else if ( prefix.equals("taifeng") ) {
                List<String> taifengNames = taifengDao.getTaifengName();

                for ( int i = 0; i < taifengNames.size(); i++ ) {
                    List<Taifeng> thisTaifeng = taifengDao.getTaifengByName( taifengNames.get(i) );

                    for ( int j = 0; j < thisTaifeng.size(); j++ ) {
                        Taifeng taifeng = thisTaifeng.get(j);
                        double lng = Double.parseDouble(taifeng.getLng());
                        double lat = Double.parseDouble(taifeng.getLat());
                        double[] location = {lng, lat};

                        geocoordMap.put(taifeng.getName()+"-"+taifeng.getId(), location);
                    }
                }

            } else if ( prefix.equals("earthquake") ) {
                List<Earthquake> earthquakes = earthquakeDao.getEarthquakeInfo(0, 10);

                for ( int i = 0; i < earthquakes.size(); i++ ) {
                    Earthquake earthquake = earthquakes.get(i);
                    double lng = Double.parseDouble(earthquake.getLng());
                    double lat = Double.parseDouble(earthquake.getLat());
                    double[] location = {lng, lat};

                    geocoordMap.put(earthquake.getName(), location);
                }
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }
        return  geocoordMap;
    }

    @Override
    public JSONArray getJSONArrayByPrefix(String prefix) {
        JSONArray jsonArray = new JSONArray();

        try {
            if ( prefix.equals("temperature") || prefix.equals("pm2_5") ) {
                List<City> cities = cityDao.getCities();

                for ( int i = 0; i < cities.size(); i++ ) {
                    String name = cities.get(i).getName();
                    String lng = cities.get(i).getLng();
                    String lat =  cities.get(i).getLat();
                    String value = "";
                    if ( prefix.equals("temperature") )
                        value = cities.get(i).getTemperature();
                    else if ( prefix.equals("pm2_5") )
                        value = cities.get(i).getPm2_5();

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", name);
                    jsonObject.put("lng", lng);
                    jsonObject.put("lat", lat);
                    jsonObject.put("value", value);
                    jsonObject.put("time", "");

                    jsonArray.add(jsonObject);
                }
            } else if ( prefix.equals("taifeng") ) {
                List<String> taifengNames = taifengDao.getTaifengName();

                for ( int i = 0; i < taifengNames.size(); i++ ) {
                    List<Taifeng> thisTaifeng = taifengDao.getTaifengByName( taifengNames.get(i) );
                    JSONArray thisArray = new JSONArray();

                    for ( int j = 0; j < thisTaifeng.size(); j++ ) {
                        String id = thisTaifeng.get(j).getId();
                        String name = thisTaifeng.get(j).getName();
                        String time = thisTaifeng.get(j).getTime();
                        String degree = thisTaifeng.get(j).getDegree();

                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("name", name+"-"+id);
                        jsonObject.put("time", time);
                        jsonObject.put("degree", degree);
                        thisArray.add(jsonObject);
                    }

                    jsonArray.add(thisArray);
                }
            } else if ( prefix.equals("earthquake") ) {
                List<Earthquake> earthquakes = earthquakeDao.getEarthquakeInfo(0, 10);

                for ( int i = 0; i < earthquakes.size(); i++ ) {

                    Earthquake earthquake = earthquakes.get(i);

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", earthquake.getName());
                    jsonObject.put("lng", earthquake.getLng());
                    jsonObject.put("lat", earthquake.getLat());
                    jsonObject.put("value", earthquake.getDegree());
                    jsonObject.put("time", earthquake.getTime());
                    jsonArray.add(jsonObject);
                }
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }
        return jsonArray;
    }

    @Override
    public JSONArray getList(String prefix) {
        JSONArray jsonArray = new JSONArray();

        switch (prefix) {
            case "temperature":
                List<City> top10TemperatureCities = cityDao.getTop10TemperatureCities();

                for ( int i = 0; i < top10TemperatureCities.size(); i++ ) {

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", top10TemperatureCities.get(i).getName());
                    jsonObject.put("value", top10TemperatureCities.get(i).getTemperature());
                    jsonArray.add(jsonObject);
                }
                break;
            case "pm2_5":
                List<City> top10Pm2_5Cities = cityDao.getTop10Pm2_5Cities();

                for ( int i = 0; i < top10Pm2_5Cities.size(); i++ ) {

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", top10Pm2_5Cities.get(i).getName());
                    jsonObject.put("value", top10Pm2_5Cities.get(i).getPm2_5());
                    jsonArray.add(jsonObject);
                }
                break;
            case "taifeng":
                List<Taifeng> taifengs = taifengDao.getStrongestTaifeng();

                for ( int i = 0; i < taifengs.size(); i++ ) {

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", taifengs.get(i).getName());
                    jsonObject.put("time", taifengs.get(i).getTime());
                    jsonObject.put("value", taifengs.get(i).getDegree());
                    jsonArray.add(jsonObject);
                }
                break;
            case "earthquake":
                List<Earthquake> earthquakes = earthquakeDao.getStrongestEarthquake();

                for ( int i = 0; i < earthquakes.size(); i++ ) {

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("name", earthquakes.get(i).getName());
                    jsonObject.put("time", earthquakes.get(i).getTime());
                    jsonObject.put("value", earthquakes.get(i).getDegree());
                    jsonArray.add(jsonObject);
                }
                break;
        }

        return jsonArray;
    }
}
