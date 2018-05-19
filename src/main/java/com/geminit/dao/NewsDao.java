package com.geminit.dao;

import com.geminit.entity.MainNews;
import com.geminit.entity.News;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface NewsDao {

    int getTotalNewsNum();

    List<News> getNews(@Param("start")int start, @Param("num")int num);

    List<News> getNewsByKey(@Param("key")String key);

    List<MainNews> getMainNews();

    List<String> getTodayNews(String time);

    News getTodayNewsByName(@Param("title")String title, @Param("time")String time);

    News getNewsById(String id);

    News getLatestNews();

    void updateNews(@Param("id")String id, @Param("title")String title, @Param("time")String time, @Param("content")String content);

    void updateMainNews(@Param("id")String id, @Param("img")String img);

    void insertNews(@Param("title")String title, @Param("time")String time, @Param("content")String content);

    void insertMainNews(@Param("news_id")String news_id, @Param("img")String img);

    void deleteNewsById(String id);

    void deleteMainNews(String id);

}
