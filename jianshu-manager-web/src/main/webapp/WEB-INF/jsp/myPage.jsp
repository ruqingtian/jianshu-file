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
    <title>${user.nickName}-简书</title>
    <style type="text/css">
        .content{
            position:relative; margin-left:10px; margin-top:50px;
        }
        .all{
            left: 20%;
            position: relative;
        }
    </style>
    <script type="text/javascript">
        $(function () {

            getAllArticle();

        });

    function  getAllArticle() {
    var userId=$("#getAllArticle").parent().attr('name');
    $.ajax({
        type:"get",
        url:"/article/userArticle",
        data:{"userId":userId},
        success:function (data) {
            $("#content").html("");
            for(var i=0;i<data.length;i++){

                var count="<li><img class='articleImg' src="+data[i].image+" style='float: right;position: relative;right:700px;'/>" +
                    "<div class='articleShow'><h3 style='width: 800px' ><a href='/article/With?id="+data[i].id+"' target='_blank'>"+data[i].title+"</a></h3>" +
                    "<p style='width: 800px'>"+data[i].content+"</p> " +
                    "<p style='width: 800px'> 阅读"+data[i].readNums+" 评论 0 喜欢"+data[i].likeNums+"   "+data[i].showTime+"</p></div></li>"

                $("#content").append(count);

            }
        },
        dataType:"json"
    })
    }
    function getConcern(obj) {
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
        for(var i=0;i<data.length;i++){
            var status="+关注"
            if(data[i].concernStatus==1){
                var status="已关注"
            }
            var content="<img  class='smallImg' src="+data[i].img+"/> <span style='font-size: 20px'>"+data[i].nickName+"</span><br/>" +
                " 关注"+data[i].concernNums+"| 粉丝"+data[i].fansNums+" | 文章"+data[i].articleNums+"| 字数"+data[i].count+"  | 获得了"+data[i].likeNums+"个喜欢  <input class='yesAndNoConcern' style='font-size: 25px' name="+data[i].id+" type='button' value="+status+"><br/>";
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
            var userId=$(obj).parent().attr("name");
            console.log(userId);
            $.ajax({
                type:"GET",
                url:"/article/dynamic",
                data:{"userId":userId},
                success:function (data) {
                    console.log(data);
                    $("#content").html("");
                    for(var i=0;i<data.length;i++) {
                        var content="";
                        if (data[i].dynamicContent=="喜欢了文章") {
                            content = "<div><img class='smallImg' src=" + data[i].img + "> "+data[i].nickName+"  " + data[i].dynamicContent + "    " + data[i].dynamicDate + "<br/>" +
                                "<img class='articleImg' src="+data[i].image+" style='float: right;position: relative;right:700px;'/><h3><a href=/article/With?id=" + data[i].id + ">" + data[i].title + "</a></h3><br/> " +
                                "" + data[i].content + "<br/>" +
                                " " + data[i].userName + "   阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+" 喜欢 " + data[i].likeNums + " </div>";

                         }else if(data[i].dynamicContent=="发表了文章"){
                            content = "<div><img class='smallImg' src=" + data[i].img + "> "+data[i].nickName+"   " + data[i].dynamicContent + "    " + data[i].dynamicDate + "<br/>" +
                                "<h3><a href=/article/With?id=" + data[i].id + ">" + data[i].title + "</a></h3><br/> " +
                                "" + data[i].content + "<br/>" +
                                " 阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+" 喜欢 " + data[i].likeNums + " </div>";

                        }else if(data[i].dynamicContent=="发表了评论"){
                            content = "<div><img class='smallImg' src=" + data[i].img + "> "+data[i].nickName+"  " + data[i].dynamicContent + "    " + data[i].dynamicDate + "<br/>" +
                                    data[i].reviewContent+"<br/>"+
                                "<h3><a href=/article/With?id=" + data[i].id + ">" + data[i].title + "</a></h3><br/> " +
                                "" + data[i].content + "<br/>" +
                                " " + data[i].userName + "   阅读 " + data[i].readNums + "评论 "+data[i].reviewNums+" 喜欢 " + data[i].likeNums + " </div>";

                        }else if(data[i].dynamicContent=="关注了作者"){
                            var status="+关注";
                            if(data[i].concernStatus==1){
                                status="已关注";
                            }
                            content="<div><img class='smallImg' src=" + data[i].userImg + "> "+data[i].userName+"  " + data[i].dynamicContent + "    " + data[i].dynamicDate + "<br/>" +
                                "<div><a  href='/user/myPage?userId="+data[i].id+"'  target='_blank' ><img class='smallImg' src="+data[i].img+"/>"+data[i].nickName+"</a><input class='yesAndNoConcern' name="+data[i].id+" style='font-size: 25px' type='button' value="+status+"> <br/>" +
                                "写了  "+data[i].count+"字，被"+data[i].concernNums+"人关注，获得了"+data[i].likeNums+"个喜欢<br/>" +
                                ""+data[i].desc+"</div></div>";
                        }
                        $("#content").append(content);
                    }

                },
                dataType:"json"
            })
        }
        function getLikeArticle(obj) {
            var userId=$(obj).parent().attr('name');
            getAllLikeArticle(userId)
        }
        function getAllLikeArticle(userId) {
            $.ajax({
                type:"GET",
                url:"/article/showLike",
                data:{"userId":userId},
                success:function (data) {
                    console.log(data);
                    $("#content").html("")
                    if(data.length==0){
                        $("#content").html("没有你喜欢的文章")
                    }
                    for(var i=0;i<data.length;i++){
                        var content="<div name="+data[i].workerId+"><img class='smallImg' src="+data[i].img+"/>"+data[i].nickName+"   "+data[i].dynamicDate+"<br/>" +
                            " <a href='' >"+data[i].title+"</a><br/>" +
                            " "+data[i].content+"<br/>" +
                            "阅读 "+data[i].readNums+"  评论  "+data[i].reviewNums+"  喜欢  "+data[i].likeNums+"    <input type='button' name="+data[i].id+" class='deleteLikeArticle' value='取消喜欢'/></div>";
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
<div class="content all">
    <img style="height: 80px" src="${user.img}"/>   <span style="font-size: 30px">${user.nickName}</span>

    <c:choose>
        <c:when test="${ not empty status}">
            <input class="yesAndNoConcern" name="${user.id}" type="button" style="font-size: 20px" value="+关注"/>
        </c:when>
    </c:choose>
    <br/>
    关注 ${user.concernNums} 粉丝 ${user.fansNums}  文章${user.articleNums} 字数${user.count}   收获喜欢 ${user.likeNums}
</div>
<div class="all" name="${user.id}">
    <input type="button" id="getAllArticle" onclick="getAllArticle(this)" value="文章"/>
    <input type="button" onclick="getDynamic(this)" value="动态"/>
    <input type="button" onclick="getLikeArticle(this)" value="喜欢的文章"/>
    <input type="button"  onclick="getHot(this)" value="热门"/>
    <input type="button" onclick="getConcern(this)" value="关注用户"/>
    <input type="button" onclick="getFans(this)" value="粉丝"/>

</div>
<div class="all" id="content">

</div>

</body>
</html>
