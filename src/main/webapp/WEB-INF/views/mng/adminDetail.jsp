<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="1"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("관리자 상세");
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
                            <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>관리자 상세</h3>
                            <span class="text-danger fs_15 fs_500">필수 *</span>
                        </div>
                        <div class="col-12">
                            <ul class="list_style_1">
                                
                                <li>
                                    <span>성명<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="이름 입력" id="mtName" value="${member.mtName }">
                                        <small class="form-text text-danger d-none invalid_message" id="mtNameError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">성명을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>휴대폰 번호<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="휴대폰 번호 입력" id="mtHp" maxlength="13" value="${member.mtHp }">
                                        <small class="form-text text-danger d-none invalid_message" id="mtHpError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">휴대폰번호를 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>이메일<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="이메일 입력" id="mtEmail" maxlength="100" value="${member.mtEmail }">
                                        <small class="form-text text-danger d-none invalid_message" id="mtEmailError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이메일을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>생년월일<span class="text-danger">*</span></span>
                                    <div class="form-group calendar">
                                    	<fmt:formatDate value="${member.mtBirth}" pattern="yyyy.MM.dd" var="mtBirth" />
                                        <input type="text" class="form-control" id="datepicker" placeholder="yyyy.mm.dd" id="mtBirth" id="datepicker" autocomplete='off' value="${mtBirth}">
                                        <i class="ic_calendar"><img src="${CDN_HTTP }/images/ic_calendar.png" alt="캘린더"></i>
                                        <small class="form-text text-danger d-none invalid_message" id="mtBirthError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">날짜를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>아이디<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="아이디 입력" id="mtId" autocomplete="new-password" value="${member.mtId}">
                                        <small class="form-text text-danger d-none invalid_message" id="mtIdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">아이디를 정확히 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>비밀번호<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="새 비밀번호 입력" id="mtPwd" autocomplete="new-password">
                                        <small class="form-text text-danger d-none invalid_message" id="mtPwdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png"></small>
                                    </div>
                                </li>
                                <li>
                                <span></span>
                                    <div class="form-group">
                                        <input type="password" class="form-control" placeholder="새 비밀번호 다시입력" id="mtPwd2" autocomplete="new-password">
                                        <small class="form-text text-danger d-none invalid_message" id="mtPwd2Error"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png"></small>
                                    </div>
                                </li>
                                <li>
                                    <span>소속<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="소속 입력" id="mtGroup" value="${member.mtGroup}">
                                        <small class="form-text text-danger d-none invalid_message" id="mtGroupError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">소속을 정확히 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>관리자 권한<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtGrant">
                                        	<option value="0" disabled>권한선택</option>
                                        	<option value="1" <c:if test="${member.mtGrant eq 1}">selected</c:if>>전체관리</option>
											<option value="2" <c:if test="${member.mtGrant eq 2}">selected</c:if>>연구회원관리</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtGrantError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">관리자 권한을 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>회원 상태<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtLevel">
                                        	<option value="1" <c:if test="${member.mtLevel eq 1}">selected</c:if>>활동</option>
											<option value="2" <c:if test="${member.mtLevel eq 2}">selected</c:if>>정지</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtLevelError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">봇계정 유무를 선택해주세요.</small>
                                    </div>
                                </li>
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
                            </ul>
                        </div>
                        <div class="col-12">
                            <hr class="hr">
                            <div class="btn_wrap">
                                <div class="btn_wrap">
                                    <button class="btn btn-light mr-3" onclick="location.href='./adminList'">돌아가기</button>
                                    <button class="btn btn-danger mr-3" onclick="open_modal_confirm2('해당 회원을 삭제할까요?')">삭제</button>
                                    <button class="btn btn-primary" onclick="open_modal_confirm('해당 회원 정보를 수정할까요?')">저장</button>
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
	update_member();
});

$('#modal_confirm_btn2').click(function (){
	delete_member();
});


async function update_member(){
	
	try{
		let idx = ${member.idx};
		let mtName = $("#mtName").val();
		let mtHp = $("#mtHp").val();
		let mtEmail= $("#mtEmail").val();
		let mtBirth= $('#datepicker').val();
		let mtBirthSelected = $('#datepicker').datepicker( "getDate" );
		let mtId= $("#mtId").val();
		let mtLevel = $("#mtLevel").val();
		let mtGroup = $("#mtGroup").val();
		let mtGrant = $("#mtGrant").val();
		let error_count = 0;
		
		let mtPwd= $("#mtPwd").val();
		let mtPwd2= $("#mtPwd2").val();
		let mtPwdChange = false;
		
		if(mtPwd != '' || mtPwd2 != ''){mtPwdChange = true;}
		
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
			let isValidHp = await validation_hp2(idx, mtHp);
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
			let isValidEmail = await validation_email2(idx, mtEmail);
			//이메일 중복확인
			if(!isValidEmail){
				$("#mtEmailError").removeClass('d-none');
				$("#mtEmailError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"이미 사용중인 이메일입니다.");
				error_count++
			}else{
				$("#mtEmailError").addClass('d-none');
			}
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
			let isValidId = await validation_id2(idx, mtId);
			//아이디 중복확인
			if(!isValidId){
				$("#mtIdError").removeClass('d-none');
				$("#mtIdError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"이미 사용중인 아이디입니다.");
				error_count++
			}else{
				$("#mtIdError").addClass('d-none');
			}
		}
		
		if(mtPwdChange){
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

		let params = {
			action:'update_admin',
			idx: idx,
			mtName: mtName,
			mtHp: mtHp,
			mtEmail: mtEmail,
			mtBirth: mtBirth,
			mtId: mtId, 
			mtLevel: mtLevel,
			mtGroup: mtGroup,
			mtGrant: mtGrant
			}
		
		if(mtPwdChange){
			params['mtPwd'] = mtPwd;
		}
		
		let res = await awaitPost("/mng/adminUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./adminList`, "회원 정보가 변경되었습니다.");
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

async function delete_member(){
	
	try{
		let idx = ${member.idx};

		let params = {
			action:'delete_admin',
			idx: idx,
			}
		
		let res = await awaitPost("/mng/adminUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./adminList`, "회원이 삭제되었습니다.");
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
async function validation_id2(idx, mtId){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_id2',
			idx: idx,
			mtId: mtId
			}, true);
		
			console.log(idx, mtId);
		
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
async function validation_hp2(idx, mtHp){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_hp2',
			idx: idx,
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
async function validation_email2(idx, mtEmail){
	
	try{
		let res = await awaitPost("/mng/adminUpdate.do", 
			{
			action:'check_email2',
			idx: idx,
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
