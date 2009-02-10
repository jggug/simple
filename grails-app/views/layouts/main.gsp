<% def config = org.codehaus.groovy.grails.commons.ConfigurationHolder.getConfig() %>
<g:set var="feedUrl" value="${config.grails.serverURL+'/page/lastUpdate'}" />
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
  <link href="${feedUrl}" title="RSS 2.0" type="application/rss+xml" rel="alternate"/>
  <g:layoutHead />
  <g:javascript library="prototype" />
</head>
<body>
  <div id="spinner" class="spinner" style="display:none;">
    <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
  </div>	
  <div id="custom-doc" class="yui-t2">
    <div id="hd">
      <div class="header_block">
        <div class="head_bar">
          <div style="float:left;">
            <span style="font-size:10px;">ようこそ </span>
            <g:loggedInUserInfo field="userRealName">ゲスト</g:loggedInUserInfo><span style="font-size:10px;">さん</span>
          </div>
          <g:isLoggedIn>
          <div style="font-size:10px;">
            &nbsp;&nbsp;<g:link controller="logout" style="color:white;">(ログアウト)</g:link>
            [<g:link controller="register" action="edit" style="color:white;">登録情報編集</g:link>]
          </div>
          </g:isLoggedIn>
          <g:isNotLoggedIn>
            <div style="font-size:10px;">
              <g:link controller="login" style="color:white;">(ログイン)</g:link>
              [<g:link controller="register" style="color:white;">登録</g:link>]
            </div>
          </g:isNotLoggedIn>

        </div>
        <%/** ロゴブロック */%>
        <div class="logo">
          <a class="home" href="${createLinkTo(dir:'')}">
           <span style="font-size:32px;">
             <img src="${config.simple.contents.logoimg}" border="0" align="middle"/>
           </span>
          </a>
          <g:if test="${page}">
            <a href="${createLinkTo(url:'/')}/display/${page.title}">
            <span style="font-size:22px;font-weight:bold;">${page.title}</span>
            </a>
          </g:if>
        </div>
        <%/** ツールバー */%>
        <!-- <div class="nav" align="right">
            <span class="menuButton">
              <g:link class="create" controller="page" action="create">新規ページ追加</g:link>
            </span>
            <g:if test="${page}">
              <a href="${createLinkTo(url:'/')}/edit/${page.id}">編集</a>
            </g:if>
        </div> -->

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
      <g:if test="${config.simple.contents.menupage}">
      <div class="yui-b">
        <g:set var="menu" value="${Page.findByTitle(config.simple.contents.menupage)}" />
        <w:show>
          ${menu?.body}
        </w:show>
        
        <%/** 更新履歴 */%>
        <div class="rss_title">
          更新履歴 
            <a href="${feedUrl}">
              <img src="${createLinkTo(dir:'images',file:'rssfeed.gif')}" border="0"/>
            </a>
        </div>
        <f:feed url="${feedUrl}">
          <g:each in="${feed.entries}" var="page">
            <div class="recentlyUpdatedItem">
              <a href="${page.link}">${page.title}</a>
              <div style="font-size:8px;text-align:right;">
                ${f.dateFormat(format:"yyyy/MM/dd HH:mm",date:page.publishedDate)}/by ${page.author}
              </div>
            </div>
          </g:each>
        </f:feed>
      </div>
      </g:if>
      <%/** 開発用メニュー */%>
      <!-- <g:isLoggedIn>
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
      </g:isLoggedIn> -->
      
    </div>
    <%/** フッター */%>
    <div id="ft" style="margin-top:10px;text-align:center;">
      <hr/>
      ${config.simple.contents.footer.copy}
    </div>
  </div>
</body>	
</html>