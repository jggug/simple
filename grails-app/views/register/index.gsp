<% def config = org.codehaus.groovy.grails.commons.ConfigurationHolder.getConfig() %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Grails Wiki ユーザー登録</title>
    <link rel="stylesheet" type="text/css" 
      href="http://yui.yahooapis.com/2.6.0/build/base/base-min.css">
    <link rel="stylesheet" type="text/css" 
      href="http://yui.yahooapis.com/2.6.0/build/reset-fonts-grids/reset-fonts-grids.css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'wiki.css')}" />
<style type="text/css" media="screen">
  #regist {
    margin: 20px 20px 40px 20px;
    width:450px;
  }
</style>
  </head>
  <body>
    <div id="regist">
      <div class="logo">
        <a class="home" href="${createLinkTo(dir:'')}">
         <span style="font-size:32px;">
           <img src="${config.simple.contents.logoimg}" border="0" align="middle"/>
         </span>
        </a>
      </div>
      <h2>Grails Wiki ユーザー登録</h2>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${person}">
        <div class="errors">
          <g:renderErrors bean="${person}" as="list" />
        </div>
      </g:hasErrors>
      <g:form action="save" method="post" >
          <table>
            <tbody>
              <tr class='prop'>
                <td valign='top' class='name'>
                  <label for='username'>ログインアカウント:</label>
                </td>
                <td valign='top' 
                	class='value ${hasErrors(bean:person,field:'username','errors')}'>
                  <input type="text" name='username' 
                  		 value="${person?.username?.encodeAsHTML()}"/>
                </td>
              </tr>
              <tr class='prop'>
                <td valign='top' class='name'>
                  <label for='userRealName'>お名前:</label>
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
                  <input type="password" name='passwd' 
                         value="${person?.passwd?.encodeAsHTML()}"/>
                </td>
              </tr>
                       
              <tr class='prop'>
                <td valign='top' class='name'>
                  <label for='enabled'>パスワード確認用:</label>
                </td>
                <td valign='top' 
                	class='value ${hasErrors(bean:person,field:'passwd','errors')}'>
                  <input type="password" name='repasswd' 
                         value="${person?.passwd?.encodeAsHTML()}"/>
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
                <td valign='bottom' class='name'>
                  <label for='code'>Enter Code: </label>
                </td>
                <td valign='top' class='name'>
                  <input type="text" name="captcha" size="8"/>
                  <img src="${createLink(controller:'captcha', action:'index')}" align="absmiddle"/>
                </td>
              </tr>

            </tbody>
          </table>
        
        <div class="buttons">
          <span class="formButton">
            <input type="submit" value="Create"></input>
          </span>
        </div>
      </g:form>
    </div>
  </body>
</html>
