<%@page import="net.huray.onco.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
Member user = (Member)session.getAttribute("session_member");
if(user == null){
	%><script>location.replace('/mng/logout')</script><%
}else{
	pageContext.setAttribute("user", user) ;
}
%>
<style type="text/css">
    .side_menu{
        overflow: scroll;
        -ms-overflow-style: none;
    }
    .side_menu::-webkit-scrollbar{
        display:none;
    }
</style>
<aside class="side_menu">
    <header class="side_header">
        <a href="/mng/" class="logo">
            <img src="${CDN_HTTP}/images/logo.png" alt="로고">
        </a>
    </header>
    <div class="side_subheader">
        <h3 class="h3">
            <small>반갑습니다!</small><br>
            <strong>${user.mtName }님</strong>
        </h3>
    </div>
    <button class="mobile_side_close btn btn-link m_only">
        <i class="bi bi-x"></i>
    </button>
    <div class="side_body">        
        <ul class="main_lnb">
        	<c:choose>
        		<c:when test="${user.mtGrant eq 0 }">
        			<c:redirect url="/main"/>
        		</c:when>
        		<c:when test="${user.mtGrant eq 1 }">
        			<li class="main_lnb_item <c:if test="${chk_menu eq '1'}">on</c:if>">
		                <a href="adminList">
		                    <div class="main_lnb_title">
		                    	<img src="${CDN_HTTP}/images/ic_admin.png" alt="ic">
		                        관리자 관리
		                    </div>                    
		                    <i class="bi bi-chevron-right"></i>
		                </a>                
		            </li>
		            <li class="main_lnb_item <c:if test="${chk_menu eq '2'}">on</c:if>">
		                <a class="main_lnb_title">
		                    <div>
		                    	<img src="${CDN_HTTP}/images/ic_member.png" alt="ic">
		                        회원 관리
		                    </div>                    
		                    <i class="bi bi-chevron-down"></i>
		                </a>
		                <ul class="sub_lnb">
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '2' and chk_sub_menu eq '0'}">on</c:if>">
		                        <a href="memberList">
		                            일반회원
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '2' and chk_sub_menu eq '2'}">on</c:if>">
		                        <a href="memberList2">
		                            연구회원
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                </ul>
		            </li>
		            <li class="main_lnb_item <c:if test="${chk_menu eq '3'}">on</c:if>">
		                <a class="main_lnb_title">
		                    <div>
		                    	<img src="${CDN_HTTP}/images/ic_content.png" alt="ic">
		                        콘텐츠 관리
		                    </div>                    
		                    <i class="bi bi-chevron-down"></i>
		                </a>
		                <ul class="sub_lnb">
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '3' and chk_sub_menu eq '0'}">on</c:if>">
		                        <a href="contentList">
		                            글 관리
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '3' and chk_sub_menu eq '1'}">on</c:if>">
		                        <a href="geneList">
		                            변이정보 관리
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '3' and chk_sub_menu eq '2'}">on</c:if>">
		                        <a href="diagnosisList">
		                            암종정보 관리
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                </ul>
		            </li>
		            <li class="main_lnb_item <c:if test="${chk_menu eq '4'}">on</c:if>">
		                <a class="main_lnb_title">
		                    <div>
		                    	<img src="${CDN_HTTP}/images/ic_qna.png" alt="ic">
		                        문의 관리
		                    </div>                    
		                    <i class="bi bi-chevron-down"></i>
		                </a>
		                <ul class="sub_lnb">
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '4' and chk_sub_menu eq '0'}">on</c:if>">
		                        <a href="noticeList">
		                            공지사항
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '4' and chk_sub_menu eq '1'}">on</c:if>">
		                        <a href="faqList">
		                            자주묻는 질문(FAQ)
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '4' and chk_sub_menu eq '2'}">on</c:if>">
		                        <a href="qnaList">
		                            1:1 문의
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                </ul>
		            </li>
		            <li class="main_lnb_item <c:if test="${chk_menu eq '5'}">on</c:if>">
		                <a class="main_lnb_title">
		                    <div>
		                        <img src="${CDN_HTTP}/images/ic_term.png" alt="ic">
		                        약관 관리
		                    </div>                    
		                    <i class="bi bi-chevron-down"></i>
		                </a>
		                <ul class="sub_lnb">
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '5' and chk_sub_menu eq '0'}">on</c:if>">
		                        <a href="termsList">
		                            회원약관
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item <c:if test="${chk_menu eq '5' and chk_sub_menu eq '1'}">on</c:if>">
		                        <a href="termsList2">
		                            개인정보처리방침
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                </ul>
		            </li>
		            <li class="main_lnb_item">
		                <a class="main_lnb_title" href="index">
		                    <div class="main_lnb_title">
		                    	<img src="${CDN_HTTP}/images/ic_service.png" alt="ic">
		                        서비스 신청 관리
		                    </div>                    
		                    <i class="bi bi-chevron-right"></i>
		                </a>                
		            </li>
		            <li class="main_lnb_item">
		                <a class="main_lnb_title">
		                    <div>
		                    	<img src="${CDN_HTTP}/images/ic_msg.png" alt="ic">
		                        메세지 관리
		                    </div>                    
		                    <i class="bi bi-chevron-down"></i>
		                </a>
		                <ul class="sub_lnb">
		                    <li class="sub_lnb_item">
		                        <a href="index">
		                            메세지 발송
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item">
		                        <a href="index">
		                            발송 내역
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
		                    <li class="sub_lnb_item">
		                        <a href="index">
		                            메세지 설정
		                            <i class="arrow_sub_lnb">
		                                <img src="${CDN_HTTP}/images/arrow_lnb_right.png">
		                            </i>                            
		                        </a>
		                    </li>
	                    </ul>
            		</li>
        		</c:when>
        		<c:when test="${user.mtGrant eq 2 }">
        			<li class="main_lnb_item <c:if test="${chk_menu eq '2'}">on</c:if>">
		                <a href="memberList2">
		                    <div class="main_lnb_title">
		                    	<img src="${CDN_HTTP}/images/ic_member.png" alt="ic">
		                        연구회원 관리
		                    </div>                    
		                    <i class="bi bi-chevron-right"></i>
		                </a>                
		            </li>
        		</c:when>
        	</c:choose>
        </ul>
    </div>
    <footer class="side_footer">
        <button class="btn btn-link btn_logout" onclick="location.href='/mng/logout'">로그아웃</button>
    </footer>
</aside>

<div class="m_header_wrap m_only">
    <div class="m_header main_m_header">
        <nav class="m_header_left">
            <a href="#" class="m_logo"><img src="${CDN_HTTP}/images/logo.png" alt="로고"></a>
        </nav>
        <p class="m_header_center">
            
        </p>
        <nav class="m_header_right">
            <div class="nav_ic btn_hamburger">
                <img src="${CDN_HTTP}/images/nav_hamburger.png" alt="메뉴 열기">
            </div>
        </nav>
    </div>
    <div class="m_header default_m_header">
        <nav class="m_header_left">            
            <a href="javascript:history.back();" class="nav_ic btn_back p-0">
                <img src="${CDN_HTTP}/images/nav_back.png" alt="이전 페이지">
            </a>
        </nav>
        <p class="m_header_center">
            타이틀
        </p>
        <nav class="m_header_right">
<!--             <div class="nav_ic btn_bell"> -->
<%--                 <img src="${CDN_HTTP}/images/nav_bell.png" alt="알림"> --%>
<!--                 <span class="ic_new">0</span> -->
<!--             </div> -->
            <div class="nav_ic btn_hamburger">
                <img src="${CDN_HTTP}/images/nav_hamburger.png" alt="메뉴 열기">
            </div>
        </nav>
    </div>
    <div class="m_header supp_m_header">
        <nav class="m_header_left">            
            <a href="javascript:history.back();" class="nav_ic btn_back p-0">
                <img src="${CDN_HTTP}/images/nav_back.png" alt="이전 페이지">
            </a>
        </nav>
        <nav class="m_header_right">
            <div class="nav_ic btn_search">
                <img src="${CDN_HTTP}/images/nav_search.png" alt="검색">
            </div>
            <div class="nav_ic btn_more">
                <img src="${CDN_HTTP}/images/nav_more.png" alt="상세 정보">
            </div>
        </nav>
    </div>
    <div class="m_header modal_m_header">
        <nav class="m_header_left">            
            
        </nav>
        <p class="m_header_center">
            
        </p>
        <nav class="m_header_right">            
            <a href="javascript:history.back();" class="nav_ic">
                <img src="${CDN_HTTP}/images/nav_x.png" alt="닫기">
            </a>
        </nav>
    </div>
</div>
