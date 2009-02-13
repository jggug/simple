<g:if test="${pages}">
  <ul class="jqueryFileTree" style="display:none;">
    <g:each in="${pages}" var="page">
      <li class="directory collapsed">
        <a href="#" rel="${page.id}/${page.title}">${page.title}</a>
      </li>
    </g:each>
  </ul>
</g:if>
  