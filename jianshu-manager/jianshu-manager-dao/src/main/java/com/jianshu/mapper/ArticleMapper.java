package com.jianshu.mapper;

import com.jianshu.pojo.Article;

import java.util.List;

public interface ArticleMapper {
    //根据文章集id 查询List
    public List<Article> selectArticleByCollectionId(int collcetionId);
}
