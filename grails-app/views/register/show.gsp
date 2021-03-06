  
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>ユーザー情報</title>
  </head>
  <body>
    
    <div class="body">
      <h2>ユーザー情報</h2>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name">ログインアカウント:</td>
              <td valign="top" class="value">
              	${person.username?.encodeAsHTML()}
              </td>
            </tr>
                   
            <tr class="prop">
              <td valign="top" class="name">ユーザー名:</td>
              <td valign="top" class="value">
                ${person.userRealName?.encodeAsHTML()}
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">メールアドレス:</td>
              <td valign="top" class="value">
                ${person.email?.encodeAsHTML()}
              </td>
            </tr>
                   
            <tr class="prop">
              <td valign="top" class="name">メールアドレス表示:</td>
              <td valign="top" class="value">
                ${person.emailShow?.encodeAsHTML()}
              </td>
            </tr>
                   
            <tr class="prop">
              <td valign="top" class="name">Roles:</td>
              <td valign="top" class="value">
                <ul>
                <g:collect in="${person.authorities}" expr="${it.authority}">
                  <li>${it?.substring(5)?.toLowerCase()}</li>
                </g:collect>
                </ul>
              </td>
            </tr>
                   
          </tbody>
        </table>
      </div>
      
      <div class="buttons">
        <g:form controller="register">
          <input type="hidden" name="id" value="${person?.id}" />
          <span class="button"><g:actionSubmit value="Edit" /></span>
        </g:form>
      </div>
      
    </div>
  </body>
</html>
