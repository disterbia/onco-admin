<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="4"/>
<c:set var="chk_sub_menu" value="2"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("1:1 문의 관리");
</script>
 
<div class="wrap">
    <div class="container content_wrap">
        <form  action="" method="" onSubmit="return false">
            <div class="row">
                <div class="col-12">
                    <h3 class="h3">1:1 문의</h3>
	                <button type="button" class="btn btn-light btn-sm position-absolute" onclick="location.href='./qnaForm'">+ 문의 등록</button>  
                </div>             
                <div class="col-12 col-xl-6">
                    <div class="form-group">
                        <label>문의유형</label>
                        <div class="btn_select" id="search_type">
                            <button type="button" class="btn btn-sm <c:if test="${empty param.search_type or param.search_type eq '0'}">on</c:if>" value="0">전체 ${qnasTotal}</button>
                            <button type="button" class="btn btn-sm <c:if test="${param.search_type eq '1'}">on</c:if>" value="1">서비스지 취소 요청 ${qnas1}</button>
                            <button type="button" class="btn btn-sm <c:if test="${param.search_type eq '2'}">on</c:if>" value="2">서비스지 신청 관련 ${qnas2}</button>
							<button type="button" class="btn btn-sm <c:if test="${param.search_type eq '3'}">on</c:if>" value="3">서비스지 내용 관련 ${qnas3}</button>
							<button type="button" class="btn btn-sm <c:if test="${param.search_type eq '4'}">on</c:if>" value="4">회원가입 관련 ${qnas4}</button>
							<button type="button" class="btn btn-sm <c:if test="${param.search_type eq '5'}">on</c:if>" value="5">기타 ${qnas5}</button>
                        </div>                        
                    </div>                    
                </div>  
                <div class="col-12 col-xl-6">
                    <div class="form-group">
                        <label>문의상태</label>
                        <div class="btn_select2" id="search_type2">
                            <button type="button" class="btn btn-sm btn-outline-dark rounded-pill mb-3 <c:if test="${empty param.search_type2 or param.search_type2 eq '0'}">on</c:if>" value="0">전체</button>
                            <button type="button" class="btn btn-sm btn-outline-dark rounded-pill mb-3 <c:if test="${param.search_type2 eq '1'}">on</c:if>" value="1">미답변 ${qnas6}</button>
                            <button type="button" class="btn btn-sm btn-outline-dark rounded-pill mb-3 <c:if test="${param.search_type2 eq '2'}">on</c:if>" value="2">답변완료 ${qnas7}</button>
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
                            <option value="mtName" <c:if test="${param.search_filter eq 'mtName'}">selected</c:if>>작성자명</option>
                            <option value="mtHp" <c:if test="${param.search_filter eq 'mtHp'}">selected</c:if>>작성자연락처</option>
                        </select>
                    </div>
                    <div class="form-group form_search_left">            
                        <input type="text" class="form-control" placeholder="검색어 입력" value="${param.search_value}" id="search_value" onKeyPress="if( event.keyCode==13 ){qna_search();}">
                        <img class="ic_search" src="${CDN_HTTP}/images/ic_search.png" alt="검색">                        
                    </div>
                </div>    
                <div class="col-12 col-xl-6">
                    <div class="btn_wrap">
                        <button type="button" class="btn btn-primary" onclick="qna_search();">검색</button>
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
							<th>문의유형</th>
							<th>작성자</th>
							<th>연락처</th>
							<th>제목</th>
							<th>등록일</th>
							<th>답변일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty qnas }">
								<tr>
									<th colspan="8">----------내역이 없습니다----------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="counts" value="${page['counts']}"></c:set>
								<c:forEach items="${qnas}" var="qna">
									<tr onclick="location.href='./qnaEdit?idx=${qna.idx}';">
										<td>${counts}</td>
										<td>${qtTypeArr[qna.qtType] }</td>
										<td>${qna.mtName }</td>
										<td>${qna.mtHp }</td>
										<td>${qna.qtTitle }</td>
										<fmt:formatDate value="${qna.qtWdate}" pattern="yyyy.MM.dd HH:mm" var="qtWdate" />
										<td>${qtWdate }</td>
										<fmt:formatDate value="${qna.qtAdate}" pattern="yyyy.MM.dd HH:mm" var="qtAdate" />
										<td>${qtAdate }</td>
										<td><button class="btn btn-sm btn-outline-light" onclick="event.cancelBubble = true; location.href='./qnaEdit?idx=${qna.idx}';">관리</button></td>
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
	haveSearchValue = true,  haveSearchFilter = true, haveSearchType = true, haveSearchType2 = true;
	haveDatePicker2 = false, haveDatePicker = false;
	
	function qna_search(){
		console.log(make_search_path(`${path}`));
		location.href = make_search_path(`${path}`);
	}
</script>


<%@ include file="./inc/tail.jsp"%>
