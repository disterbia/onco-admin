<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="chk_menu" value="2"/>
<c:set var="chk_sub_menu" value="0"/>

<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>

<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("탈퇴 사용자 상세");
</script>
 
<div class="wrap">
    <div class="container px-0">
        <div class="row no-gutters">
            <div class="col-xl-7 col-12">
                <div class="container content_wrap">
                    <div class="row">
                        <div class="col-12 d-flex justify-content-between">
                            <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>탈퇴 사용자 상세</h3>
                            <span class="text-danger fs_15 fs_500"></span>
                        </div>
                        <div class="col-12">
                            <ul class="list_style_1">
                                <li>
                                    <span>성명</span>
                                    <p>${member.mtName }</p>
                                </li>
                                <li>
                                    <span>성별</span>
                                    <p>${mtGenderArr[member.mtGender] }</p>
                                </li>
                                <li>
                                    <span>휴대폰 번호</span>
                                    <p>${member.mtHp }</p>
                                </li>
                                <li>
                                    <span>이메일</span>
                                    <p>${member.mtEmail }</p>
                                </li>
                                <li>
                                    <span>생년월일</span>
                                    <c:choose>
                                    	<c:when test="${empty member.mtBirth }">
                                    		****.**.**
                                    	</c:when>
                                    	<c:otherwise>
                                    		<fmt:formatDate value="${member.mtBirth}" pattern="yyyy.MM.dd" var="mtBirth" />
                                    		<p>${mtBirth }</p>
                                    	</c:otherwise>
                                    </c:choose>
                                </li>
                                <li>
                                    <span>아이디</span>
                                    <p>${member.mtId }</p>
                                </li>
                                <li>
                                    <span>주소</span>
                                    <p>${member.mtAddr }</p>
                                </li>
                                <hr class="hr">
                                <li>
                                    <span>진단여부</span>
                                    <c:choose>
                                    	<c:when test="${member.mtDiagnosis eq 1}">
                                    		<p>확진판정</p>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<p>미확진</p>
                                    	</c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="mtDiagnosisClass">
                                	<span>병원명</span>
									<p>${member.mtHospital }</p>
                                </li>
                                <li class="mtDiagnosisClass">
                                	<span>진단일</span>
                                	<fmt:formatDate value="${member.mtDiagnosisDate}" pattern="yyyy.MM.dd" var="mtDiagnosisDate" />
									<p>${mtDiagnosisDate }</p>
                                </li>
                                <c:choose>
                                	<c:when test="${mtDiagnosisCode eq 0}">
	                                	<li class="mtDiagnosisClass">
		                                	<span>암종(직접입력)</span>
											<p>${member.mtDiagnosisName }</p>
		                                </li>
                                	</c:when>
                                	<c:otherwise>
	                                	<li class="mtDiagnosisClass">
		                                	<span>암종</span>
		                                	<c:forEach var="diagnosis" items="${diagnoisList}">
		                                		<c:if test="${member.mtDiagnosisCode eq diagnosis.idx }"><p>${diagnosis.dtName}</p></c:if>
                                            </c:forEach>
		                                </li>
                                	</c:otherwise>
                                </c:choose>
                                <hr class="hr">
                                <li>
                                    <span>최초 등록일시</span>
                                    <fmt:formatDate value="${member.mtWdate}" pattern="yyyy.MM.dd HH:mm" var="mtWdate" />
                                    <p id="bt_consumer">${mtWdate}</p>
                                </li>
                                <li>
                                    <span>마지막 수정일시</span>
                                    <fmt:formatDate value="${member.mtEdate}" pattern="yyyy.MM.dd HH:mm" var="mtEdate" />
                                    <p id="bt_consumer">${mtEdate}</p>
                                </li>
                                <li>
                                    <span>최근 로그인일시</span>
                                    <fmt:formatDate value="${member.mtLdate}" pattern="yyyy.MM.dd HH:mm" var="mtLdate" />
                                    <p id="bt_consumer">${mtLdate}</p>
                                </li>
                                <li>
                                    <span>탈퇴일시</span>
                                    <fmt:formatDate value="${member.mtRdate}" pattern="yyyy.MM.dd HH:mm" var="mtRdate" />
                                    <p id="bt_consumer">${mtRdate}</p>
                                </li>
                            </ul>
                        </div>
                        <div class="col-12">
                            <hr class="hr">
                            <div class="btn_wrap">
                                <div class="btn_wrap">
                                    <button class="btn btn-light mr-3" onclick="location.href='./memberList'">돌아가기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${member.mtDiagnosis eq 2}">
<script>
$(document).ready(function() {
	$(".mtDiagnosisClass").hide();
});
</script>
</c:if>
<%@ include file="./inc/tail.jsp"%>
