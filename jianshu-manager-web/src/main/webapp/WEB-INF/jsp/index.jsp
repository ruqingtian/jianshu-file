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
    <script type="text/javascript" src="/js/index.js"></script>
    <link rel="stylesheet" href="/css/index.css">
    <title>简书-创作你的创作</title>

    <style type="text/css">
        a{
            text-decoration: none;

        }
        a:link{
            color: black;
        }
        a:visited{
            color: #3b4249;
        }

        .content{

            margin-left: 90px;
            margin-top:100px;
        }

        .lunbotu{

            float:left;

            width: 55%;



        }
        .remen{

            float:left;

            width:450px;

        }
        #articleShow{
            width:60% ;
        }

    </style>
    <script type="text/javascript">


    </script>

</head>



<body>
<jsp:include page="top.jsp"/>
<div id="topHtml" style="width:1360px;position: absolute">

    <div class="content">

        <div class="lunbotu"><img style="width: 100%;" src="/image/lunbotu.png"></div>
        <div class="remen"><img style="padding-left:100px;" src="/image/remen.png"></div>
    </div>
    <div style="clear:both"></div>
    <div style="width: 65%;float:left">
        <div class="content" id="articleShow" style="width: 80%;margin-top:100px">

        </div>
        <div style="clear:none"></div>
        <div class="showMore">
            <input id="showMore" name="1" type="button" onclick="showMoreArticle(this)" value="阅读更多"
                   style="font-size: 20px;margin-top:50px;margin-bottom: 100px ;width:60%;margin-left:10%;">
        </div>
    </div>

    <div style="width:350px;float:left;margin-top:100px;margin-left:10px">
        <div style="font-size: 24px;color: #646464">
            推荐作者： <a style="color: #646464;margin-left:100px;" id="${pageBean.totalPage}" name="changeAll" href="javascript:void(0)"
                     onclick="changePage(this)">换一批</a>
        </div>
        <div style="clear:none"></div>
        <div id="pageUser" style="margin-right: 100px;margin-top:30px">

        </div>

            <input style="font-size: 20px;margin-top:50px;width: 100%" type="button" onclick="getAllUser()" value="查看全部"/>
        </div>

        <%--分页--%>
        <%--<ul class="pagination" style="display: none">
            <li><a href="javascript:void(0)" onclick="beforePage()" aria-label="Previous"><span
                    aria-hidden="true">&laquo;</span></a></li>
            <c:forEach begin="1" end="${pageBean.totalPage}" var="page">
                <li>
                    <a href="javascript:void(0)" name="${page}" onclick="jumpPage(this)">${page}</a>
                </li>
            </c:forEach>
            <li><a href="javascript:void(0)" onclick="nextPage()" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a>
            </li>
        </ul>--%>
    <div  style="position:fixed;float: right;margin-left: 95%;margin-top: 100px"><a href="#topHtml"><img style="width: 50px" src="/image/back.png"></a></div>
    </div>

</div>



</body>
</html>
