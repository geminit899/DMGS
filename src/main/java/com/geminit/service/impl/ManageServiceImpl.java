package com.geminit.service.impl;

import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;
import com.geminit.service.ManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class ManageServiceImpl implements ManageService {

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    @Override
    public void insertNews(News news) throws Exception {
        String title = news.getTitle();
        String content = news.getContent();
        String time = news.getTime();

        newsDao.insertNews(title, content, time);
    }

    @Override
    public void insertLaw(Law law) throws Exception {
        String title = law.getTitle();
        String content = law.getContent();
        String time = law.getTime();

        lawDao.insertLaws(title, content, time);
    }

    @Override
    public void insertKnowledge(Knowledge knowledge) throws Exception {
        String title = knowledge.getTitle();
        String content = knowledge.getContent();
        String time = knowledge.getTime();

        knowledgeDao.insertKnowledges(title, content, time);
    }


}
