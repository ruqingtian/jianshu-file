<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/14
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <link rel="stylesheet" href="/css/page.css" type="text/css"/>
    <title>搜索-简书</title>

    <style type="text/css">
        .content{
            position:relative; margin-left:10px; margin-top:50px;
        }
        .all{
            left: 20%;
            position: relative;
        }
        .button{
            font-size: 30px;
        }
        .currentPage{
            background-color: #6ce26c !important;
        }

    </style>
    <script type="text/javascript">
       $(function(){
           var currentPage=1;
           articleShow(currentPage);
        });
       $(".jumpPage").live("click",function () {
           var currentPage=$(this).attr('name');
           currentPage=parseInt(currentPage.slice(4));
           articleShow(currentPage);

       });
       $(".lastPage").live("click",function () {
          var currentPage=$(".currentPage").attr('name');
          currentPage=parseInt(currentPage.slice(4));
          if(currentPage!=1){
              articleShow(currentPage-1);
          }
       });
       $(".nextPage").live("click",function () {
           var totalPage=parseInt($(this).attr('name'));
           var currentPage=$(".currentPage").attr('name');
           currentPage=parseInt(currentPage.slice(4));
           if(currentPage!=totalPage){
               articleShow(currentPage+1);
           }
       });
       function articleShow(currentPage) {
           var content= $("#searchValue").val();
           $("#searchContent").attr("value",content);
           $.ajax({
               type:'POST',
               url:'/search/article',
               data:{"content":content,"currentPage":currentPage},
               success:function (data) {
                   console.log(data);
                   if(data.totalCount==0){
                       $("#content").html("没有查到相关信息");
                   }else {
                       $("#content").html("");
                       $("#contentTitle").append("    " + data.totalCount + "个结果");
                       for (var i = 0; i < data.showList.length; i++) {
                           var str = "<div><a href='javascript:void(0)'><img class='smallImg' src=" + data.showList[i].img + "/>" + data.showList[i].nickName + "</a>" + data.showList[i].dynamicDate + "<br/>" +
                               "" + data.showList[i].title + "<br/>" +
                               "" + data.showList[i].content + "<br/>" +
                               "阅读" + data.showList[i].readNums + "   评论" + data.showList[i].reviewNums + "  喜欢" + data.showList[i].likeNums + "</div>";
                           $("#content").append(str);
                       }
                       $("#changePage").html("");

                       $("#changePage").append("<ul class='pagination'></ul>");
                       var pageStart = "<li><a href='javascript:void(0)' class='lastPage' aria-label='Previous'><span aria-hidden='true'>《</span></li>";
                       $(".pagination").append(pageStart);
                       for (var i = 1; i <= data.totalPage; i++) {
                           var pageNums = "<li >" +
                               "            <a href='javascript:void(0)' class='jumpPage' name='page" + i + "'  >" + i + "</a>" +
                               "        </li>";
                           $(".pagination").append(pageNums);
                       }
                       var pageEnd = "<li ><a href='javascript:void(0)' name=" + data.totalPage + " class='nextPage' aria-label='Next'> <span aria-hidden='true'>》</span></a></li></ul>"
                       $(".pagination").append(pageEnd);
                       $(".currentPage").removeClass("currentPage");
                       $("a[name='page" + data.currentPage + "']").addClass("currentPage");
                   }
               },
               dataType:"json"
           })

       }
    </script>
</head>
<body>
<jsp:include page="top.jsp"/>
<div class="content all" id="contentTitle">
    <input type="hidden" id="searchValue" value="${content}">
    <input class="button" type="button" onclick="" value="相关文章"/>
    <input class="button" type="button" onclick="" value="相关用户"/>

</div>
<div class="all" id="content">

</div>
<div class="all" id="changePage">

</div>

</body>
</html>
