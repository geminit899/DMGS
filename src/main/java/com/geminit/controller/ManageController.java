package com.geminit.controller;

import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.KnowledgeDao;
import com.geminit.dao.LawDao;
import com.geminit.dao.NewsDao;
import com.geminit.entity.Knowledge;
import com.geminit.entity.Law;
import com.geminit.entity.News;
import com.geminit.entity.User;
import com.geminit.service.PageService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-9
 * @modify 2018-5-9
 */

@Controller
public class ManageController {

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
    @RequestMapping("/manage")
    public String manage(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null)
            return null;

        int currentPage = 1;

        if ( request.getParameter("page") != null )
            currentPage = Integer.parseInt( request.getParameter("page") );

        String prefix = request.getParameter("prefix");

        int totalNum = 0;

        try {
            switch (prefix){
                case "news":
                    List<News> newsList = pageService.getNewsByPage(currentPage, 10);
                    totalNum = newsDao.getTotalNewsNum();

                    model.addAttribute("list", newsList);
                    break;
                case "law":
                    List<Law> lawList = pageService.getLawByPage(currentPage, 10);
                    totalNum = lawDao.getTotalLawNum();

                    model.addAttribute("list", lawList);
                    break;
                case "knowledge":
                    List<Knowledge> knowledgeList = pageService.getKnowledgeByPage(currentPage, 10);
                    totalNum = knowledgeDao.getTotalKnowledgeNum();

                    model.addAttribute("list", knowledgeList);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return null;
        }

        int pageNum;

        if( totalNum%10 == 0 )
            pageNum = totalNum/10;
        else
            pageNum = totalNum/10 + 1;

        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        model.addAttribute("user", user.getName());

        model.addAttribute("prefix", prefix);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalNum", totalNum);
        model.addAttribute("pageNum", pageNum);

        return "back/manage";
    }

    @RequestMapping("/manage/add")
    @ResponseBody
    public String add(HttpServletRequest request, HttpServletResponse response){

        String prefix = request.getParameter("prefix");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String time = request.getParameter("time");

        try {
            switch (prefix){
                case "news":
                    newsDao.insertNews(title, time, content);
                    break;
                case "law":
                    lawDao.insertLaws(title, time, content);
                    break;
                case "knowledge":
                    knowledgeDao.insertKnowledges(title, time, content);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

    @RequestMapping("/manage/getObj")
    @ResponseBody
    public JSONObject getObj(HttpServletRequest request, HttpServletResponse response){

        JSONObject jsonObject = new JSONObject();

        String id = request.getParameter("id");
        String prefix = request.getParameter("prefix");

        try {
            switch (prefix){
                case "news":
                    News news = newsDao.getNewsById(id);
                    jsonObject.put("title", news.getTitle());
                    jsonObject.put("content", news.getContent());
                    jsonObject.put("time", news.getTime());
                    break;
                case "law":
                    Law law = lawDao.getLawById(id);
                    jsonObject.put("title", law.getTitle());
                    jsonObject.put("content", law.getContent());
                    jsonObject.put("time", law.getTime());
                    break;
                case "knowledge":
                    Knowledge knowledge = knowledgeDao.getKnowledgeById(id);
                    jsonObject.put("title", knowledge.getTitle());
                    jsonObject.put("content", knowledge.getContent());
                    jsonObject.put("time", knowledge.getTime());
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return jsonObject;
        }

        jsonObject.put("id", id);

        return jsonObject;
    }

    @RequestMapping("/manage/edit")
    @ResponseBody
    public String edit(HttpServletRequest request, HttpServletResponse response){

        String id = request.getParameter("id");
        String prefix = request.getParameter("prefix");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String time = request.getParameter("time");

        try {
            switch (prefix){
                case "news":
                    newsDao.updateNews(id, title, time, content);
                    break;
                case "law":
                    lawDao.updateLaw(id, title, time, content);
                    break;
                case "knowledge":
                    knowledgeDao.updateKnowledge(id, title, time, content);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

    @RequestMapping("/manage/delete")
    @ResponseBody
    public String delete(HttpServletRequest request, HttpServletResponse response){

        String id = request.getParameter("id");
        String prefix = request.getParameter("prefix");

        try {
            switch (prefix){
                case "news":
                    newsDao.deleteNewsById(id);
                    break;
                case "law":
                    lawDao.deleteLawById(id);
                    break;
                case "knowledge":
                    knowledgeDao.deleteKnowledgeById(id);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

}
