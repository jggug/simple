<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <!-- <meta name="layout" content="main" /> -->
  <title>ページ一覧</title>
  <link rel="stylesheet" href="${createLinkTo(dir:'js/jqueryFileTree',file:'jqueryFileTree.css')}" />
  <script src="${createLinkTo(dir:'js',file:'jquery-1.3.1.min.js')}"></script>
  <script src="${createLinkTo(dir:'js',file:'jquery.easing.1.3.js')}"></script>
  <script src="${createLinkTo(dir:'js/jqueryFileTree',file:'jqueryFileTree.js')}"></script>
  <script type="text/javascript" charset="utf-8">
    $(document).ready(function(){
      $('#treeArea').fileTree({
        root:'',
        script:"${createLink(controller:'page',action:'pageTreeDetail')}"
      },function(file) {
        alert(file);
      });
    });
  </script>
</head>
<body>
  <div class="body">
    <div id="treeArea" style="width:300px">
    </div>
  </div>
</body>
</html>
