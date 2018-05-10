package com.geminit.service;

import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;

import java.util.Map;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

public interface ManageService {

    void insertNews(News news) throws Exception;

    void insertLaw(Law law) throws Exception;

    void insertKnowledge(Knowledge knowledge) throws Exception;

}
