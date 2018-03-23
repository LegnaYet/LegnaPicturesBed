<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/21
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="myPictures" name="myPictures" enctype="multipart/form-data"
      action="${pageContext.request.contextPath}/upload.do"
      method="post">
    <input type="file" name="fileup" id="fileup" multiple />
    <input type="submit" value="上传">
</form>
</body>
<script>
    $(function () {
        var max_size = 9437184;
        $("#fileup").change(function(evt) {
            var finput = $(this);
            var files = evt.target.files;
            var output = [];
            for (var i = 0, f; f = files[i]; i++) {
                if (f.size > max_size) {
                    alert("上传文件不能超过9M");
                    $(this).val('');
                }
            }
        });
    })
</script>
</html>
