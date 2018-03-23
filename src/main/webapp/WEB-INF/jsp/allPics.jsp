<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/21
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>所有图片</title>
    <style type="text/css">
        .pic{
            float: left;
        }
    </style>
</head>
<body>
<div >
    <c:forEach items="${pictures}" var="picture">
        <div class="pic" style="width: 25% ;height: 250px">
            <div style="width: 200px ;height: 200px" onclick="toPic('${picture.url}')">
                <img width="200px"   src="http://${picture.url}">
            </div>
        </div>
    </c:forEach>
</div>
</body>
<script>
    function toPic(url) {
        location.href="http://"+url;
    }
</script>
</html>
