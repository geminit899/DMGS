package com.geminit.service.impl;

import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;
import com.geminit.service.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-8
 * @modify 2018-5-8
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class PageServiceImpl implements PageService {

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    @Override
    public List<News> getNewsByPage(int page, int numPerPage) {
        List<News> news;

        int start = (page - 1) * numPerPage;

        try {
            news = newsDao.getNews(start,numPerPage);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return news;
    }

    @Override
    public List<Law> getLawByPage(int page, int numPerPage) {
        List<Law> laws;

        int start = (page - 1) * numPerPage;

        try {
            laws = lawDao.getLaws(start,numPerPage);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return laws;
    }

    @Override
    public List<Knowledge> getKnowledgeByPage(int page, int numPerPage) {
        List<Knowledge> knowledges;

        int start = (page - 1) * numPerPage;

        try {
            knowledges = knowledgeDao.getKnowledges(start,numPerPage);
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return knowledges;
    }

}
