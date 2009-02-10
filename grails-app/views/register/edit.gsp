
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>ユーザー情報</title>
  </head>
  <body>
    <div class="body">
      <h2>ユーザー情報</h21>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${person}">
        <div class="errors">
          <g:renderErrors bean="${person}" as="list" />
        </div>
      </g:hasErrors>

      <g:form controller="register" method="post" >
        <input type="hidden" name="id" value="${person?.id}" />
        <div class="dialog">
          <table>
            <tbody>

        <tr class='prop'>
          <th valign='top' class='name'>
            <label for='username'>ログインアカウント:</label>
          </th>
          <td valign='top'
            class='value ${hasErrors(bean:person,field:'username','errors')}'>
          <input type="hidden" name='username'
            value="${person?.username?.encodeAsHTML()}"/>
            <div style="margin:3px">${person?.username?.encodeAsHTML()}</div>
          </td>
        </tr>

			  <tr class='prop'>
			    <td valign='top' class='name'>
			      <label for='userRealName'>ユーザー名:</label>
			    </td>
				<td valign='top'
				    class='value ${hasErrors(bean:person,field:'userRealName','errors')}'>
				  <input type="text" name='userRealName'
				         value="${person?.userRealName?.encodeAsHTML()}"/>
				</td>
			  </tr>

        <tr class='prop'>
          <td valign='top' class='name'>
            <label for='passwd'>パスワード:</label>
          </td>
          <td valign='top'
            class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
            <input type="password" name='passwd' value=""/>
          </td>
        </tr>

        <tr class='prop'>
          <td valign='top' class='name'>
            <label for='enabled'>パスワード確認:</label>
          </td>
          <td valign='top'
            class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
            <input type="password" name='repasswd'
              value=""/>
          </td>
        </tr>

			  <tr class='prop'>
			    <td valign='top' class='name'>
			      <label for='email'>メールアドレス:</label>
			    </td>
				<td valign='top'
				    class='value ${hasErrors(bean:person,field:'email','errors')}'>
				  <input type="text" name='email'
				         value="${person?.email?.encodeAsHTML()}"/>
				</td>
			  </tr>

        <tr class='prop'>
          <td valign='top' class='name'>
            <label for='emailShow'>メールアドレス表示:</label>
          </td>
          <td valign='top' 
            class='value ${hasErrors(bean:person,field:'emailShow','errors')}'>
            <g:checkBox name='emailShow' value="${person?.emailShow}" ></g:checkBox>
          </td>
        </tr>

            </tbody>
          </table>
        </div>

        <div class="buttons">
          <span class="button"><g:actionSubmit value="Update" /></span>
        </div>

      </g:form>

    </div>
  </body>
</html>
