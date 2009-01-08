<html>
<head>
  <title><g:layoutTitle default="Grails" /></title>
  <link rel="stylesheet" type="text/css" 
    href="http://yui.yahooapis.com/2.6.0/build/base/base-min.css">
  <link rel="stylesheet" type="text/css" 
    href="http://yui.yahooapis.com/2.6.0/build/reset-fonts-grids/reset-fonts-grids.css">
    <style type="text/css">
    #custom-doc { width: 90%; min-width: 550px; }
    </style>
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'wiki.css')}" />
  <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
  <g:layoutHead />
  <g:javascript library="application" />
</head>
<body>
  <div id="spinner" class="spinner" style="display:none;">
      <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
  </div>	
  <div id="custom-doc" class="yui-t2">
    <div id="hd">
      <div class="header_block">
        <%/** ロゴブロック */%>
        <div class="logo">
          <a class="home" href="${createLinkTo(dir:'')}">
           <span style="font-size:32px;">
             <img src="http://grails.jp/images/logo.png" border="0" />
             <!-- Simple Contents -->
          </span>
          </a>
          <br/>
          <g:if test="${page}">
            <g:link controller="page" action="show" id="${page.id}">
            <span style="font-size:16px;margin-left:20px;font-weight:bold;">${page.title}</span>
            </g:link>
          </g:if>
        </div>
        <%/** ツールバー */%>
        <div class="nav" align="right">
            <span class="menuButton">
              <g:link class="create" controller="page" action="create">新規ページ追加</g:link>
            </span>
            <g:if test="${page}">
              <g:link class="edit" controller="page" action="edit" id="${page.id}">編集</g:link>
            </g:if>
        </div>

      </div>
    </div>
    <div id="bd">
      <%/** メイン */%>
      <div id="yui-main">
        <div class="yui-b">
          <div class="yui-g">
            <g:layoutBody />
          </div>
        </div>
      </div>
      <%/** メニュー */%>
      <div class="yui-b">
        <g:set var="menu" value="${Page.findByTitle('menu')}" />
        <w:show>
          ${menu?.body}
        </w:show>
      </div>
      <%/** 開発用メニュー */%>
      <g:isLoggedIn>
      <g:ifAnyGranted role="ROLE_ADMIN,ROLE_SUPERVISOR">
      <div class="yui-b">
        <h3>開発用メニュー</h3>
        <ul>
          <g:each var="c" in="${grailsApplication.controllerClasses}">
                <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
          </g:each>
        </ul>        
      </div>
      </g:ifAnyGranted>
      </g:isLoggedIn>
      
    </div>
    <%/** フッター */%>
    <div id="ft" style="margin-top:10px;text-align:center;">
      <hr/>
      &copy;2008-2009 grails.jp
    </div>
  </div>
</body>	
</html>