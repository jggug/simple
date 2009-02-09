

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>${page.title}</title>
    </head>
    <body>
      <div class="body-block">

            <div class="nav" align="right">
                <span class="menuButton">
                  <a href="${createLinkTo(url:'/')}/create/new" class="create">新規ページ追加</a>
                </span>
                <g:if test="${page}">
                <span class="menuButton">
                  <a href="${createLinkTo(url:'/')}/edit/${page.id}" class="edit">編集</a>
                </span>
                </g:if>
            </div>
            <g:if test="${page.page}">
              <div style="padding:3px;">
              <a href="${createLinkTo(url:'/')}/display/${page.page.title}">
                ${page.page.title?.encodeAsHTML()}</a>
                &nbsp;>&nbsp;
                <a href="${createLinkTo(url:'/')}/display/${page.title}">
                ${page.title?.encodeAsHTML()}</a>
              </div>
            </g:if>
            <div class="infomation_bar">
              追加したユーザーは ${page.created?:"不明"} です。最後に編集したユーザーは ${page.updated?:"不明"}で、その日時は <g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${page.lastUpdated}"/> です。
            </div>


            <div class="wiki-content" style="width:100%;margin:15px 0 20px 0;">
              <w:show>
                ${page?.body}
              </w:show>
            </div>

            <div style="width:100%;margin:10 0 10 0;padding:10 0 1 0;border-bottom:2px solid #3C78B5">
              子ページ 
                <a href="${createLinkTo(url:'/')}/create/${page.id}?addChild">
                  <img src="${createLinkTo(dir:'images',file:'skin/database_add.png')}" border="0"/>追加
                </a>
            </div>
            <g:if test="${page.pages.size()>0}">
            <div style="width:100%;border:1px solid #ccc">
              <ul style="margin-top:5px">
              <g:each var="p" in="${page.pages}">
                  <li>
                    <a href="${createLinkTo(url:'/')}/display/${p.title}">
                    ${p.title?.encodeAsHTML()}</a>
                  </li>
              </g:each>
              </ul>
            </div>
            </g:if>
      </div>
    </body>
</html>
