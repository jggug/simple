

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Page</title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Page List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Page</g:link></span>
        </div> -->
        <div class="body">
            <h1>Edit Page</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${page}">
            <div class="errors">
                <g:renderErrors bean="${page}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${page?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:page,field:'title','errors')}">
                                    <input type="text" id="title" name="title" value="${fieldValue(bean:page,field:'title')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="body">Body:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:page,field:'body','errors')}">
                                    <textarea rows="5" cols="40" name="body">${fieldValue(bean:page, field:'body')}</textarea>
                                </td>
                            </tr> 
                        
                            <!-- <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="page">Page:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:page,field:'page','errors')}">
                                    <g:select optionKey="id" from="${Page.list()}" name="page.id" value="${page?.page?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr>  -->
                        
                        
                            <!-- <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pages">Pages:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:page,field:'pages','errors')}">
                                    
<ul>
<g:each var="p" in="${page?.pages?}">
    <li><g:link controller="page" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="page" params="['page.id':page?.id]" action="create">Add Page</g:link>

                                </td>
                            </tr>  -->
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
