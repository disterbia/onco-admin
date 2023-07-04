<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="3"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("컨텐츠 관리");
</script>
 
<div class="wrap">
    <div class="container content_wrap">
        <form  action="" method="" onSubmit="return false">
            <div class="row">
                <div class="col-12">
                    <h3 class="h3">컨텐츠 관리</h3>
	                <button type="button" class="btn btn-light btn-sm position-absolute" onclick="location.href='./contentForm'">+ 컨텐츠 등록</button>  
                </div>   
                <div class="col-12 col-xl-6 d-flex">
                    <div class="form-group w-50">
                        <label>암 유형</label>
                        <select class="form-control" id="search_filter2" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter2 or param.search_filter2 eq 'all'}">selected</c:if>>전체</option>
                            <c:forEach var="diagnosis" items="${diagnoisList}">
                                <option value="${diagnosis.idx}" <c:if test="${param.search_filter2 eq diagnosis.idx}">selected</c:if>>${diagnosis.dtName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group w-50 ml-2">
                        <label>변이 유형</label>
                        <select class="form-control" id="search_filter3" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter3 or param.search_filter3 eq 'all'}">selected</c:if>>전체</option>
                            <c:forEach var="gene" items="${geneList}">
                                <option value="${gene.idx}" <c:if test="${param.search_filter3 eq gene.idx}">selected</c:if>>${gene.gtName}</option>
                            </c:forEach>
                        </select>                  
                    </div>                                  
                </div>            
                <div class="col-12 col-xl-6">
                    <div class="form-group">
                        <label>정보 유형</label>
                        <div class="btn_select" id="search_type2">
                            <button type="button" class="btn btn-sm <c:if test="${empty param.search_type2 or param.search_type2 eq 'all'}">on</c:if>" value="all">전체</button>
                            <button type="button" class="btn btn-sm <c:if test="${param.search_type2 eq '1'}">on</c:if>" value="1">약제정보</button>
                            <button type="button" class="btn btn-sm <c:if test="${param.search_type2 eq '2'}">on</c:if>" value="2">유전자정보</button>
                        </div>                        
                    </div>                    
                </div>  
                <div class="col-12 col-xl-6 search_group">
                    <div class="form-group">
                        <label>검색어 입력</label>
                        <select class="form-control" id="search_filter" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter}">selected</c:if>>통합검색</option>
                            <option value="qtTitle" <c:if test="${param.search_filter eq 'qtTitle'}">selected</c:if>>제목</option>
                            <option value="qtContent" <c:if test="${param.search_filter eq 'qtContent'}">selected</c:if>>내용</option>
                            <option value="mtName" <c:if test="${param.search_filter eq 'mtName'}">selected</c:if>>키워드</option>
                        </select>
                    </div>
                    <div class="form-group form_search_left">            
                        <input type="text" class="form-control" placeholder="검색어 입력" value="${param.search_value}" id="search_value" onKeyPress="if( event.keyCode==13 ){content_search();}">
                        <img class="ic_search" src="${CDN_HTTP}/images/ic_search.png" alt="검색">                        
                    </div>
                </div>    
                <div class="col-12 col-xl-6">
                    <div class="btn_wrap">
                        <button type="button" class="btn btn-primary" onclick="content_search();">검색</button>
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
							<th>카테고리</th>
							<th>암유형</th>
							<th>변이유형</th>
							<th>제목</th>
							<th>등록일</th>
							<th>조회수</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty contents }">
								<tr>
									<th colspan="8">----------내역이 없습니다----------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="counts" value="${page['counts']}"></c:set>
								<c:forEach items="${contents}" var="content">
									<tr onclick="location.href='./contentEdit?idx=${content.idx}';">
										<td>${counts}</td>
										<td>${ctCategoryArr[content.ctCategory] }</td>
										<td>${content.dtName }</td>
										<td>${content.gtName }</td>
										<td>${content.ctTitle }</td>
										<fmt:formatDate value="${content.ctWdate}" pattern="yyyy.MM.dd HH:mm" var="ctWdate" />
										<td>${ctWdate }</td>
										<td>${content.ctView }</td>
										<td><button class="btn btn-sm btn-outline-light" onclick="event.cancelBubble = true; location.href='./contentEdit?idx=${content.idx}';">관리</button></td>
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
	haveSearchValue = true,  haveSearchFilter = true, haveSearchFilter2 = true, haveSearchFilter3 = true, haveSearchType = true, haveSearchType2 = true;
	haveDatePicker2 = false, haveDatePicker = false;
	
	function content_search(){
		console.log(make_search_path(`${path}`));
		location.href = make_search_path(`${path}`);
	}
</script>


<%@ include file="./inc/tail.jsp"%>
