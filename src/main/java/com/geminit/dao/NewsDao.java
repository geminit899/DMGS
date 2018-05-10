package com.geminit.dao;

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

    News getNewsById(String id);

    News getLatestNews();

    void updateNews(@Param("id")String id, @Param("title")String title, @Param("time")String time, @Param("content")String content);

    void insertNews(@Param("title")String title, @Param("time")String time, @Param("content")String content);

    void deleteNewsById(String id);

}
