<%--
  Created by IntelliJ IDEA.
  User: Tian
  Date: 2018/11/9
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript " src="/js/jquery.cookie.js"></script>
    <style type="text/css">
        .content{
            width: 80%;
            text-align: center;
        }
    </style>
    <title>文章详情</title>
    <script type="text/javascript">
        $(function () {
            var node=$(".yesAndNoConcern");
            var userId=node.attr("name");
            $.ajax({
                type:"GET",
                url:"/user/judgeConcern",
                data:{"userId":userId},
                success:function (data) {
                    if(data.data=="未关注"){
                        node.attr("value","+关注");
                    }else if(data.data=="已关注"){
                        node.attr("value","已关注");
                    }
                },
                dataType:"json"
            })
        })

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
        function yesAndNoLike(obj) {
            var articleId=$(obj).attr('name');
            $.ajax({
                type:"GET",
                url:"/article/like",
                data:{"articleId":articleId},
                success:function (data) {
                    console.log(data);
                    if(data.msg=="请先登录"){
                        location.href="/login";
                    }
                    $(obj).attr("value","喜欢  :   "+data.data);
                },
                dataType:"json"
            })
        }
    </script>
</head>
<body>
<jsp:include page="top.jsp"/>
<div class="content" style="position:relative; margin-left:10px; margin-top:50px;">
    <h2>${article.title}</h2><br/>
    <p><img  class="smallImg" src="${user.img}"/>${user.nickName}<input class="yesAndNoConcern" name="${article.userId}" type="button" value="+关注" style="font-size: 15px; background: #6ce26c"/></p>
    <p style="font-size: 15px">${article.showTime} 字数 ${article.number} 阅读 ${article.readNums} 评论 0 喜欢 ${user.likeNums}</p>
</div>
<div class="content">
<img src="${article.image}"/>
</div>
<div class="content">
    ${article.content}
</div>
<div class="content">
    <input name="${article.id}" onclick="yesAndNoLike(this)" type="button" style="font-size: 30px;color: red" value="喜欢  :   ${user.likeNums}"/>
</div>
</body>
</html>
