package com.geminit.service;

import com.alibaba.fastjson.JSONArray;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;

import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

public interface DisasterService {

    Map<String, double[]> getGeocoordMapByPrefix(String prefix);

    JSONArray getJSONArrayByPrefix(String prefix);

    JSONArray getList(String prefix);

    String getTyprByPrefix(String prefix);

}
