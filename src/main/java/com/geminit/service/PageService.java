package com.geminit.service;

import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-8
 * @modify 2018-5-8
 */

public interface PageService {

    List<News> getNewsByPage(int page, int numPerPage);

    List<Law> getLawByPage(int page, int numPerPage);

    List<Knowledge> getKnowledgeByPage(int page, int numPerPage);

}
