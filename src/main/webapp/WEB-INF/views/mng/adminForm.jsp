<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="1"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("관리자 등록");
</script>
<style>
/* 생년월일용 */
.ui-datepicker select.ui-datepicker-year{
	width: 50%;
}

.ui-datepicker-title{
	display: flex;
	flex-direction: row-reverse;
	align-items: center;
  	justify-content: center;
}
</style>
<script>
//생년월일용
$(document).ready(function() {
	$("#datepicker").datepicker("option", 
		{
			minDate: new Date(1900,0,1),
		    maxDate: new Date(),
		    yearRange: "-150:+0",
		}
	);
});
</script>
 
<div class="wrap">
    <div class="container px-0">
        <div class="row no-gutters">
            <div class="col-xl-7 col-12">
                <div class="container content_wrap">
                    <div class="row">
                        <div class="col-12 d-flex justify-content-between">
                            <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>관리자 등록</h3>
                            <span class="text-danger fs_15 fs_500">필수 *</span>
                        </div>
                        <div class="col-12">
                            <ul class="list_style_1">
                                
                                <li>
                                    <span>성명<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="이름 입력" id="mtName">
                                        <small class="form-text text-danger d-none invalid_message" id="mtNameError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">성명을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>휴대폰 번호<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="휴대폰 번호 입력" id="mtHp" maxlength="13">
                                        <small class="form-text text-danger d-none invalid_message" id="mtHpError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">휴대폰번호를 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>이메일</span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="이메일 입력" id="mtEmail" maxlength="100">
                                        <small class="form-text text-danger d-none invalid_message" id="mtEmailError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이메일을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>생년월일<span class="text-danger">*</span></span>
                                    <div class="form-group calendar">
                                        <input type="text" class="form-control" id="datepicker" placeholder="yyyy.mm.dd" id="mtBirth" id="datepicker" autocomplete='off'>
                                        <i class="ic_calendar"><img src="${CDN_HTTP }/images/ic_calendar.png" alt="캘린더"></i>
                                        <small class="form-text text-danger d-none invalid_message" id="mtBirthError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">날짜를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>아이디<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="아이디 입력" id="mtId" autocomplete="new-password">
                                        <small class="form-text text-danger d-none invalid_message" id="mtIdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">아이디를 정확히 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>비밀번호<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="비밀번호 입력" id="mtPwd" autocomplete="new-password">
                                        <small class="form-text text-danger d-none invalid_message" id="mtPwdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png"></small>
                                    </div>
                                </li>
                                <li>
                                <span></span>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="비밀번호 다시입력" id="mtPwd2" autocomplete="new-password">
                                        <small class="form-text text-danger d-none invalid_message" id="mtPwd2Error"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png"></small>
                                    </div>
                                </li>
                                <li>
                                    <span>소속<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="소속 입력" id="mtGroup">
                                        <small class="form-text text-danger d-none invalid_message" id="mtGroupError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">소속을 정확히 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>관리자 권한<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtGrant">
                                        	<option value="0" selected disabled>권한선택</option>
                                        	<option value="1">전체관리</option>
											<option value="2">연구회원관리</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtGrantError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">관리자 권한을 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>관리자 상태<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtLevel">
                                        	<option value="1" selected>활동</option>
											<option value="2">정지</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtLevelError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">회원상태를 선택해주세요.</small>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col-12">
                            <hr class="hr">
                            <div class="btn_wrap">
                                <div class="btn_wrap">
                                    <button class="btn btn-light mr-3" onclick="location.href='./adminList'">취소</button>
                                    <button class="btn btn-primary" onclick="open_modal_confirm('해당 신규 회원을 등록할까요?')">등록</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

$('#modal_confirm_btn').click(function (){
	insert_member();
});


async function insert_member(){
	
	try{

		let mtName = $("#mtName").val();
		let mtHp = $("#mtHp").val();
		let mtEmail= $("#mtEmail").val();
		let mtBirth= $('#datepicker').val();
		let mtBirthSelected = $('#datepicker').datepicker( "getDate" );
		let mtId= $("#mtId").val();
		let mtPwd= $("#mtPwd").val();
		let mtPwd2= $("#mtPwd2").val();
		let mtLevel = $("#mtLevel").val();
		let mtGroup = $("#mtGroup").val();
		let mtGrant = $("#mtGrant").val();
		let error_count = 0;
		
		//성명 확인
		if(!validation_text(mtName)){
			$("#mtNameError").removeClass('d-none');
			$("#mtNameError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"회원명을 입력해주세요");
			error_count++
		}else{
			$("#mtNameError").addClass('d-none');
		}
		
		//전화번호 입력확인
		if(!validation_text(mtHp) || mtHp.length != 13){
			$("#mtHpError").removeClass('d-none');
			$("#mtHpError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"회원 휴대폰 번호 12자리 모두 입력해주세요.");
			error_count++
		}else{
			let isValidHp = await validation_hp(mtHp);
			//전화번호 중복확인
			if(!isValidHp){
				$("#mtHpError").removeClass('d-none');
				$("#mtHpError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"이미 사용중인 휴대폰번호 입니다.");
				error_count++
			}else{
				$("#mtHpError").addClass('d-none');
			}
		}
		
		//이메일 입력확인
		if(!validation_text(mtEmail)){
// 			$("#mtEmailError").removeClass('d-none');
// 			$("#mtEmailError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"회원 이메일을 입력해주세요.");
// 			error_count++
		}else{
// 			let isValidEmail = await validation_email(mtEmail);
// 			//이메일 중복확인
// 			if(!isValidEmail){
// 				$("#mtEmailError").removeClass('d-none');
// 				$("#mtEmailError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"이미 사용중인 이메일입니다.");
// 				error_count++
// 			}else{
// 				$("#mtEmailError").addClass('d-none');
// 			}
		}
		
		//생년월일 입력확인
		if(mtBirth != null && mtBirthSelected != null){
			$("#mtBirthError").addClass('d-none');
		}else{
			$("#mtBirthError").removeClass('d-none');
			error_count++
		}
		
		//아이디 입력확인
		if(!validation_text(mtId)){
			$("#mtIdError").removeClass('d-none');
			$("#mtIdError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"회원 아이디를 입력해주세요.");
			error_count++
		}else{
			let isValidId = await validation_id(mtId);
			//아이디 중복확인
			if(!isValidId){
				$("#mtIdError").removeClass('d-none');
				$("#mtIdError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"이미 사용중인 아이디입니다.");
				error_count++
			}else{
				$("#mtIdError").addClass('d-none');
			}
		}
		
		//비밀번호
		if(valid_password(mtPwd) !== "") {
			$("#mtPwdError").removeClass('d-none');
			$("#mtPwdError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+valid_password(mtPwd));
			error_count++
		}else{
			$("#mtPwdError").addClass('d-none');
		}

		//비밀번호 다시확인
		if(check_two_password(mtPwd, mtPwd2) !== "") {
			$("#mtPwd2Error").removeClass('d-none');
			$('#mtPwd2Error').html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+check_two_password(mtPwd, mtPwd2));
			error_count++
		}else{
			$("#mtPwd2Error").addClass('d-none');
		}
		
		//소속그룹 확인
		if(!validation_text(mtGroup)){
			$("#mtGroupError").removeClass('d-none');
			error_count++
		}else{
			$("#mtGroupError").addClass('d-none');
		}
		
		//권한 확인
		if(mtGrant != '1' && mtGrant != '2'){
			$("#mtGrantError").removeClass('d-none');
			error_count++
		}else{
			$("#mtGrantError").addClass('d-none');
		}
		
		if(error_count > 0){
			return;
		}

		
		let res = await awaitPost("/mng/adminUpdate.do", 
				{
				action:'insert_admin',
				mtName: mtName,
				mtHp: mtHp,
				mtEmail: mtEmail,
				mtBirth: mtBirth,
				mtId: mtId, 
				mtPwd: mtPwd,
				mtLevel: mtLevel,
				mtGroup: mtGroup,
				mtGrant: mtGrant
				});
		console.log(res);
		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./adminDetail?idx=\${res.idx}`, "신규 회원이 등록되었습니다.");
		}else{
			if(res.error_code){
				console.log(res.error_code, res.error_detail);
				open_modal_alert(res.error_code, res.error_detail);
			}else{
				open_modal_alert();
			}
		}
	
	}catch(e){
		console.log(e);
		open_modal_alert();
	}
	
}

//아이디 중복확인
async function validation_id(mtId){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_id',
			mtId: mtId
			}, true);
		
			if(res.result == 'success'){
				return true;
			}else{
				return false;
			}
	}catch(e){
		console.log(e);
		return false;
	}
}

//전화번호 중복확인
async function validation_hp(mtHp){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_hp',
			mtHp: mtHp
			}, true);
		
			if(res.result == 'success'){
				return true;
			}else{
				return false;
			}
	}catch(e){
		console.log(e);
		return false;
	}
}

//이메일 중복확인
async function validation_email(mtEmail){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_email',
			mtEmail: mtEmail
			}, true);
		
			if(res.result == 'success'){
				return true;
			}else{
				return false;
			}
	}catch(e){
		console.log(e);
		return false;
	}
}

$(document).on('keyup', '#mtHp', function(e) {
	   $(this).val( validation_hypen(validation_number($(this).val())) );
	});
$(document).on('blur', '#mtHp', function(e) {
		$(this).val( validation_hypen(validation_number($(this).val())) );
	});
</script>

<%@ include file="./inc/tail.jsp"%>
