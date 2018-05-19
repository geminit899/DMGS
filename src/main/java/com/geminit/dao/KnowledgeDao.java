package com.geminit.dao;

import com.geminit.entity.Knowledge;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Repository
public interface KnowledgeDao {

    int getTotalKnowledgeNum();

    List<Knowledge> getKnowledges(@Param("start")int start, @Param("num")int num);

    List<Knowledge> getKnowledgeByKey(@Param("key")String key);

    Knowledge getKnowledgeById(String id);

    Knowledge getLatestKnowledge();

    void updateKnowledge(@Param("id")String id, @Param("title")String title, @Param("time")String time, @Param("content")String content);

    void insertKnowledges(@Param("title")String title, @Param("time")String time, @Param("content")String content);

    void deleteKnowledgeById(String id);

}
