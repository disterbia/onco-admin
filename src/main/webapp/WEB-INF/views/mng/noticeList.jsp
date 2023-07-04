<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="4"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("공지 관리");
</script>
 
<div class="wrap">
    <div class="container content_wrap">
        <form  action="" method="" onSubmit="return false">
            <div class="row">
                <div class="col-12">
                    <h3 class="h3">공지 목록</h3>
	                <button type="button" class="btn btn-light btn-sm position-absolute" onclick="location.href='./noticeForm'">+ 공지 등록</button>  
                </div>                
                <div class="col-12 col-xl-6 search_group">
                    <div class="form-group">
                        <label>검색어 입력</label>
                        <select class="form-control" id="search_filter" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter}">selected</c:if>>통합검색</option>
                            <option value="ntTitle" <c:if test="${param.search_filter eq 'ntTitle'}">selected</c:if>>제목</option>
                            <option value="ntContent" <c:if test="${param.search_filter eq 'ntContent'}">selected</c:if>>내용</option>
                        </select>
                    </div>
                    <div class="form-group form_search_left">            
                        <input type="text" class="form-control" placeholder="검색어 입력" value="${param.search_value}" id="search_value" onKeyPress="if( event.keyCode==13 ){notice_search();}">
                        <img class="ic_search" src="${CDN_HTTP}/images/ic_search.png" alt="검색">                        
                    </div>
                </div>    
                <div class="col-12 col-xl-6">
                    <div class="btn_wrap">
                        <button type="button" class="btn btn-primary" onclick="notice_search();">검색</button>
                        <button type="button" class="btn btn-link" onclick="location.href='${path}'"><img src="${CDN_HTTP}/images/ic_ini.png" alt="초기화">초기화</button>
                    </div>
                </div>
            </div>        
        </form>
    </div>
	<div class="container content_wrap">
		<div class="row">
			<div class="col-12 table-responsive">
				<h3 class="h3">목록</h3>
				<table class="table table-hover">
					<thead>
						<tr> 
							<th>번호</th>
							<th>제목</th>
							<th>등록일</th>
							<th>수정일</th>
							<th>조회수</th>
							<th>상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty notices }">
								<tr>
									<th colspan="7">----------내역이 없습니다----------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="counts" value="${page['counts']}"></c:set>
								<c:forEach items="${notices}" var="notice">
									<tr onclick="location.href='./noticeDetail?idx=${notice.idx}';">
										<td>${counts}</td>
										<td>${notice.ntTitle }</td>
										<fmt:formatDate value="${notice.ntWdate}" pattern="yyyy.MM.dd HH:mm" var="ntWdate" />
										<td>${ntWdate }</td>
										<fmt:formatDate value="${notice.ntEdate}" pattern="yyyy.MM.dd HH:mm" var="ntEdate" />
										<td>${ntEdate }</td>
										<td>${notice.ntView }</td>
										<td>
											<c:choose>
												<c:when test="${notice.ntLevel eq 1}">노출</c:when>
												<c:otherwise>숨김</c:otherwise>
											</c:choose>
										</td>
										<td><button class="btn btn-sm btn-outline-light" onclick="event.cancelBubble = true; location.href='./noticeEdit?idx=${notice.idx}';">관리</button></td>
									</tr>
								<c:set var="counts" value="${counts - 1}"/>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>   
			</div>
		﻿<%@ include file="./inc/paging.jsp" %>
		</div>
	</div>
</div>

<script>
	//해당 페이지 검색옵션
	haveSearchValue = true,  haveSearchFilter = true;
	haveDatePicker2 = false, haveDatePicker = false, haveSearchType = false;
	
	function notice_search(){
		console.log(make_search_path(`${path}`));
		location.href = make_search_path(`${path}`);
	}
</script>


<%@ include file="./inc/tail.jsp"%>
