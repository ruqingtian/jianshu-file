package com.jianshu.mapper;

import com.jianshu.pojo.Article;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface ArticleMapper {
    //根据文章集id 查询List
    public List<Article> selectArticleByCollectionId(int collcetionId);
    //根据文章id 查询文章
    public Article selectArticleById(int id);
    //根据文章id 修改文章
    public void updataArticleById(Map map);
}
