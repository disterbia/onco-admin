<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ttTypeTxt" value="회원약관"/>
<c:set var="ttType" value="1"/>
<c:set var="ttMenu" value="0"/>
<c:set var="ttList" value="ttList"/>
<c:if test="${terms.ttType eq 2}">
	<c:set var="ttTypeTxt" value="개인정보처리방침"/>
	<c:set var="ttType" value="2"/>
	<c:set var="ttMenu" value="1"/>
	<c:set var="ttList" value="ttList2"/>
</c:if>

<c:set var="chk_menu" value="5"/>
<c:set var="chk_sub_menu" value="${ttMenu}"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>

<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("${ttTypeTxt} 상세");
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>${terms.ttTitle }</h3>                
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                    <div class="form-group">
                    	${terms.ttContent }
                    </div>
                    <div class="mt-5">
                    	<button class="btn btn-light mr-3" onclick="history.back();">돌아가기</button>
                        <button class="btn btn-primary" onclick="location.href='./termsEdit?idx=${terms.idx}'">관리</button>
                    </div>

                </div>  
            </div>
        </div>
    </div>
</div>
<%@ include file="./inc/tail.jsp"%>
