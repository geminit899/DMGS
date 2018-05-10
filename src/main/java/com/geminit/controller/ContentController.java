package com.geminit.controller;

import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ContentController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    //映射一个action
    @RequestMapping("/content")
    public String content(Model model, HttpServletRequest request) {

        if ( request.getParameter("type") == null || request.getParameter("id") == null )
            return null;

        String type = request.getParameter("type");
        String id = request.getParameter("id");

        try {
            switch (type){
                case "news":
                    News news = newsDao.getNewsById(id);
                    model.addAttribute("obj", news);
                    break;
                case "law":
                    Law law = lawDao.getLawById(id);
                    model.addAttribute("obj", law);
                    break;
                case "knowledge":
                    Knowledge knowledge = knowledgeDao.getKnowledgeById(id);
                    model.addAttribute("obj", knowledge);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        return "content";
    }

}
