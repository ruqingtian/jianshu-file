<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/10/28
  Time: 18:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <title>简书-创作你的创作</title>

    <style type="text/css">
       .top{
            width: 100%;
            height: 50px;
            font-size: 20px;
          z-index:999;
           position: fixed;
            top: 0;
            lsft:0;
           background-color: antiquewhite;

        }
        .content{
            position:relative; margin-left:10px; margin-top:50px;
        }
        img{
            height: 40px;
        }
       .pagination {
           display: inline-block;
           padding-left: 0;
           margin: 20px 0;
           border-radius: 4px
       }

       .pagination > li {
           display: inline
       }

       .pagination > li > a, .pagination > li > span {
           position: relative;
           float: left;
           padding: 6px 12px;
           margin-left: -1px;
           line-height: 1.42857143;
           color: #337ab7;
           text-decoration: none;
           background-color: #fff;
           border: 1px solid #ddd
       }

       .pagination > li:first-child > a, .pagination > li:first-child > span {
           margin-left: 0;
           border-top-left-radius: 4px;
           border-bottom-left-radius: 4px
       }

       .pagination > li:last-child > a, .pagination > li:last-child > span {
           border-top-right-radius: 4px;
           border-bottom-right-radius: 4px
       }

       .pagination > li > a:focus, .pagination > li > a:hover, .pagination > li > span:focus, .pagination > li > span:hover {
           z-index: 3;
           color: #23527c;
           background-color: #eee;
           border-color: #ddd
       }

       .pagination > .active > a, .pagination > .active > a:focus, .pagination > .active > a:hover, .pagination > .active > span, .pagination > .active > span:focus, .pagination > .active > span:hover {
           z-index: 2;
           color: #fff;
           cursor: default;
           background-color: #337ab7;
           border-color: #337ab7
       }

       .pagination > .disabled > a, .pagination > .disabled > a:focus, .pagination > .disabled > a:hover, .pagination > .disabled > span, .pagination > .disabled > span:focus, .pagination > .disabled > span:hover {
           color: #777;
           cursor: not-allowed;
           background-color: #fff;
           border-color: #ddd
       }

       .currentPage{
            background-color: #6ce26c !important;
        }


    </style>
    <script type="text/javascript">
        window.onload=function () {

           $("a[name='1']").addClass("currentPage");
        };
        function jumpPage(obj) {
            var currentPage=$(obj).attr('name');
            console.log(currentPage);
            $(".currentPage").removeClass("currentPage");
            $(obj).addClass("currentPage");
            $.ajax({
                type:"GET",
                url:"/index/page",
                data:{currentPage:currentPage},
                success:function (data) {

                    $("#pageUser").html("");
                    for(var i=0;i<data.showList.length;i++){
                   var count=" <img src="+data.showList[i].img+"/>  "+data.showList[i].nickName+": 写了0.0 "+data.showList[i].fansNums+" 喜欢 <a href=''>关注</a><br/>";
                   $("#pageUser").append(count);

                    }


                },
                dataType:"json"
            })
        }
        function beforePage() {
            var currentPage=$(".currentPage").attr("name")-1;

            if(currentPage!=0){
                $(".currentPage").removeClass("currentPage");

                $("a[name="+currentPage+''+"]").addClass("currentPage");
                $.ajax({
                    type:"GET",
                    url:"/index/page",
                    data:{currentPage:currentPage},
                    success:function (data) {

                        $("#pageUser").html("");
                        for(var i=0;i<data.showList.length;i++){
                            var count=" <img src="+data.showList[i].img+"/>  "+data.showList[i].nickName+": 写了0.0 "+data.showList[i].fansNums+" 喜欢 <a href=''>关注</a><br/>";
                            $("#pageUser").append(count);
                        }
                    },
                    dataType:"json"
                })
            }
        }
        function nextPage() {
            var currentPage=$(".currentPage").attr("name");
            currentPage=parseInt(currentPage)+1;

            if(currentPage!=5) {
                $(".currentPage").removeClass("currentPage");

                $("a[name=" + currentPage + '' + "]").addClass("currentPage");
                $.ajax({
                    type: "GET",
                    url: "/index/page",
                    data: {currentPage: currentPage},
                    success: function (data) {

                        $("#pageUser").html("");
                        for (var i = 0; i < data.showList.length; i++) {
                            var count = " <img src=" + data.showList[i].img + "/>  " + data.showList[i].nickName + ": 写了0.0 " + data.showList[i].fansNums + " 喜欢 <a href=''>关注</a><br/>";
                            $("#pageUser").append(count);

                        }


                    },
                    dataType: "json"
                })
            }
        }
        function changePage(obj) {
            var totalCount=$(obj).attr('id');
            console.log(totalCount);
            var currentPage=parseInt(Math.random()*totalCount)+1;
            console.log(currentPage);
            $(".currentPage").removeClass("currentPage");

            $("a[name=" + currentPage + '' + "]").addClass("currentPage");
            $.ajax({
                type: "GET",
                url: "/index/page",
                data: {currentPage: currentPage},
                success: function (data) {

                    $("#pageUser").html("");
                    for (var i = 0; i < data.showList.length; i++) {
                        var count = " <img src=" + data.showList[i].img + "/>  " + data.showList[i].nickName + ": 写了0.0 " + data.showList[i].fansNums + " 喜欢 <a href=''>关注</a><br/>";
                        $("#pageUser").append(count);

                    }


                },
                dataType: "json"
            })
        }
    </script>

</head>



<body>
<div class="top">
    <nav >
    <a class="logo" href="/"><img src="../../image/nav-logo-4c7bbafe27adc892f3046e6978459bac.png" /></a>
    <a class="first" href="/" >首页</a> <a href="/" >下载app</a><input type="text"> <input type="button" value="搜索">

    <!--右上角 -->

    <a  class="btn" href="/login">登入</a>
    <a class="btn"href="/register">注册</a>
    <a class="btn" href="/write">写文章</a>
    </nav>
</div>
<div class="content">
    推荐作者：    <a id="${pageBean.totalPage}" href="javascript:void(0)" onclick="changePage(this)">换一批</a><br/>
    <div id="pageUser">
    <c:forEach items="${pageBean.showList}" var="user">

         <img src='${user.img}'/>  ${user.nickName}: 写了0.0 ${user.concernNums} 喜欢      <a href="/">关注</a><br/>

    </c:forEach>
    </div>
    <ul class="pagination">
        <li><a href="javascript:void(0)" onclick="beforePage()" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
        <c:forEach begin="1" end="${pageBean.totalPage}" var="page">
        <li>
            <a href="javascript:void(0)"  name="${page}" onclick="jumpPage(this)">${page}</a>
        </li>
        </c:forEach>
        <li><a href="javascript:void(0)" onclick="nextPage()" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>


    </ul>
</div>

</body>
</html>
