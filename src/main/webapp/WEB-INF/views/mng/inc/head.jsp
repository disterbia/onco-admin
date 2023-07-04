<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta name="Generator" content="${APP_TITLE}">
    <meta name="Author" content="${APP_TITLE}">
    <meta name="Keywords" content="${APP_TITLE}">
    <meta name="Description" content="${APP_TITLE}">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-title" content="${APP_TITLE}">
    <meta content="telephone=no" name="format-detection">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta property="og:title" content="${APP_TITLE}">
    <meta property="og:description" content="${APP_TITLE}">
    <meta property="og:image" content="${CDN_HTTP}/images/apple-touch-icon.png?v=${v_txt}">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <link rel="apple-touch-icon" sizes="180x180" href="${CDN_HTTP}/images/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${CDN_HTTP}/images/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${CDN_HTTP}/images/favicon-16x16.png">
    <link rel="icon" type="image/png" href="${CDN_HTTP}/images/android-chrome-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="${CDN_HTTP}/images/android-chrome-512x512.png" sizes="512x512">
    <link rel="manifest" href="${CDN_HTTP}/images/site.webmanifest">
    <link rel="mask-icon" href="${CDN_HTTP}/images/safari-pinned-tab.svg" color="#2475d0">
 	
    <title>${APP_TITLE} 관리자</title>
    
	<!--  CSRF -->
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
 	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
 	<meta id="_csrf_parameter" name="_csrf_parameter" content="${_csrf.parameterName}"/>
    
	<!-- Jquery -->
    <script src="${CDN_HTTP}/js/jquery-3.6.0.min.js"></script>
    <link href="${CDN_HTTP}/jquery-ui-1.13.2/jquery-ui.css" rel="stylesheet">
    <script src="${CDN_HTTP}/jquery-ui-1.13.2/external/jquery/jquery.js"></script>
    <script src="${CDN_HTTP}/jquery-ui-1.13.2/jquery-ui.js"></script>

    <!-- lottie -->
    <script src="${CDN_HTTP}/js/lottie-player.js"></script>    

    <!-- Chart -->
    <script src="${CDN_HTTP}/js/chart.js"></script>    

    <!-- Bootstrap -->
    <script src="${CDN_HTTP}/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="${CDN_HTTP}/css/bootstrap.css" />

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="${CDN_HTTP}/css/bootstrap-icons.css" />

    <!-- Design -->
    <link rel="stylesheet" href="${CDN_HTTP}/css/custom.css?ver=${VERSION}">
    <link rel="stylesheet" href="${CDN_HTTP}/css/common.css">
    <link rel="stylesheet" href="${CDN_HTTP}/css/design.css?ver=${VERSION}">
    <script src="${CDN_HTTP}/js/common.js"></script>
	
	<!-- Custom js -->
	<script type="text/javascript" src="${CDN_HTTP}/js/logic.js"></script>
	<!-- Loading -->
	<link rel="stylesheet" href="${CDN_HTTP}/css/loading.css"> 
	<!-- Logic -->
    <script src="${CDN_HTTP}/js/logic.js"></script>
	<!-- Modal -->
	<script src="${CDN_HTTP}/js/modal.js"></script>
	
	<script>
	var CDN_HTTP = '<c:out value="${CDN_HTTP}"/>';
	</script>
  </head>
  <body>
  
  <div class="position-fixed d-none w-100 page_indicator">
  <div class="spinner-border text-primary" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<div class="modal fade" id="modal_alert" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_alert_body">
            <p></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_alert_btn">확인</button>
        </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_reload" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_reload_body">
            <p></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_reload_btn">확인</button>
        </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_go" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_go_body">
            <p></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_go_btn">확인</button>
        </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal_replace" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_replace_body">
            <p></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_replace_btn">확인</button>
        </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modal_confirm" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_confirm_body">
            <p></p>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-light mr-3" data-dismiss="modal" id="modal_confirm_cancel_btn">취소</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_confirm_btn">확인</button>
        </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_confirm2" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_confirm_body2">
            <p></p>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-light mr-3" data-dismiss="modal" id="modal_confirm_cancel_btn2">취소</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_confirm_btn2">확인</button>
        </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_confirm3" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body" id="modal_confirm_body3">
            <p></p>
        </div>
        <div class="modal-footer">
        	<button type="button" class="btn btn-light mr-3" data-dismiss="modal" id="modal_confirm_cancel_btn3">취소</button>
            <button type="button" class="btn btn-primary" data-dismiss="modal" id="modal_confirm_btn3">확인</button>
        </div>
        </div>
    </div>
</div>
  