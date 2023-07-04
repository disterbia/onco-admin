<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<footer class="footer">
	<div class="d-lfex">
	    <button class="btn btn-link" type="button" data-target="#modal_term" data-toggle="modal">개인정보처리방침</button>
	    <button class="btn btn-link" type="button" data-target="#modal_term2" data-toggle="modal">이용약관</button>
    </div>
    <p>COPYRIGHT(C)2022 DMONSTER ALL RIGHTS RESERVED </p>
</footer>

<!-- Modal -->
<div class="modal fade" id="modal_term">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal_term_title">개인정보처리방침
                <p class="fs_14 fw_400 text-darkgray mt-1"></p>
                </h5>                
                <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                    <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
                </button>
            </div>
            <div class="modal-body" id="modal_term_body">
            </div>
            <div class="modal-footer d-block">
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal_term2">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal_term_title2">이용약관
                <p class="fs_14 fw_400 text-darkgray mt-1"></p>
                </h5>                
                <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                    <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
                </button>
            </div>
            <div class="modal-body" id="modal_term_body2">
            </div>
            <div class="modal-footer d-block">
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

</body>

</html>