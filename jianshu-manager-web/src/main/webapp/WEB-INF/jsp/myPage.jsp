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
    <title>我的主页</title>
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
            console.log(3);
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
    </script>
</head>
<body>
<jsp:include page="top.jsp"/>
<div class="content all">
    <img style="height: 80px" src="${user.img}"/>   <span style="font-size: 30px">${user.nickName}</span><br/>
    关注 ${user.concernNums} 粉丝 ${user.fansNums}  文章${user.articleNums} 字数${user.count}   收获喜欢 ${user.likeNums}
</div>
<div class="all" name="${user.id}">
    <input type="button" id="getAllArticle" onclick="getAllArticle(this)" value="文章"/>
    <input type="button" onclick="getDynamic(this)" value="动态"/>
    <input type="button" onclick="getNewReview(this)" value="最新评论"/>
    <input type="button" onclick="getHot(this)" value="热门"/>

</div>
<div class="all" id="content">

</div>

</body>
</html>
