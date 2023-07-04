<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:if test="${page.n_page > 1}">
    <div class="col-12">         
           <nav aria-label="Page navigation">
               <ul class="pagination">
               		<c:if test="${page.pg > 1}">				
						<li class="page-item">
							<a class="page-link"href="${path}${get_txt}${page.pg - 1}">
								<i class="bi bi-chevron-left"></i>
							</a>
						</li>
					</c:if>
					
					<c:if test="${page.n_page > 1}">
						<c:forEach var="i" begin="${page.n_start}" end="${page.n_end}">
							<c:choose>
								<c:when test="${page.pg != i}">
									<li class="page-item"><a class="page-link" href="${path}${get_txt}${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item active"><a class="page-link" href="${path}${get_txt}${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
					
					<c:if test="${page.pg < page.n_page && page.n_page > 1}">
						<li class="page-item">
							<a class="page-link" href="${path}${get_txt}${page.pg + 1}">
								<i class="bi bi-chevron-right"></i>
							</a>
						</li>
					</c:if>

               </ul>
           </nav>
     </div>
</c:if>