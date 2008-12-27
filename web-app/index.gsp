<html>
<head>
  <title>Welcome to Simple</title>
<meta name="layout" content="main" />
</head>
<body>

    <div class="dialog" style="">
      <g:set var="top" value="${Page.findByTitle('top')}" />
      ${top?.body?.replaceAll(/\r\n|\r|\n/,"<br/>")}
    </div>
    <!-- <div class="dialog" style="margin-left:20px;width:60%;">
        <ul>
          <g:each var="c" in="${grailsApplication.controllerClasses}">
                <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
          </g:each>
        </ul>
    </div> -->
</body>
</html>