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

        .articleImg{
            width: 130px;
            height: 90px;
        }
    </style>
    <script type="text/javascript">
        window.onload=function () {
            $.ajax({
                type: "GET",
                url: "/index/userPage",
                data: {currentPage: 1},
                success: function (data) {
                    indexShowUser(data);
                },
                dataType: "json"
            });
           $("a[name='1']").addClass("currentPage");
           $.ajax({
              type:"GET",
              url:"/index/articlePage",
              data:{currentPage:1},
              success:function (data) {

                 for(var i=0;i<data.showList.length;i++){
                  var count="<li><img class='articleImg smallImg' src="+data.showList[i].image+" style='float: right;position: relative;right:700px;'/>" +
                      "<div class='articleShow'><h3 style='width: 800px' ><a href='/article/With?id="+data.showList[i].id+"' target='_blank'>"+data.showList[i].title+"</a></h3>" +
                      "<p style='width: 800px'>"+data.showList[i].content+"</p> " +
                      "<p style='width: 800px'>"+data.showList[i].userName+"  评论 "+data.showList[i].reviewNums+" 喜欢"+data.showList[i].likeNums+"</p></div></li>"

                  $("#articleShow").append(count);

                 }
              } ,
               dataType:"json"
           });
        };
        function jumpPage(obj) {
            var currentPage=$(obj).attr('name');

            $(".currentPage").removeClass("currentPage");
            $(obj).addClass("currentPage");
            $.ajax({
                type:"GET",
                url:"/index/userPage",
                data:{currentPage:currentPage},
                success:function (data) {
                    indexShowUser(data);
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
                        indexShowUser(data);
                    },
                    dataType:"json"
                })
            }
        }
        // 首页显示推荐作者公共
        function indexShowUser(data) {
            console.log(data);
            $("#pageUser").html("");
            for(var i=0;i<data.showList.length;i++){
                var userId=data.showList[i].id;
                var str="+关注";
                if(data.showList[i].status==1){
                    str="已关注";
                }
                var count="<a  href='/user/myPage?userId="+userId+"'  target='_blank' > <img  class='smallImg' src="+data.showList[i].img+"/>  "+data.showList[i].nickName+"</a>: 写了0.0 "+data.showList[i].likeNums+" 喜欢 <input class='yesAndNoConcern' name="+userId+" type='button' value="+str+"><br/>";
                $("#pageUser").append(count);
            }
        }
        function nextPage() {
            var currentPage=$(".currentPage").attr("name");
            currentPage=parseInt(currentPage)+1;

            var totalPageStr=$("a[name=changeAll]").attr('id');
            var totalPage=parseInt(totalPageStr)+1;



            if(currentPage!=totalPage) {
                $(".currentPage").removeClass("currentPage");

                $("a[name=" + currentPage + '' + "]").addClass("currentPage");
                $.ajax({
                    type: "GET",
                    url: "/index/userPage",
                    data: {currentPage: currentPage},
                    success: function (data) {
                        indexShowUser(data);
                    },
                    dataType: "json"
                })
            }
        }
        function changePage(obj) {
            var totalCount=$(obj).attr('id');

            var currentPage=parseInt(Math.random()*totalCount)+1;

            $(".currentPage").removeClass("currentPage");

            $("a[name=" + currentPage + '' + "]").addClass("currentPage");
            $.ajax({
                type: "GET",
                url: "/index/userPage",
                data: {currentPage: currentPage},
                success: function (data) {
                    indexShowUser(data);
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
                    $(obj).attr('name',name);
                    if(data.totalPage==name){
                       document.getElementById('showMore').disabled=true;


                    }

                } ,
                dataType:"json"
            });
        }
        $(".yesAndNoConcern").live('mouseenter',function () {
            var count=$(this).attr("value");
            console.log(count);
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
      $(".yesAndNoConcern ").live('click',function () {
          var userId=$(this).attr('name');
          console.log(userId);
          var node=$(this);
         $.ajax({
            type:"GET",
            url:"/user/concern",
            data:{"userId":userId},
            success:function (data) {

                if(data.data=="关注成功"){
                   node.attr("value","已关注");

                }
                if(data.data=="删除成功"){
                    node.attr("value","+关注");
                }
                if(data.msg=="请先登录"){
                    location.href="/login";
                }

            },
            dataType:"json"
         })

      });
      function getAllUser() {
          window.open('/allUser');
      }

    </script>

</head>



<body>
<jsp:include page="top.jsp"/>
<div class="content">
    推荐作者：    <a id="${pageBean.totalPage}" name="changeAll" href="javascript:void(0)" onclick="changePage(this)">换一批</a><br/>
    <div id="pageUser">

    </div>
    <ul class="pagination" style="display: none">
        <li><a href="javascript:void(0)" onclick="beforePage()" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
        <c:forEach begin="1" end="${pageBean.totalPage}" var="page">
        <li>
            <a href="javascript:void(0)"  name="${page}" onclick="jumpPage(this)">${page}</a>
        </li>
        </c:forEach>
        <li><a href="javascript:void(0)" onclick="nextPage()" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
    </ul>
    <input style="font-size: 20px;" type="button" onclick="getAllUser()" value="查看全部" />
</div>
<hr/>
<div id="articleShow">

</div>
<div class="showMore"  >
    <input id="showMore" name="1" type="button" onclick="showMoreArticle(this)" value="阅读更多" style="font-size: 20px; ;">
</div>

</body>
</html>
