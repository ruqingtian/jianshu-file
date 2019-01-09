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
            width: 640px;

        }
        .articleImg{
            width: 390px;
            height: 270px;
        }
    </style>
    <title>文章详情</title>
    <script type="text/javascript">
        $(function () {
            reviewShowAgain();
            $.ajax({
                type:"GET",
                url:"/user/isUserLogin",
                success:function (data) {
                    console.log(data);
                    if(data.userName!=null){
                        $("#reviewTouXiangImg").attr("src",data.img);
                        var userId=$(".yesAndNoConcern").parent().attr("name");
                        if(userId==data.id){
                          $(".yesAndNoConcern").attr("style","display:none");
                        }
                    }else{

                        $("#reviewText").attr("placeholder","登录后发表评论");
                    }

                },
                dataType:"json"
            });
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
        });

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
        //提交评论
        function submitReview() {
            var img=$("#reviewTouXiangImg").attr("src");
            if(img!="/"){
                var node=document.getElementById("reviewText");
                var content=$("#reviewText").attr("value");
                var articleId=$("#reviewText").attr("name");
                if(content.trim()!=""){
                    $.ajax({
                        type:"POST",
                        url:"/article/addreview",
                        data:{"content":content,"articleId":articleId},
                        success:function (data) {
                            alert("回复成功");
                            node.value="";
                            reviewShowAgain();
                        },
                        dataType:"json"
                    })
                }
            }
        }
        //显示删除评论按钮
        $("div[name='reviewdiv']").live("mouseover",function () {
            yesAndNorevoew($(this));
        });
        //刷新评论
        function reviewShowAgain() {
            var articleId=$("#reviewArea").attr("name");
            $("#reviewArea").html("");
            $.ajax({
                type:"GET",
                url:"/article/showReview",
                data:{"articleId":articleId},
                success:function (data) {
                    var size=data.length;
                    for(var i=0;i<data.length;i++) {
                        var count = "<div name='reviewdiv' id=review"+data[i].userId+"><img class='smallImg' src=" + data[i].img +
                            "/>"+data[i].userName+"   "+size+"楼 "+data[i].date+"<br/>"+data[i].content+
                            "<br/><input name='deleteReview' id='deleteReview"+data[i].reviewId+"' type='button' style='display: none' value='删除' /></div> ";
                        size--;
                        $("#reviewArea").append(count+"<br/>");
                    }


                },
                dataType:"json"
            });
        }
        //隐藏删除按钮
        $("div[name='reviewdiv']").live("mouseout",function () {
            $(this).find("input").css("display",'none');

        });
        function yesAndNorevoew(obj) {
            var id=$(obj).attr('id');
            id=id.slice(6);
            $.ajax({
                type:"GET",
                url:"/review/yesOrNo",
                data:{"id":parseInt(id)},
                success:function (data) {
                    if(data.data==="本人评论"){
                        $(obj).find("input").css("display",'inline');
                    }
                },
                dataType:"json"

            })
        }
        $("input[name='deleteReview']").live("click",function () {
            var id=$(this).attr('id');
            id=parseInt(id.slice(12));
           $.ajax({
               type:"GET",
               url:"/review/delete",
               data:{"reviewId":id},
               success:function (data) {
                   reviewShowAgain();
               },
               dataType:"json"

           })
        })
    </script>
</head>
<body >
<div >
    <jsp:include page="top.jsp"/>
</div>

<div  style="margin-left: 90%;margin-top:500px;position:fixed;width: 100px;height: 100px;">
    <a href="#topHtml" style="position:fixed;margin-right: 80px;margin-bottom: 50px"><img style="width: 50px" src="/image/back.png"></a>
</div>
<div class="content" style="margin-left:20%;padding-top:100px " id="topHtml" >
    <div style="position:relative;text-align: center; margin-left:10px; margin-top:50px;">
        <p style="font-size: 40px;width: 100%;"><Strong>${article.title}</Strong></p><br/>
        <div style="padding-left: 20%">
        <div style="float: left">
            <img class="smallImg" src="${user.img}"/>
        </div>
        <div  >
            <div name="${user.id}"  style="text-align: left"><span style="padding-left: 10px;padding-right:10px;font-size: 25px">${user.nickName}</span><input class="yesAndNoConcern"
                                        name="${article.userId}" type="button"
                                        value="+关注"
                                        style="font-size: 20px; color: black;background-color: #6ce26c"/>
            </div>
            <div style="color: #646464;text-align: left;font-size: 15px">${article.showTime} 字数 ${article.number} 阅读 ${article.readNums} 评论 ${article.reviewNums}
                喜欢 ${article.likeNums}
            </div>

        </div>
        </div>
    </div>
    <div>
        <img style="width: 640px" class="articleImg" src="${article.image}"/>
    </div>


    <div ><strong>
             ${article.content}
          </strong>
    </div>
    <div style="padding-bottom: 50px">
        <input name="${article.id}" onclick="yesAndNoLike(this)" type="button" style="border: 1px solid red; border-radius: 18px;;height: 70px;font-size: 30px;color: red"
               value="喜欢  :   ${article.likeNums}"/>
    </div>
    <div>
        <img id="reviewTouXiangImg" class="smallImg" src="/"/><textarea name="${article.id}" id="reviewText" placeholder="写下你的评论" style="width: 500px" rows="5" cols="20"></textarea><br/>
        <input type="button" onclick="submitReview()" value="提交"/>
        <input type="button" onclick="cleanReview()" value="取消"/>

    </div>

    <div id="reviewArea" name="${article.id}" style="padding-top: 30px">

    </div>


</div>


</body>
</html>
