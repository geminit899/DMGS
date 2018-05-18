package com.geminit.controller;

import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.MainNews;
import com.geminit.entity.News;
import com.geminit.service.PageService;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-8
 * @modify 2018-5-8
 */

@Controller
public class PageController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    PageService pageService;

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    //映射一个action
    @RequestMapping("/page")
    public String page(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null)
            return null;

        int currentPage = 1;

        if ( request.getParameter("page") != null )
            currentPage = Integer.parseInt( request.getParameter("page") );

        String prefix = request.getParameter("prefix");

        int num = 0;

        try {
            switch (prefix){
                case "news":
                    List<News> newsList = pageService.getNewsByPage(currentPage, 20);
                    num = newsDao.getTotalNewsNum();

                    model.addAttribute("type", "新闻快讯");
                    model.addAttribute("list", newsList);
                    break;
                case "law":
                    List<Law> lawList = pageService.getLawByPage(currentPage, 20);
                    num = lawDao.getTotalLawNum();

                    model.addAttribute("type", "政策法规");
                    model.addAttribute("list", lawList);
                    break;
                case "knowledge":
                    List<Knowledge> knowledgeList = pageService.getKnowledgeByPage(currentPage, 20);
                    num = knowledgeDao.getTotalKnowledgeNum();

                    model.addAttribute("type", "科普宣传");
                    model.addAttribute("list", knowledgeList);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        int pageNum;

        if( num%20 == 0 )
            pageNum = num/20;
        else
            pageNum = num/20 + 1;

        List<MainNews> leftSideMainNewsList = newsDao.getMainNews();

        model.addAttribute("leftSideMainNewsList", leftSideMainNewsList);
        model.addAttribute("prefix", prefix);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageNum", pageNum);

        return "page";
    }
}
