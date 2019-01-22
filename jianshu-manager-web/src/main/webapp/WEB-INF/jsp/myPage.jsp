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
    <link rel="stylesheet" href="/css/myPage.css">
    <title>${user.nickName}-简书</title>
    <style type="text/css">

    </style>
    <script type="text/javascript">
        $(function () {
            var userId=$("#concernInput").attr("name");
            if(userId!=null) {
                $.ajax({
                    type: "get",
                    url: "/user/judgeConcern",
                    data: {"userId": userId},
                    success: function (data) {
                        if(data.data=="已关注") {
                            $("#concernInput").attr("value", data.data);
                        }
                    },
                    dataType: "json"
                });
            }
            getAllArticle();

        });

    function  getAllArticle() {
        $(".addChooseClass").removeClass("addChooseClass");
        $("#getAllArticle").addClass("addChooseClass");
    var userId=$("#getAllArticle").parent().attr('name');
    $.ajax({
        type:"get",
        url:"/article/userArticle",
        data:{"userId":userId},
        success:function (data) {
            console.log(data);
            $("#content").html("");
            for(var i=0;i<data.length;i++){

                var count="<div  class='articleShow' style='margin-top: 50px ;border:1px solid red;'>" +
                                "<div style='float:left;width: 70%'><div><strong><a style='font-size: 20px' class='articleTitle' href='/article/With?id="+data[i].id+"' target='_blank'>"+data[i].title+"</a></strong></div><div style='color: #646464;padding-top: 10px'>"+data[i].content+"</div>"+
                                " </div>" +
                                "<div style='float:right'>" +
                                "   <img class='articleImg' src="+data[i].image+" />" +
                                "</div>" +
                                "<div style='clear:both'></div>" +
                                "<div>"+
                                "<p style='width: 800px;color: #646464'><a href='/article/With?id="+data[i].id+"'> 阅读"+data[i].readNums+" 评论 "+data[i].reviewNums+" </a>喜欢"+data[i].likeNums+"   &nbsp; &nbsp;    "+data[i].showTime+"</p>" +
                                "</div>" +
                    "</div><div style='clear:both'></div>"

                $("#content").append(count);

            }
            if(data.length==0){
                $("#content").append("<div style='color: #646464;font-size: 30px'>暂无发布的文章 </div>");
            }
        },
        dataType:"json"
    })
    }
    function getConcern(obj) {
        $(".addChooseClass").removeClass("addChooseClass");
        $(obj).addClass("addChooseClass");
        var userId=$(obj).parent().attr('name');
        $.ajax({
            type:"GET",
            url:"/user/concernUser",
            data:{"userId":userId},
            success:function (data) {
               showMypageUser(data);

            },
            dataType:"json"
        })
    }
    function getFans(obj) {
        $(".addChooseClass").removeClass("addChooseClass");
        $(obj).addClass("addChooseClass");
        var concernId=$(obj).parent().attr('name');
        $.ajax({
            type:"GET",
            url:"/user/fansUser",
            data:{"concernId":concernId},
            success:function (data) {

                showMypageUser(data);
            },
            dataType:"json"
        })

    }

    function showMypageUser(data) {

        $("#content").html("");
        if(data.length==0){
            var content="<div style='color: #646464;font-size: 30px'>暂无粉丝 </div>";
            $("#content").append(content);
        }
        for(var i=0;i<data.length;i++){
            var status="+关注"
            if(data[i].concernStatus==1){
                var status="已关注"
            }


                var content = "<div class='articleShow' style='border: 1px solid red;margin-top: 30px'>" +
                    "<div style='float: left'><a href='/user/myPage?userId="+data[i].id+"'  target='_blank'><img  style='height: 70px' src=" + data[i].img + "/></a></div>" +
                    "<div style='color: #646464;float: left'>" +
                    " <div><a href='/user/myPage?userId="+data[i].id+"'  target='_blank'><strong><span style='font-size: 20px'>" + data[i].nickName + "</span></strong></a></div>" +
                    "<div> 关注" + data[i].concernNums + "| 粉丝" + data[i].fansNums + " | 文章" + data[i].articleNums + "</div>" +
                    "<div>| 字数" + data[i].count + "  | 获得了" + data[i].likeNums + "个喜欢</div> " +
                    "</div>" +
                    " <div style='float: right;padding-top: 15px'><input class='yesAndNoConcern' style='font-size: 25px' name=" + data[i].id + " type='button' value=" + status + "></div><div style='clear: both'></div>" +
                    "</div>";

            $("#content").append(content);
        }

    }
        $(".yesAndNoConcern").live('mouseenter',function () {
            var count=$(this).attr("value");
            if(count=="已关注"){
                $(this).attr("value","取消关注");
            }
        });
        $(".yesAndNoConcern").live('mouseleave',function () {
            var count=$(this).attr("value");
            if(count=="取消关注"){
                $(this).attr("value","已关注");
            }
        });
        $(".yesAndNoConcern").live('click',function () {
            var node=$(this);
            var count=node.attr("value");
            var id=node.attr("name");
            if(count=="取消关注"){
                $.ajax({
                    type:"GET",
                    url:"/user/deleteConcern",
                    data:{"userId":id},
                    success:function (data) {
                        if(data.status==200) {
                            node.attr("value", "+关注");
                        }

                    },
                    dataType:"json"
                })
            }else if(count=="+关注"){
                $.ajax({
                    type:"GET",
                    url:"/user/concern",
                    data:{"userId":id},
                    success:function (data) {
                        if(data.status==200){
                            node.attr("value","已关注");
                        }
                        if(data.msg=="请先登录"){
                            location.href="/login";
                        }
                    },
                    dataType:"json"
                })
            }
        });
        function getDynamic(obj) {
            $(".addChooseClass").removeClass("addChooseClass");
            $(obj).addClass("addChooseClass");
            var userId=$(obj).parent().attr("name");

            $.ajax({
                type:"GET",
                url:"/article/dynamic",
                data:{"userId":userId},
                success:function (data) {
                    console.log(data.length);
                    $("#content").html("");
                    if(data.length==0){
                        var content= "<div style='color: #646464;font-size: 30px'>暂无动态 </div>";
                        $("#content").append(content);
                    }
                    for(var i=0;i<data.length;i++) {
                        var content="";
                        if (data[i].dynamicContent=="喜欢了文章") {
                            content = "<div class='articleShow' style='border:1px solid red;margin-top:30px'>" +
                                            "<div>" +
                                "               <a   href='/user/myPage?userId="+data[i].userId+"'><img class='userImg' src=" + data[i].img + "><span style='color: black'> "+data[i].nickName+"</span></a> <span style='color: #646464'> " + data[i].dynamicContent + "    " + data[i].dynamicDate + "</span>" +
                                "            </div>" +
                                            "<div >" +
                                                "<div style='float:left'>" +
                                    "               <div style='color: #646464'><strong  ><a  style='font-size: 20px'  class='articleTitle A_css' href=/article/With?id=" + data[i].id + ">" + data[i].title + "</a></strong></div>"+
                                                   "<div style='padding-top: 10px;color: #646464'>" + data[i].content +"</div>"+
                                                "</div>" +
                                                "<div style='float: right'>" +
                                    "               <img class='articleImg' src="+data[i].image+" />" +
                                    "           </div> " +
                                        "  </div><div style='clear:both'></div>" +
                                        " <div>" +
                            "                   <span class='A_css' style='color: #646464'> <a href='/user/myPage?userId="+data[i].userId+"'>"+ data[i].userName + "</a><a class='A_css' href='/article/With?id="+data[i].id+"'>   阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+"</a> 喜欢 " + data[i].likeNums + "</span>" +
                                         "</div>" +
                                    "</div></div>";

                         }else if(data[i].dynamicContent=="发表了文章"){
                            content = "<div class='articleShow' style='margin-top:30px;color: #646464;border: 1px solid red;'>" +
                                "<div><img class='userImg' src=" + data[i].img + "> <span style='color: black'>"+data[i].nickName+"</span>   " + data[i].dynamicContent + "    " + data[i].dynamicDate + "</div>" +
                                "<div style='float: left'>" +
                                "   <div style='padding-top: 10px;padding-bottom: 10px'><strong><a class='articleTitle' href=/article/With?id=" + data[i].id + "><span style='font-size: 20px'>" + data[i].title + "</a></strong></div> " +
                                "   <div style='padding-top: 5px;padding-bottom: 10px'>" + data[i].content + "</div>" +
                                "</div>" +
                                "<div style='float: right'><img class='articleImg' src='"+data[i].image+"'></div>" +
                                "<div style='clear: both'></div>" +
                                "<div> 阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+" 喜欢 " + data[i].likeNums + "</div> " +
                                "</div><div style='clear:both'></div>";

                        }else if(data[i].dynamicContent=="发表了评论"){
                            console.log(data[i]);
                            content = "<div class='articleShow' style='border: 1px solid red;margin-top: 30px'>" +
                                "<div><a   href='/user/myPage?userId="+data[i].userId+"'><img class='userImg' src=" + data[i].img + "><span style='color: black'> "+data[i].nickName+" </span></a> <span style='color: #646464'>" + data[i].dynamicContent + "    " + data[i].dynamicDate + "</span></div>" +
                                    "<div>"+data[i].reviewContent+"</div>"+
                                      "<div style='color: #646464;border-left: 5px solid #646464;float:left'>" +
                                            "<div><strong><a style='font-size: 20px' class='articleTitle' href=/article/With?id=" + data[i].id + ">" + data[i].title + "</a></strong></div> " +
                                             "<div style='padding-top: 10px;width: 100%'>" + data[i].content + "</div>" +
                                       "" +
                                "       " +
                                "<div style='padding-top: 30px'> <a href='/user/myPage?userId="+data[i].userId+"'>" + data[i].userName + "</a><a class='A_css' href='/article/With?id="+data[i].id+"'>   阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+"</a> 喜欢 " + data[i].likeNums + " </div></div>" +
                                "<div style='float:right'><img class='articleImg' src='"+data[i].image+"'></div><div style='clear:both'></div>" +
                                "</div>";

                        }else if(data[i].dynamicContent=="关注了作者"){
                            var status="+关注";
                            if(data[i].concernStatus==1){
                                status="已关注";
                            }
                            console.log(data[i]);
                            content="<div class='articleShow'  style='border: 1px solid red;margin-top:30px'>" +
                                         "<div style='border: 1px solid #646464'>" +
                                              "<div>" +
                                                    "<a   href='/user/myPage?userId="+data[i].userId+"'><img class='userImg' src=" + data[i].userImg + "><span style='color: black'> "+data[i].userName+"</span> </a> <span style='color:#646464;'>" + data[i].dynamicContent + "    " + data[i].dynamicDate + "</span>" +
                                              "</div>" +
                                             "<div style='border: 1px solid #646464;color: #646464'>" +
                                                    "<div style='float: left'>" +
                                                        "<a href='/user/myPage?userId="+data[i].id+"'><img class='smallImg' src="+data[i].img+"/></a>" +
                                                    "</div>"+
                                                     "<div style='float: left;margin-left: 20px'><div><a   href='/user/myPage?userId="+data[i].id+"'  target='_blank' ><span style='font-size: 20px ;color: black'>"+data[i].nickName+"</a> </div>" +
                                                         "<div style='margin-top: 5px'>写了  "+data[i].count+"字，被"+data[i].concernNums+"人关注，获得了"+data[i].likeNums+"个喜欢</div>" +
                                                     "</div>" +
                                                  "<div style='float: right;margin-right: 70px'><input class='yesAndNoConcern' name="+data[i].id+" style='font-size:25px;border-radius:9px' type='button' value="+status+"></div>" +
                                                    "<div style='clear:both;padding: 10px 0' ><hr/></div><div style='padding-bottom: 10px;padding-left: 20px'>   "+data[i].desc+"</div>" +
                                             "</div>" +
                                        "</div>" +
                                    "</div>";
                        }

                        $("#content").append(content);
                    }

                },
                dataType:"json"
            })
        }
        function getLikeArticle(obj) {
            $(".addChooseClass").removeClass("addChooseClass");
            $(obj).addClass("addChooseClass");
            var userId=$(obj).parent().attr('name');
            getAllLikeArticle(userId)
        }
        $(".likeArticleDiv").live("mouseenter",function () {
            $(this).find("input").addClass("likeArticles");
            $(".likeArticles").attr("style","display:inline");
        });
        $(".likeArticleDiv").live("mouseleave",function () {
            $(".likeArticles").removeClass("likeArticles");
            $(".noLikeArticle").attr("style","display:none");
        });
        function getAllLikeArticle(userId) {
            $.ajax({
                type:"GET",
                url:"/article/showLike",
                data:{"userId":userId},
                success:function (data) {
                    console.log(data);
                    $("#content").html("")
                    if(data.length==0){
                        $("#content").html("<div style='color: #646464;font-size: 30px'>没有你喜欢的文章</div>")
                    }
                    for(var i=0;i<data.length;i++){
                        var articleContent=data[i].content;
                        if(data[i].content.length>100){
                             articleContent=data[i].content.substring(0,100)+"...";

                        }
                        var content="<div class='articleShow likeArticleDiv ' style='border: 1px solid red;color: #646464;margin-top: 30px' name="+data[i].workerId+">" +
                            "<div><a href='/user/myPage?userId="+data[i].userId+"'><img class='userImg' src="+data[i].img+"/><span style='color: black'>"+data[i].nickName+"</span></a>   "+data[i].dynamicDate+"</div>" +
                            " <div style='float: left;width: 70%'>" +
                            "   <div style='padding-top: 10px;padding-bottom: 5px'><strong><a style='font-size: 20px' class='articleTitle' href=/article/With?id=" + data[i].id + ">"+data[i].title+"</a></strong></div>" +
                            " <div>"+articleContent+"</div>" +
                            "</div>" +
                            "<div style='float: right' ><img class='articleImg' src='"+data[i].image+"'></div><div style='clear: both'></div>" +
                            "<div><a  href='/article/With?id="+data[i].id+"'>阅读 "+data[i].readNums+"  评论  "+data[i].reviewNums+"</a>  喜欢  "+data[i].likeNums+"    <input class='noLikeArticle'  style='display:none' type='button' name="+data[i].id+" class='deleteLikeArticle' value='取消喜欢'/></div></div>";
                        $("#content").append(content);
                    }
                },
                dataType:"json"
            });
        }
        $(".deleteLikeArticle").live("click",function () {
            if(confirm("确定取消喜欢该文章")) {
                var articleId = $(this).attr('name');
                var userId = $(this).parent().attr('name');
                console.log(userId);
                $.ajax({
                    type: "GET",
                    data: {"articleId": articleId},
                    url: "/article/like",
                    success: function () {
                        getAllLikeArticle(userId);
                    }
                })
            }
        })
    </script>
</head>
<body>
<jsp:include page="top.jsp"/>
<div  style="padding-top: 100px;" class="content all" >
    <div style="float: left;width: 90px"><img style="height: 90px" src="${user.img}"/></div>
    <div style="padding-left:100px">
        <div style="font-size: 30px; "><strong>${user.nickName}</strong></div>


        <br/>
        <div style=" margin-top:-20px">
            <div class="smallDiv" style="float: left;">
                <div><strong>${user.concernNums}</strong></div>
                <div class="smallDivChinese">关注</div>
            </div>
            <div class="smallDiv" style="float: left;">

                <div><strong>${user.fansNums}</strong></div>
                <div class="smallDivChinese"> 粉丝</div>
            </div>
            <div class="smallDiv" style="float: left;">

                <div><strong>${user.articleNums}</strong></div>
                <div class="smallDivChinese">文章</div>
            </div>
            <div class="smallDiv" style="float: left;">

                <div><strong>${user.count}</strong></div>
                <div class="smallDivChinese">字数</div>
            </div>
            <div class="smallDiv" style="width:80px;float:left">

                <div><strong>${user.likeNums}</strong></div>
                <div class="smallDivChinese"> 收获喜欢</div>

            </div>
            <div style="">
                <c:choose>
                    <c:when test="${ not empty status}">
                        <input id="concernInput" class="yesAndNoConcern" name="${user.id}" type="button"
                               style="color: black;font-size: 25px;line-height:40px"
                               value="+关注"/>
                    </c:when>
                </c:choose>
            </div>
            <div style="clear:both;"></div>
        </div>
    </div>


</div>

<div style="width: 100%;clear:none;margin-top: 30px;"  class="all" name="${user.id}">
    <a href="javascript:void(0)" class="chooseA addChooseClass" type="button" id="getAllArticle" onclick="getAllArticle(this)" >文章  </a>
    <a href="javascript:void(0)" class="chooseA" type="button" onclick="getDynamic(this)" >动态  </a>
    <a href="javascript:void(0)" class="chooseA " type="button" onclick="getLikeArticle(this)" >喜欢的文章  </a>
    <a href="javascript:void(0)" class="chooseA" type="button"  onclick="getHot(this)" >热门  </a>
    <a href="javascript:void(0)" class="chooseA" type="button" onclick="getConcern(this)">关注用户  </a>
    <a href="javascript:void(0)" class="chooseA" type="button" onclick="getFans(this)" >粉丝</a>

</div>
<div style="margin-top:50px" class="all" id="content">

</div>

</body>
</html>
