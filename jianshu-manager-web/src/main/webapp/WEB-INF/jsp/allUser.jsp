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
    <title>推荐作者-简书</title>

    <style type="text/css">
    .userDiv>div{
        text-align: center;
        margin-top: 15px
    }
        a{
            text-decoration: none;
            color: black;
        }
    a:hover{
        text-decoration: underline;
    }
    .yesOrNoConcernStyle{
            font-size: 25px;border-radius: 10px;background-color: #3db922;color: white
        }


    </style>
    <script type="text/javascript">
        $(function () {
            var currentPage=1;
            getUser(currentPage);
        });
        function getMoreUser(obj) {
           var currentPage=parseInt($(obj).attr('name'));
           var max=$("#getMoreUserDiv").attr('name');
           if(currentPage!=max){
               getUser(currentPage+1);
               $(obj).attr('name',currentPage+1);
           }else{
               $(obj).attr("disabled",true);
           }
        }
        function getUser(currentPage) {
            $.ajax({
                type:"GET",
                url:"/user/getAll",
                data:{"currentPage":currentPage},
                success:function (data) {
                    console.log(data);

                    for(var i=0;i<data.showList.length;i++){
                        $("#getMoreUserDiv").attr("name",data.totalPage);
                        if(data.showList[i].concernStatus==0){
                            var str="+关注";
                            var addClass="yesOrNoConcernStyle ";
                        }else{
                            var str="已关注";
                            var addClass=" ";
                        }
                        if(data.showList[i].desc!=null) {
                            if (data.showList[i].desc.length > 20) {
                                desc=data.showList[i].desc.substring(0,20)+"...";
                            } else {

                                var desc = data.showList[i].desc;
                            }
                        }else{
                            var desc="<span style='color:#646464;'>该用户暂时没有设置个性签名</span>";
                        }
                        var articleTitles="";
                        for(var j=0;j<data.showList[i].articleTitle.length;j++){
                            var title=data.showList[i].articleTitle[j].title;
                            if(data.showList[i].articleTitle[j].title.length>=18){
                                 title=title.substring(0,18)+"...";
                            }
                             title="<p><a href='/article/With?id="+data.showList[i].articleTitle[j].id+"'>"+title+"</a></p>";
                            articleTitles=articleTitles+title;
                        }
                        if(data.showList[i].articleTitle.length==0){
                            articleTitles="<span style='color:#646464;'>该用户还没有文章</span>";
                        }

                        var content="<div style='margin-top: 40px;width: 33%;float:left'>" +
                                         "<div class='userDiv' style='border: 1px solid #646464;margin: 20px 15px;height:450px;'>" +
                                            "<div><a href='/user/myPage?userId="+data.showList[i].id+"' ><img style='width: 80px;height: 80px' src="+data.showList[i].img+"/></a></div> " +
                                            "<div style='font-size: 30px'><a href='/user/myPage?userId="+data.showList[i].id+"' ><strong>"+data.showList[i].nickName+"</strong></a></div>" +
                                            " <div style='height: 42px'>"+desc+"</div> " +
                                            "<div style=''><input style='font-size: 25px;border-radius: 10px;' class='yesAndNoConcern "+addClass+"' name="+data.showList[i].id+" type='button' value="+str+"></div>" +

                                            " <hr/><span style='color: #646464'>最近更新</span>" +
                                            "<div >"+articleTitles+"</div>" +
                                         "</div>" +
                                    "</div>";
                        $("#content").append(content);





                    }
                },
                dataType:"json"
            })
        }
    </script>
</head>
<body>

<jsp:include page="top.jsp"/>

<div style="padding-top: 100px;padding-left: 10%">
    <div style="width: 90%;background-color: #00b7ee;height: 100px ">
        <div style="font-size: 30px;color: white;line-height: 100px;text-align: center"><strong>推荐作者</strong></div>
    </div>

    <div class=" " style="width: 90%"  id="content">

    </div>
    <div style="clear: both"></div>
    <div style="text-align: center;margin-bottom: 200px;width: 90%"  id="getMoreUserDiv">
        <input style="font-size: 30px;width: 300px;border-radius: 18px;background-color: #646464;color: white" type="button" name=1 id="getMoreUser" onclick="getMoreUser(this)" value="加载更多"/>
    </div>
</div>
</body>
</html>
