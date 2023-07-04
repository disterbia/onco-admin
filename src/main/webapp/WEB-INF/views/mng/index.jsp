<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="0"/>
<c:set var="chk_sub_menu" value="0"/>

<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>


<script>
    $(".main_m_header").addClass("on");
</script>

<div class="wrap" style="padding-top: 0;">

    <div class="container px-0 pc_only">
        <div class="row no-gutters">
        </div>
    </div>
    
	<!-- 모바일 -->
    <div class="container m_only" style="padding-top: 50px;">
        <div class="row">
        	
            <div class="col-12 main_profile_wrap">
                <div class="greeting_wrap">
                    <p class="greeting_text">
                        <small>반갑습니다!</small><br>
                        관리자님
                    </p>
                    <figure class="square profile bank_profile">
                        <img src="${CDN_HTTP}/images/profile_oncomasters.png" alt="로고">
                    </figure>
                </div>
            </div>
        </div>
    </div>
	<!-- END 모바일 -->
	
</div>

<%@ include file="./inc/tail.jsp"%>