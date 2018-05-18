package com.geminit.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.entity.City;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;

import java.util.List;
import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-4
 */

public interface IndexService {

    String getSalt(String userName);

    boolean login(String name, String password);

    JSONArray getDataList(String type);

    List<News> getIndexNews();

    List<Law> getIndexLaws();

    List<Knowledge> getIndexKnowledges();

    List<String> getResourceNames();

    JSONArray getIndexImg();

}
