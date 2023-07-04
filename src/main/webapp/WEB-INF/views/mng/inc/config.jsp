<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="baseURL" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
<c:set var="pg" value="${param.pg}" />
<c:if test="${empty pg}"><c:set var="pg" value="1"/></c:if>
<c:set var="row" value="${param.row}" />
<c:if test="${empty row}"><c:set var="row" value="10"/></c:if>
<c:set var="startIndex" value="1" />
<c:if test="${pg > 1}"><c:set var="startIndex" value="${(row * (pg - 1)) + 1}" /></c:if>

<c:set var="APP_AUTHOR" value="온코마스터"/>
<c:set var="APP_TITLE" value="온코마스터"/>
<c:set var="CDN_HTTP" value="/resources/mng"/>
<c:set var="KEYWORDS" value="온코마스터"/>
<c:set var="DESCRIPTION" value="온코마스터"/>
<c:set var="VERSION" value="1"/>


<%


HashMap<Integer, String> qtTypeArr = new HashMap<Integer, String>();
qtTypeArr.put(1, "서비스지 취소요청");
qtTypeArr.put(2, "서비스지 신청관련");
qtTypeArr.put(3, "서비스지 내용관련");
qtTypeArr.put(4, "회원가입 관련");
qtTypeArr.put(5, "기타");
request.setAttribute("qtTypeArr", qtTypeArr);

HashMap<Integer, String> ctCategoryArr = new HashMap<Integer, String>();
ctCategoryArr.put(0, "");
ctCategoryArr.put(1, "약제정보");
ctCategoryArr.put(2, "유전자정보");
ctCategoryArr.put(3, "약제/유전자 정보");
request.setAttribute("ctCategoryArr", ctCategoryArr);

HashMap<Integer, String> mtGenderArr = new HashMap<Integer, String>();
mtGenderArr.put(0, "");
mtGenderArr.put(1, "남성");
mtGenderArr.put(2, "여성");
request.setAttribute("mtGenderArr", mtGenderArr);



HashMap<Integer, String> mtLevelBadgeArr = new HashMap<Integer, String>();
mtLevelBadgeArr.put(1, "<span class=\"badge badge-secondary\">정상</span>");
mtLevelBadgeArr.put(2, "<span class=\"badge badge-warning\">정지</span>");
mtLevelBadgeArr.put(10, "<span class=\"badge badge-dark\">탈퇴</span>");
request.setAttribute("mtLevelBadgeArr", mtLevelBadgeArr);




%>
