<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="2"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("사용자 등록");
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
	$("#datepicker2").datepicker("option", 
		{
			minDate: new Date(2000,0,1),
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
                            <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>사용자 등록</h3>
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
                                    <span>성별<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtGender">
                                        	<option value="0" selected disabled>성별선택</option>
                                        	<option value="1">남</option>
											<option value="2">여</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtGenderError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">성별을 선택해주세요.</small>
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
                                        <input type="text" class="form-control" id="datepicker" placeholder="yyyy.mm.dd" autocomplete='off'>
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
                                    <span>회원 상태<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtLevel">
                                        	<option value="1" selected>활동</option>
											<option value="2">정지</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtLevelError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">상태를 선택해주세요.</small>
                                    </div>
                                </li>
                                <hr class="hr">
                                <li>
                                    <span>진단여부<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtDiagnosis">
                                        	<option value="" selected disabled>진단여부 선택</option>
											<option value="1">확진판정</option>
											<option value="2">미확진</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단여부를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>병원명<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="병원명 입력" id="mtHospital">
                                        <small class="form-text text-danger d-none invalid_message" id="mtHospitalError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">병원명을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>진단일<span class="text-danger">*</span></span>
                                    <div class="form-group calendar">
                                        <input type="text" class="form-control" id="datepicker2" placeholder="yyyy.mm.dd" id="mtDiagnosisDate" autocomplete='off'>
                                        <i class="ic_calendar"><img src="${CDN_HTTP }/images/ic_calendar.png" alt="캘린더"></i>
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisDateError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단일을 선택해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>암종<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtDiagnosisCode">
                                        	<option value="" selected disabled>암종 선택</option>
                                        	<option value="0">*직접입력</option>
                                        	<c:forEach var="diagnosis" items="${diagnoisList}">
                                                <option value="${diagnosis.idx}">${diagnosis.dtName}</option>
                                            </c:forEach>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisCodeError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단여부를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="암종 직접입력" id="mtDiagnosisName" style="display: none;">
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisNameError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">암종을 입력해주세요.</small>
                                    </div>
                                </li>
                                <hr class="hr">
                                <li>
                                	<span>주소</span>
                                	<div class="form-group">
                                		<button type="button" class="btn btn-outline-primary"onclick="sample6_execDaumPostcode();">주소검색</button>
                                	</div>
                                </li>
                                <li>
                                    <span></span>
                                    <div class="form-group">
                                    	<div class="d-flex">
                                        	<input type="text" class="form-control" placeholder="주소 입력"  id="mtAddr" disabled readonly autocomplete="new-password">
                                        </div>
                                        <small class="form-text text-danger d-none invalid_message" id="mtAddrError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">주소를 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span></span>
                                    <div class="form-group">
                                    	<div class="d-flex">
                                        	<input type="text" class="form-control" placeholder="상세 주소 입력"  id="mtAddrDetail" autocomplete="new-password">
                                        </div>
                                        <small class="form-text text-danger d-none invalid_message" id="mtAddrDetailError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">상세 주소를 입력해주세요.</small>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="col-12">
                            <hr class="hr">
                            <div class="btn_wrap">
                                <div class="btn_wrap">
                                    <button class="btn btn-light mr-3" onclick="location.href='./memberList'">취소</button>
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
		let mtGender = $("#mtGender").val();
		let mtHp = $("#mtHp").val();
		let mtEmail= $("#mtEmail").val();
		let mtBirth= $('#datepicker').val();
		let mtBirthSelected = $('#datepicker').datepicker( "getDate" );
		let mtId= $("#mtId").val();
		let mtPwd= $("#mtPwd").val();
		let mtPwd2= $("#mtPwd2").val();
		let mtLevel = $("#mtLevel").val();
		let mtDiagnosis = $("#mtDiagnosis").val();
		let mtHospital = $("#mtHospital").val();
		let mtDiagnosisDate = $("#datepicker2").val();
		let mtDiagnosisDateSelected = $("#datepicker2").datepicker( "getDate" );
		let mtDiagnosisCode = $("#mtDiagnosisCode").val();
		let mtDiagnosisName = $("#mtDiagnosisName").val();
		let mtAddr = $("#mtAddr").val();
		let mtAddrDetail = $("#mtAddrDetail").val();
		
		let error_count = 0;
		
		//성명 확인
		if(!validation_text(mtName)){
			$("#mtNameError").removeClass('d-none');
			$("#mtNameError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"회원명을 입력해주세요");
			error_count++
		}else{
			$("#mtNameError").addClass('d-none');
		}
		
		//성별 확인
		if(mtGender != '1' && mtGender != '2'){
			$("#mtGenderError").removeClass('d-none');
			error_count++
		}else{
			$("#mtGenderError").addClass('d-none');
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
			let isValidEmail = await validation_email(mtEmail);
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
			error_count++;
		}else{
			$("#mtPwdError").addClass('d-none');
		}

		//비밀번호 다시확인
		if(check_two_password(mtPwd, mtPwd2) !== "") {
			$("#mtPwd2Error").removeClass('d-none');
			$('#mtPwd2Error').html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+check_two_password(mtPwd, mtPwd2));
			error_count++;
		}else{
			$("#mtPwd2Error").addClass('d-none');
		}
		
		//진단여부 선택 확인
		if(mtDiagnosis == "" || mtDiagnosis == null){
			$("#mtDiagnosisError").removeClass('d-none');
			error_count++;
		}else if(mtDiagnosis == "1"){
				
			//병원명 입력확인
			if(!validation_text(mtHospital)){
				$("#mtHospitalError").removeClass('d-none');
				error_count++;
			}else{
				$("#mtHospitalError").addClass('d-none');
			}
			
			//진단일 입력확인
			if(mtDiagnosisDate != null && mtDiagnosisDateSelected != null){
				$("#mtDiagnosisDateError").addClass('d-none');
			}else{
				$("#mtDiagnosisDateError").removeClass('d-none');
				error_count++;
			}
			
			//진단코드 입력확인
			if(mtDiagnosisCode == null || mtDiagnosisCode == "" || mtDiagnosisCode == "0"){
				if(mtDiagnosisCode == null || mtDiagnosisCode == ""){
					$("#mtDiagnosisCodeError").removeClass('d-none');
					error_count++;
				}else{
					$("#mtDiagnosisCodeError").addClass('d-none');
				}
				
				if(mtDiagnosisCode == "0" && !validation_text(mtDiagnosisName)){
					$("#mtDiagnosisNameError").removeClass('d-none');
					error_count++;
				}else{
					$("#mtDiagnosisNameError").addClass('d-none');
				}			
				
			}else{
				$("#mtDiagnosisNameError").addClass('d-none');
				$("#mtDiagnosisCodeError").addClass('d-none');
			}
			
			$("#mtDiagnosisError").addClass('d-none');
		
		}else if(mtDiagnosis == "2"){
			$("#mtDiagnosisError").addClass('d-none');
			$("#mtHospitalError").addClass('d-none');
			$("#mtDiagnosisDateError").addClass('d-none');
			$("#mtDiagnosisNameError").addClass('d-none');
			$("#mtDiagnosisCodeError").addClass('d-none');
		}else{
			$("#mtDiagnosisError").addClass('d-none');
			$("#mtHospitalError").addClass('d-none');
			$("#mtDiagnosisDateError").addClass('d-none');
			$("#mtDiagnosisNameError").addClass('d-none');
			$("#mtDiagnosisCodeError").addClass('d-none');
		}
		
		let params = {
				action:'insert_member',
				mtName: mtName,
				mtGender: mtGender,
				mtHp: mtHp,
				mtEmail: mtEmail,
				mtBirth: mtBirth,
				mtId: mtId, 
				mtPwd: mtPwd,
				mtLevel: mtLevel,
		}
		if(mtDiagnosis == "1"){
			params["mtDiagnosis"] = 1;
			params["mtHospital"] = mtHospital;
			params["mtDiagnosisCode"] = mtDiagnosisCode;
			params["mtDiagnosisDate"] = mtDiagnosisDate;
			params["mtDiagnosisName"] = mtDiagnosisName;
			
		}else if(mtDiagnosis == "2"){
			params["mtDiagnosis"] = 2;
		}else{
			
		}
		
		if(mtAddr != ""){
			params["mtAddr"] = mtAddr;
		}
		
		if(mtAddrDetail != ""){
			params["mtAddrDetail"] = mtAddrDetail;
		}
		
		if(error_count > 0){
			return;
		}
		
		let res = await awaitPost("/mng/memberUpdate.do", params);
		console.log(res);
		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./memberDetail?idx=\${res.idx}`, "신규 회원이 등록되었습니다.");
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
		let res = await awaitPost("/mng/memberUpdate.do", 
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
		let res = await awaitPost("/mng/memberUpdate.do", 
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
		let res = await awaitPost("/mng/memberUpdate.do", 
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

$(document).ready(function() {
	$(".mtDiagnosisClass").hide();
});
	
$("#mtDiagnosis").on('change', function() {
	if(this.value == "1"){
		$(".mtDiagnosisClass").show();
	}else{
		$(".mtDiagnosisClass").hide();
	}
});
	
$("#mtDiagnosisCode").on('change', function() {
	if(this.value == "0"){
		$("#mtDiagnosisName").show();
	}else{
		$("#mtDiagnosisName").hide();
		$("#mtDiagnosisNameError").addClass("d-none");
	}
});
	


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
function sample6_execDaumPostcode() {
    var width = 500; //팝업의 너비
    var height = 600;

    console.log(window.screen.width, window.screen.height);

    new daum.Postcode({
        width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
        height: height,
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }

            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다
            document.getElementById("mtAddr").value = addr + extraAddr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("mtAddrDetail").focus();
        }
    }).open({
        left: (window.screen.width / 2) - (width / 2),
        top: (window.screen.height / 2) - (height / 2)
    });
}
</script>
<%@ include file="./inc/tail.jsp"%>
