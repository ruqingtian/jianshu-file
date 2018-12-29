<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/9
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript " src="/js/jquery.cookie.js"></script>
    <style type="text/css">
        .top{
            width: 100%;
            height:70px;
            font-size: 20px;
            z-index:999;
            position: fixed;
            margin-top: -8px;

            background-color: antiquewhite;

        }
        .smallImg{
            height: 50px;
            width:50px;
        }
    </style>
    <title>Title</title>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type:"GET",
                url:"/user/isUserLogin",
                success:function (data) {

                    if(data.userName!=null) {

                        $("#topTouXiangImg").css("display", "inline");
                        $("#changeImg").css("display", "none");
                        $("#topTouXiangImg").attr("src",data.img);
                        $("#myPage").attr("href","/user/myPage?userId="+data.id);
                    }
                },
                dataType:"json"
            })
        });

        function showMore() {
            console.log(123);
            $("#showMoreArea").css('display','inline');
        }
        function displayMore() {
            $("#showMoreArea").css('display','none');

        }

        function exitUser() {
            $.ajax({
                type:"GET",
                url:"/user/exitUser",
                success:function (data) {
                    if(data.status==200) {
                        console.log("退出成功");
                       location.href="/";
                    }
                },
                dataType:"json"
            })

        }
        function search() {
            var content=$("#searchContent").attr("value");
            if(content.trim()!=""){
                var url='search?content='+content;
                url=encodeURI(url);
                window.open('/search?content='+content);
            }

        }

    </script>
</head>
<body>
<div class="top">
    <div>
        <div style="float:left;"><a  href="/"><img style="width: 120px"
                                           src="../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png"/></a></div>
        <div style="line-height:70px"><a class="first" style="height:70px;line-height:20px" href="/">首页</a> <a href="/">下载app</a><input
                id="searchContent" type="text"/> <input type="button" onclick="search()" value="搜索">


            <!--右上角 -->
            <span id="changeImg" style="display: inline">
            <a class="btn" href="/login">登录</a>
            <a class="btn" href="/register">注册</a>
        </span>

            <span onmouseleave="displayMore()">
               <img id="topTouXiangImg" style="display: none" class="smallImg" onmouseover="showMore()" src=""/>
                <p id="showMoreArea" style="display: none">
                    <a id="myPage">我的主页</a>
                    <a href="/user/setting">设置</a>
                    <a onclick="exitUser()" href="javascript:void(0)">退出</a>
                </p>
            </span>


            <a class="btn" href="/write" target='_blank'>写文章</a>
        </div>
    </div>
</div>
</body>
</html>
