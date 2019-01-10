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
    <script type="text/javascript" src="/js/concern.js"></script>
    <link rel="stylesheet" href="/css/page.css" type="text/css"/>
    <title>搜索-简书</title>

    <style type="text/css">

        a{
            text-decoration: none;
            color: black;
        }
        .chooseA{
            font-size: 35px;


        }
        .chooseA:link{
            color: #777777;
        }
        .chooseA:hover{
            background-color:#969696;
        }
        .addChooseClass{
            background-color:#969696;
        }
        .currentPage{
            background-color: #6ce26c !important;
        }
        .articleTitle:hover{
            text-decoration: underline;
        }
        .yesOrNoConcernStyle{
            font-size: 25px;border-radius: 10px;background-color: #3db922;color: white
        }


    </style>
    <script type="text/javascript">
       $(function(){
           var currentPage=1;
           articleShow(currentPage);

           userShow(currentPage);
        });
       $(".jumpArticlePage").live("click",function () {
           var currentPage=$(this).attr('name');
           currentPage=parseInt(currentPage.slice(4));

           articleShow(currentPage);

       });
       $(".lastArticlePage").live("click",function () {
          var currentPage=$(".currentPage").attr('name');
          currentPage=parseInt(currentPage.slice(4));
          if(currentPage!=1){
              articleShow(currentPage-1);
          }
       });
       $(".nextArticlePage").live("click",function () {
           var totalPage=parseInt($(this).attr('name'));
           var currentPage=$(".currentPage").attr('name');
           currentPage=parseInt(currentPage.slice(4));
           if(currentPage!=totalPage){
               articleShow(currentPage+1);
           }
       });
       /*function getSearchArticle(obj) {
           $(".addChooseClass").removeClass("addChooseClass");
           $(obj).addClass("addChooseClass");
           var currentPage=1;
           articleShow(currentPage);
       }*/
      /* function getSearchUser(obj) {
           $(".addChooseClass").removeClass("addChooseClass");
           $(obj).addClass("addChooseClass");
           var currentPage=1;
           userShow(currentPage);
       }*/
       $(".jumpUserPage").live("click",function () {
           var currentPage=$(this).attr('name');
           currentPage=parseInt(currentPage.slice(4));
           userShow(currentPage);
       });
       $(".lastUserPage").live("click",function () {
           var currentPage=$(".currentPage").attr('name');
           currentPage=parseInt(currentPage.slice(4));
           console.log(currentPage);
           if(currentPage!=1){
               userShow(currentPage-1);
           }
       });
       $(".nextUserPage").live("click",function () {
           var totalPage=parseInt($(this).attr('name'));
           var currentPage=$(".currentPage").attr('name');
           currentPage=parseInt(currentPage.slice(4));
           if(currentPage!=totalPage){
              userShow(currentPage+1);
           }
       });
       function userShow(currentPage) {
           var nickName= $("#searchValue").val();
           $("#searchContent").attr("value",nickName);
           $.ajax({
               type: 'POST',
               url: '/search/user',
               data: {"nickName": nickName, "currentPage": currentPage},
               success: function (data) {
                   console.log(data);
                   $("#userResultNums").html("    " + data.totalCount + "个结果");
                   if(data.totalCount==0){
                       $("#userContent").html("<span style='color:#646464;'>没有查到相关信息</span>");
                   }else {
                       $("#userContent").html("");

                       for (var i = 0; i < data.showList.length; i++) {
                           var display="";
                           if(data.showList[i].concernStatus==0){
                               var concernStatus="+关注";
                               var addClass=" yesOrNoConcernStyle";
                           }else if(data.showList[i].concernStatus==1){
                               var concernStatus="已关注";
                               var addClass=" ";
                           }else if(data.showList[i].concernStatus==3){
                               var concernStatus="关注";
                               display=" display: none;";
                           }

                           var str = "<div style='margin-top: 30px;border: 1px solid gold; width: 60%'>" +
                                        "<div style='float: left'><a href='/user/myPage?userId="+data.showList[i].id+"'><img style='width: 80px;height: 80px' src=" + data.showList[i].img + "/></a></div>" +
                                        "<div style='float: left;padding-left: 30px'>" +
                                            "<div><a style='font-size: 30px' href='/user/myPage?userId="+data.showList[i].id+"'><strong>" + data.showList[i].nickName + "</strong></a></div>" +

                                            "<div style='color:#646464;font-size: 15px ' >关注" + data.showList[i].concernNums + " |粉丝 " + data.showList[i].fansNums + " |文章 " + data.showList[i].articleNums + "<br/>" +
                                            "写了 " + data.showList[i].count + "字，获得了" + data.showList[i].likeNums + "个喜欢 </div>" +
                                        "</div>" +
                                        "<div style='float: right'><a  href='javascript:void(0)'><input style=' font-size: 25px;border-radius: 10px;margin-top: 20px;"+display+"' name="+data.showList[i].id+" class='yesAndNoConcern "+ addClass+"'  type='button' value='"+concernStatus+"'/></a></div>" +
                                        "<div style='clear: both'></div>" +
                               "</div></div>";
                           $("#userContent").append(str);
                       }
                       $("#userChangePage").html("");


                       $("#userChangePage").append("<ul class='userPagination'></ul>");
                       var pageStart = "<li><a href='javascript:void(0)' class='lastUserPage' aria-label='Previous'><span aria-hidden='true'>《</span></li>";
                       $(".userPagination").append(pageStart);
                       for (var i = 1; i <= data.totalPage; i++) {
                           var pageNums = "<li >" +
                               "            <a href='javascript:void(0)' class='jumpUserPage' name='page" + i + "'  >" + i + "</a>" +
                               "        </li>";
                           $(".userPagination").append(pageNums);
                       }
                       var pageEnd = "<li ><a href='javascript:void(0)' name=" + data.totalPage + " class='nextUserPage' aria-label='Next'> <span aria-hidden='true'>》</span></a></li></ul>"
                       $(".userPagination").append(pageEnd);
                       $(".currentPage").removeClass("currentPage");
                       $("a[name='page" + data.currentPage + "']").addClass("currentPage");
                   }
               },
               dataType:"json"
           })
       }
       function articleShow(currentPage) {
           var content= $("#searchValue").val();
           $("#searchContent").attr("value",content);
           $.ajax({
               type:'POST',
               url:'/search/article',
               data:{"content":content,"currentPage":currentPage},
               success:function (data) {
                   console.log(data);
                   $("#articleResultNums").html("    " + data.totalCount + "个结果");
                   if(data.totalCount==0){
                       $("#articleContent").html("<span style='color:#646464;'>没有查到相关信息</span>");
                   }else {
                       $("#articleContent").html(" ");

                       for (var i = 0; i < data.showList.length; i++) {
                           var str = "<div style='margin-top: 30px;color: #646464;'>" +
                               "<div><a href='/user/myPage?userId="+data.showList[i].userId+"'><img style='width: 25px;height: 25px' src=" + data.showList[i].img + "/>   " + data.showList[i].nickName + "</a>" + data.showList[i].dynamicDate + "</div>" +
                               "<div><a href='/article/With?id="+data.showList[i].id+" 'class='articleTitle' style='font-size: 20px'><strong>" + data.showList[i].title + "</strong></a></div>" +
                               "<div>" + data.showList[i].content + "</div>" +
                               "<div style='margin-top: 5px'><a href='/article/With?id="+data.showList[i].id+"'> <span style='color: #646464'>阅读" + data.showList[i].readNums + "   评论" + data.showList[i].reviewNums + "</span></a>  喜欢" + data.showList[i].likeNums + "</div></div>";
                           $("#articleContent").append(str);
                       }
                       $("#articleChangePage").html("");

                       $("#articleChangePage").append("<ul class='articlePagination'></ul>");
                       var pageStart = "<li><a href='javascript:void(0)' class='lastArticlePage' aria-label='Previous'><span aria-hidden='true'>《</span></li>";
                       $(".articlePagination").append(pageStart);
                       for (var i = 1; i <= data.totalPage; i++) {
                           var pageNums = "<li >" +
                               "            <a href='javascript:void(0)' class='jumpArticlePage' name='page" + i + "'  >" + i + "</a>" +
                               "        </li>";
                           $(".articlePagination").append(pageNums);
                       }
                       var pageEnd = "<li ><a href='javascript:void(0)' name=" + data.totalPage + " class='nextArticlePage' aria-label='Next'> <span aria-hidden='true'>》</span></a></li></ul>"
                       $(".articlePagination").append(pageEnd);
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
<div style="width: 90%;margin-left: 10%">
    <div style="padding-top: 100px;">

        <input type="hidden" id="searchValue" value="${content}">




    </span>
    </div>
    <div>
        <a href="javascript:void(0)" class="chooseA " onclick="getSearchUser(this)">相关用户</a>
        <span id="userResultNums"></span>
    </div>
    <div id="userContent" style="width: 90%">

    </div>
    <div id="userChangePage">

    </div>
    <div>
        <a href="javascript:void(0)" id="articleWith" class="chooseA " onclick="getSearchArticle(this)">相关文章</a>
        <span id="articleResultNums"></span>
    </div>
    <div id="articleContent" style="width: 90%">

    </div>
    <div id="articleChangePage">

    </div>
</div>

</body>
</html>
