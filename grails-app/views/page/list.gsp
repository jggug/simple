

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Page List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Page</g:link></span>
        </div>
        <div class="body">
            <h1>Page List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="title" title="Title" />
                        
                   	        <g:sortableColumn property="body" title="Body" />
                        
                   	        <th>Page</th>
                   	    
                   	        <g:sortableColumn property="dateCreated" title="Date Created" />
                        
                   	        <g:sortableColumn property="lastUpdated" title="Last Updated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${pageList}" status="i" var="page">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${page.id}">${fieldValue(bean:page, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:page, field:'title')}</td>
                        
                            <td>${fieldValue(bean:page, field:'body')}</td>
                        
                            <td>${fieldValue(bean:page, field:'page')}</td>
                        
                            <td>${fieldValue(bean:page, field:'dateCreated')}</td>
                        
                            <td>${fieldValue(bean:page, field:'lastUpdated')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Page.count()}" />
            </div>
        </div>
    </body>
</html>
