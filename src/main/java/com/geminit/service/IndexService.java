package com.geminit.service;

import com.alibaba.fastjson.JSONObject;
import com.geminit.entity.City;

import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-4
 */

public interface IndexService {

    boolean login(String name, String password);

    List<Map> getAllCityLLT();

    List<Map> getEarthquakeInfo();

}
