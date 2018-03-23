<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8"/>
    <title>Legna我的图床</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/fileinput_locale_zh.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <style>
        html {
            position: relative;
            min-height: 100%;
        }
        body {
            margin-bottom: 60px;
        }
        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 60px;
            background-color: #f5f5f5;
        }

        body > .container {
            padding: 60px 15px 0;
        }
        .container .text-muted {
            margin: 20px 0;
        }

        .footer > .container {
            padding-right: 15px;
            padding-left: 15px;
        }

        code {
            font-size: 80%;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Legna</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/allPics">Pics</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <%--<li><a href="/changelog/">Change Log</a></li>
                <li><a href="/doc/">API</a></li>--%>
            </ul>
        </div><!--/.nav-collapse -->
    </div><!--/.container-fluid -->
</nav>
<div class="container kv-main">
    <div class="page-header">
        <h1>Image Upload</h1> 5 MB max per file. 10 files max per request.
    </div>
    <form enctype="multipart/form-data">
        <div class="form-group">
            <input id="smfile" type="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="1" data-max-file-count="10" name="fileup" accept="image/*">
        </div>
    </form>
    <div id="showurl" style="display: none;">
        <ul id="navTab" class="nav nav-tabs">
            <li class="active"><a href="#urlcodes" data-toggle="tab">URL</a></li>
            <li><a href="#htmlcodes" data-toggle="tab">HTML</a></li>
            <li><a href="#bbcodes" data-toggle="tab">BBCode</a></li>
            <li><a href="#markdowncodes" data-toggle="tab">Markdown</a></li>
            <li><a href="#markdowncodes2" data-toggle="tab">Markdown with Link</a></li>
            <li><a href="#deletepanel" data-toggle="tab">Delete Link</a></li>
        </ul>
        <div id="navTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="urlcodes">
                <pre style="margin-top: 5px;"><code id="urlcode"></code></pre>
            </div>
            <div class="tab-pane fade" id="htmlcodes">
                <pre style="margin-top: 5px;"><code id="htmlcode"></code></pre>
            </div>
            <div class="tab-pane fade" id="bbcodes">
                <pre style="margin-top: 5px;"><code id="bbcode"></code></pre>
            </div>
            <div class="tab-pane fade" id="markdowncodes">
                <pre style="margin-top: 5px;"><code id="markdown"></code></pre>
            </div>
            <div class="tab-pane fade" id="markdowncodes2">
                <pre style="margin-top: 5px;"><code id="markdownlinks"></code></pre>
            </div>
            <div class="tab-pane fade" id="deletepanel">
                <pre style="margin-top: 5px;"><code id="deletecode"></code></pre>
            </div>
        </div>
    </div>
    <script>
        $("#smfile").fileinput({
            uploadUrl: '${pageContext.request.contextPath}/upload.do',
            allowedFileExtensions : ['jpeg', 'jpg', 'png', 'gif', 'bmp'],
            overwriteInitial: false,
            maxFileSize: 5120,
            maxFilesNum: 10,
            maxFileCount: 10,
        });
        $('#smfile').on('fileuploaded', function(event, data, previewId, index) {
            var form = data.form, files = data.files, extra = data.extra, response = data.response, reader = data.reader;
            if(response.code == 'success') {
                if ( $("showurl").css("display") ) {
                    $('#urlcode').append(response.data.url + "\n");
                    $('#htmlcode').append("&lt;img src=\""+ response.data.url +"\" alt=\""+ files[index].name +"\" title=\""+ files[index].name +"\" /&gt;" + "\n");
                    $('#bbcode').append("[img]"+ response.data.url +"[/img]" + "\n");
                    $('#markdown').append("!["+ files[index].name +"](" + response.data.url + ")" + "\n");
                    $('#markdownlinks').append("[!["+ files[index].name +"](" + response.data.url + ")]" +"(" + response.data.url + ")" + "\n");
                    $('#deletecode').append(response.data.delete + "\n");

                } else if (response.data.url) {
                    $("#showurl").show();
                    $('#urlcode').append(response.data.url + "\n");
                    $('#htmlcode').append("&lt;img src=\""+ response.data.url +"\" alt=\""+ files[index].name +"\" title=\""+ files[index].name +"\" /&gt;" + "\n");
                    $('#bbcode').append("[img]"+ response.data.url +"[/img]" + "\n");
                    $('#markdown').append("!["+ files[index].name +"](" + response.data.url + ")" + "\n");
                    $('#markdownlinks').append("[!["+ files[index].name +"](" + response.data.url + ")]" +"(" + response.data.url + ")" + "\n");
                    $('#deletecode').append(response.data.delete + "\n");
                }
            }
        });
    </script>
</div>
<footer class="footer">
    <div class="container">
        <p class="text-muted">Copyright &#9400; 2017 Cat Networks Hong Kong Limited. All rights reserved. 请勿上传违反中国大陆和香港法律的图片，违者后果自负。</p>
    </div>
</footer>
</body>
</html>

