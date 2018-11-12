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

        .content{
            position:relative; margin-left:10px; margin-top:50px;
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
      .articleShow{
           text-align:center ;
           width: 50%;
       }
       .showMore{
           text-align:center ;
           width: 60%;
       }


    </style>
    <script type="text/javascript">
        window.onload=function () {
            $.ajax({
                type: "GET",
                url: "/index/userPage",
                data: {currentPage: 1},
                success: function (data) {

                    $("#pageUser").html("");
                    for (var i = 0; i < data.showList.length; i++) {
                        var count = " <img class='smallImg' src=" + data.showList[i].img + "/>  " + data.showList[i].nickName + ": 写了0.0 " + data.showList[i].fansNums + " 喜欢 <a href=''>关注</a><br/>";
                        $("#pageUser").append(count);

                    }


                },
                dataType: "json"
            });
           $("a[name='1']").addClass("currentPage");
           $.ajax({
              type:"GET",
              url:"/index/articlePage",
              data:{currentPage:1},
              success:function (data) {
                  console.log(data);
                 for(var i=0;i<data.showList.length;i++){
                  var count="<li><img class='articleImg smallImg' src="+data.showList[i].image+" style='float: right;position: relative;right:700px;'/>" +
                      "<div class='articleShow'><h3 style='width: 800px' ><a href='/article/With?id="+data.showList[i].id+"' target='_blank'>"+data.showList[i].title+"</a></h3>" +
                      "<p style='width: 800px'>"+data.showList[i].content+"</p> " +
                      "<p style='width: 800px'>"+data.showList[i].userName+"  评论 0 喜欢"+data.showList[i].likeNums+"</p></div></li>"

                  $("#articleShow").append(count);
                  console.log("添加成功");
                 }
              } ,
               dataType:"json"
           });
        };
        function jumpPage(obj) {
            var currentPage=$(obj).attr('name');
            console.log(currentPage);
            $(".currentPage").removeClass("currentPage");
            $(obj).addClass("currentPage");
            $.ajax({
                type:"GET",
                url:"/index/userPage",
                data:{currentPage:currentPage},
                success:function (data) {

                    $("#pageUser").html("");
                    for(var i=0;i<data.showList.length;i++){
                   var count=" <img  class='smallImg' src="+data.showList[i].img+"/>  "+data.showList[i].nickName+": 写了0.0 "+data.showList[i].fansNums+" 喜欢 <a href=''>关注</a><br/>";
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
                    url:"/index/userPage",
                    data:{currentPage:currentPage},
                    success:function (data) {

                        $("#pageUser").html("");
                        for(var i=0;i<data.showList.length;i++){
                            var count=" <img  class='smallImg' src="+data.showList[i].img+"/>  "+data.showList[i].nickName+": 写了0.0 "+data.showList[i].fansNums+" 喜欢 <a href=''>关注</a><br/>";
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

            var totalPageStr=$("a[name=changeAll]").attr('id');
            var totalPage=parseInt(totalPageStr)+1;
            console.log(totalPage);


            if(currentPage!=totalPage) {
                $(".currentPage").removeClass("currentPage");

                $("a[name=" + currentPage + '' + "]").addClass("currentPage");
                $.ajax({
                    type: "GET",
                    url: "/index/userPage",
                    data: {currentPage: currentPage},
                    success: function (data) {

                        $("#pageUser").html("");
                        for (var i = 0; i < data.showList.length; i++) {
                            var count = " <img  class='smallImg' src=" + data.showList[i].img + "/>  " + data.showList[i].nickName + ": 写了0.0 " + data.showList[i].fansNums + " 喜欢 <a href=''>关注</a><br/>";
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
                url: "/index/userPage",
                data: {currentPage: currentPage},
                success: function (data) {

                    $("#pageUser").html("");
                    for (var i = 0; i < data.showList.length; i++) {
                        var count = " <img  class='smallImg' src=" + data.showList[i].img + "/>  " + data.showList[i].nickName + ": 写了0.0 " + data.showList[i].fansNums + " 喜欢 <a href=''>关注</a><br/>";
                        $("#pageUser").append(count);

                    }


                },
                dataType: "json"
            })
        }
        function showMoreArticle(obj) {
            var name=$(obj).attr('name');
            name=parseInt(name)+1;

            $.ajax({
                type:"GET",
                url:"/index/articlePage",
                data:{currentPage:name},
                success:function (data) {
                    for(var i=0;i<data.showList.length;i++){
                        var count="<li><img class='articleImg' src="+data.showList[i].image+" style='float: right;position: relative;right:700px;'/>" +
                            "<div class='articleShow'><h3 style='width: 800px' ><a href='/article/With?id="+data.showList[i].id+"' target='_blank'>"+data.showList[i].title+"</a></h3>" +
                            "<p style='width: 800px'>"+data.showList[i].content+"</p> " +
                            "<p style='width: 800px'>"+data.showList[i].userName+"  评论 0 喜欢"+data.showList[i].likeNums+"</p></div></li>"

                        $("#articleShow").append(count);

                    }
                    console.log(data.totalPage);
                    $(obj).attr('name',name);
                    if(data.totalPage==name){
                       document.getElementById('showMore').disabled=true;
                        console.log("成功失效");

                    }

                } ,
                dataType:"json"
            });
        }
    </script>

</head>



<body>
<jsp:include page="top.jsp"/>
<div class="content">
    推荐作者：    <a id="${pageBean.totalPage}" name="changeAll" href="javascript:void(0)" onclick="changePage(this)">换一批</a><br/>
    <div id="pageUser">

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
<hr/>
<div id="articleShow">
   <%-- <c:forEach items="${articleList}" var="article">
        <li>
            <img class="articleImg" src="${article.image}" style="float: right;position: relative;right:700px;"/>
            <div class="articleShow">
                <h3 style="width: 800px" ><a href="javascript:void(0)">${article.title}</a></h3>
                <p style="width: 800px">${article.content}</p>
                <p style="width: 800px">${article.userName}  评论 0 喜欢 ${article.likeNums}</p>
            </div>
        </li>
    </c:forEach>--%>
</div>
<div class="showMore"  >
    <input id="showMore" name="1" type="button" onclick="showMoreArticle(this)" value="阅读更多" style="font-size: 20px; ;">
</div>

</body>
</html>
