<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="chk_menu" value="2"/>
<c:set var="chk_sub_menu" value="2"/>

<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>

<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("연구 회원 상세");
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
	$("#datepicker3").datepicker("option", 
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
                            <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>연구 회원 상세</h3>
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
                                    <span>성별<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtGender">
                                        	<option value="0" selected disabled>성별선택</option>
                                        	<option value="1" <c:if test="${member.mtGender eq 1}">selected</c:if>>남</option>
											<option value="2" <c:if test="${member.mtGender eq 2}">selected</c:if>>여</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtGenderError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">성별을 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>병록번호<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="병록번호 입력" id="mtHospitalId" value="${member.mtHospitalId }">
                                        <small class="form-text text-danger d-none invalid_message" id="mtHospitalIdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">병록번호를 입력해주세요.</small>
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
                                    <span>이메일</span>
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
                                    <span>서비스번호(ID)<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="서비스번호(ID) 입력" id="mtId" autocomplete="new-password" value="${member.mtId}">
                                        <small class="form-text text-danger d-none invalid_message" id="mtIdError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">아이디를 정확히 입력해주세요.</small>
                                    </div>
                                </li>
                                <hr class="hr">
                                <li>
                                    <span>진단여부<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtDiagnosis">
                                        	<option value="" selected disabled>진단여부 선택</option>
											<option value="1" <c:if test="${member.mtDiagnosis eq 1}">selected</c:if>>확진판정</option>
											<option value="2" <c:if test="${member.mtDiagnosis eq 2}">selected</c:if>>미확진</option>
                                        </select>
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단여부를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>병원명<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtHospitalCode">
                                        	<option value="고려대학교 안암병원" <c:if test="${member.mtHospital eq '고려대학교 안암병원'}">selected</c:if>>고려대학교 안암병원</option>
                                        	<option value="고려대학교 구로병원" <c:if test="${member.mtHospital eq '고려대학교 구로병원'}">selected</c:if>>고려대학교 구로병원</option>
                                         	<option value="고려대학교 안산병원" <c:if test="${member.mtHospital eq '고려대학교 안산병원'}">selected</c:if>>고려대학교 안산병원</option>
                                        	<option value="0" <c:if test="${member.mtHospital ne '고려대학교 안암병원' and member.mtHospital ne '고려대학교 구로병원' and member.mtHospital ne '고려대학교 안산병원'}">selected</c:if>>*직접입력</option>
                                        </select>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass <c:if test="${member.mtHospital eq '고려대학교 안암병원' or member.mtHospital eq '고려대학교 구로병원' or member.mtHospital eq '고려대학교 안산병원'}">pb-0</c:if>">
                                    <span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="병원명 직접입력" id="mtHospital" <c:if test="${member.mtHospital eq '고려대학교 안암병원' or member.mtHospital eq '고려대학교 구로병원' or member.mtHospital eq '고려대학교 안산병원'}">style="display: none;"</c:if>
                                        <c:if test="${member.mtHospital ne '고려대학교 안암병원' and member.mtHospital ne '고려대학교 구로병원' and member.mtHospital ne '고려대학교 안산병원'}"> value="${member.mtHospital}"</c:if>>
                                        <small class="form-text text-danger d-none invalid_message" id="mtHospitalError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">병원명을 입력해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>진단의<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <input type="text" class="form-control" placeholder="진단의 입력" id="mtDoctor" value="${member.mtDoctor }">
                                        <small class="form-text text-danger d-none invalid_message" id="mtDoctorError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단의를 입력해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>진단일<span class="text-danger">*</span></span>
                                    <div class="form-group calendar">
                                    	<fmt:formatDate value="${member.mtDiagnosisDate}" pattern="yyyy.MM.dd" var="mtDiagnosisDate" />
                                        <input type="text" class="form-control" id="datepicker2" placeholder="yyyy.mm.dd" autocomplete='off' value="${mtDiagnosisDate }">
                                        <i class="ic_calendar"><img src="${CDN_HTTP }/images/ic_calendar.png" alt="캘린더"></i>
                                        <small class="form-text text-danger d-none invalid_message" id="mtDiagnosisDateError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">진단일을 선택해주세요.</small>
                                    </div>
                                </li>
                                <li class="mtDiagnosisClass">
                                    <span>암종<span class="text-danger">*</span></span>
                                    <div class="form-group">
                                        <select class="form-control" id="mtDiagnosisCode">
                                        	<option value="0" <c:if test="${member.mtDiagnosisCode eq 0}">selected</c:if>>*직접입력</option>
                                        	<c:forEach var="diagnosis" items="${diagnoisList}">
                                                <option value="${diagnosis.idx}" <c:if test="${member.mtDiagnosisCode eq diagnosis.idx}">selected</c:if>>${diagnosis.dtName}</option>
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
                                        	<input type="text" class="form-control" placeholder="주소 입력"  id="mtAddr" disabled readonly autocomplete="new-password" value="${member.mtAddr }">
                                        </div>
                                        <small class="form-text text-danger d-none invalid_message" id="mtAddrError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">주소를 입력해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span></span>
                                    <div class="form-group">
                                    	<div class="d-flex">
                                        	<input type="text" class="form-control" placeholder="상세 주소 입력"  id="mtAddrDetail" autocomplete="new-password" value="${member.mtAddrDetail }">
                                        </div>
                                        <small class="form-text text-danger d-none invalid_message" id="mtAddrDetailError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">상세 주소를 입력해주세요.</small>
                                    </div>
                                </li>
                                <hr class="hr">
                                <li>
                                    <span>동의서 취득일자<span class="text-danger">*</span></span>
                                    <div class="form-group calendar">
                                    	<fmt:formatDate value="${member.mtAgreeDate}" pattern="yyyy.MM.dd" var="mtAgreeDate" />
                                        <input type="text" class="form-control" id="datepicker3" placeholder="yyyy.mm.dd" autocomplete='off' value="${mtAgreeDate }">
                                        <i class="ic_calendar"><img src="${CDN_HTTP }/images/ic_calendar.png" alt="캘린더"></i>
                                        <small class="form-text text-danger d-none invalid_message" id="mtAgreeDateError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">동의서 취득일자를 선택해주세요.</small>
                                    </div>
                                </li>
                                <li>
                                    <span>비고<span class="text-danger"></span></span>
                                    <div class="form-group">
				                        <textarea class="form-control" placeholder="내용 입력" id="mtMemo" name="content">${member.mtMemo}</textarea>                    
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
                            </ul>
                        </div>
                        <div class="col-12">
                            <hr class="hr">
                            <div class="btn_wrap">
                                <div class="btn_wrap">
                                    <button class="btn btn-light mr-3" onclick="location.href='./memberList2'">돌아가기</button>
                                    <button class="btn btn-danger mr-3" onclick="open_modal_confirm2('해당 회원을 삭제처리할까요?')">삭제</button>
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
		let mtGender = $("#mtGender").val();
		let mtHospitalId = $("#mtHospitalId").val();
		let mtHp = $("#mtHp").val();
		let mtEmail= $("#mtEmail").val();
		let mtBirth= $('#datepicker').val();
		let mtBirthSelected = $('#datepicker').datepicker( "getDate" );
		let mtId= $("#mtId").val();
		let mtLevel = 1;
		let error_count = 0;
		
		let mtPwd= $("#mtPwd").val();
		let mtPwd2= $("#mtPwd2").val();
		let mtPwdChange = false;
		
		let mtDiagnosis = $("#mtDiagnosis").val();
		let mtHospital = $("#mtHospital").val();
		let mtHospitalCode = $("#mtHospitalCode").val();
		let mtDiagnosisDate = $("#datepicker2").val();
		let mtDiagnosisDateSelected = $("#datepicker2").datepicker( "getDate" );
		let mtDiagnosisCode = $("#mtDiagnosisCode").val();
		let mtDiagnosisName = $("#mtDiagnosisName").val();
		
		let mtDoctor = $("#mtDoctor").val();
		let mtAgreeDate = $("#datepicker3").val();
		let mtAgreeDateSelected = $('#datepicker3').datepicker( "getDate" );
		let mtMemo = $("#mtMemo").val();
		
		let mtAddr = $("#mtAddr").val();
		let mtAddrDetail = $("#mtAddrDetail").val();
		
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
		
		//병록번호 확인
		if(!validation_text(mtHospitalId)){
			$("#mtHospitalIdError").removeClass('d-none');
			error_count++
		}else{
			$("#mtHospitalIdError").addClass('d-none');
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
			$("#mtIdError").html(`<img class="mr-2" src="\${CDN_HTTP}/images/ic_label_danger.png">`+"서비스번호(ID)를 입력해주세요.");
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
		
		//진단여부 선택 확인
		if(mtDiagnosis == "" || mtDiagnosis == null){
			$("#mtDiagnosisError").removeClass('d-none');
			error_count++;
		}else if(mtDiagnosis == "1"){

			//병원명 입력확인
			if(mtHospitalCode == null || mtHospitalCode == "" || mtHospitalCode == "0"){
				if(mtHospitalCode == null || mtHospitalCode == ""){
					$("#mtHospitalCodeError").removeClass('d-none');
					error_count++;
				}else{
					$("#mtHospitalCodeError").addClass('d-none');
				}
				
				if(mtHospitalCode == "0" && !validation_text(mtHospital)){
					$("#mtHospitalError").removeClass('d-none');
					error_count++;
				}else{
					$("#mtHospitalError").addClass('d-none');
				}	
			}else{
				$("#mtHospitalCodeError").addClass('d-none');
				$("#mtHospitalError").addClass('d-none');
			}
			
			if(mtHospitalCode != "0"){
				mtHospital = mtHospitalCode;
			}
			
			//진단의 입력확인
			if(!validation_text(mtDoctor)){
				$("#mtDoctorError").removeClass('d-none');
				error_count++;
			}else{
				$("#mtDoctorError").addClass('d-none');
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
			$("#mtHospitalCodeError").addClass('d-none');
			$("#mtHospitalError").addClass('d-none');
			$("#mtDiagnosisDateError").addClass('d-none');
			$("#mtDiagnosisNameError").addClass('d-none');
			$("#mtDiagnosisCodeError").addClass('d-none');
			$("#mtDoctorError").addClass('d-none');
		}else{
			$("#mtDiagnosisError").addClass('d-none');
			$("#mtHospitalCodeError").addClass('d-none');
			$("#mtHospitalError").addClass('d-none');
			$("#mtDiagnosisDateError").addClass('d-none');
			$("#mtDiagnosisNameError").addClass('d-none');
			$("#mtDiagnosisCodeError").addClass('d-none')
			$("#mtDoctorError").addClass('d-none');
		}
		
		//동의서취득일자 입력확인
		if(mtAgreeDate != null && mtAgreeDateSelected != null){
			$("#mtAgreeDateError").addClass('d-none');
		}else{
			$("#mtAgreeDateError").removeClass('d-none');
			error_count++
		}
		
		
		if(error_count > 0){
			return;
		}

		let params = {
			action:'update_member2',
			idx: idx,
			mtName: mtName,
			mtGender: mtGender,
			mtHospitalId: mtHospitalId,
			mtHp: mtHp,
			mtEmail: mtEmail,
			mtBirth: mtBirth,
			mtId: mtId, 
			mtLevel: mtLevel,
			mtDoctor: mtDoctor,
			mtAgreeDate: mtAgreeDate,
			mtMemo: mtMemo
			}
		
		if(mtPwdChange){
			params['mtPwd'] = mtPwd;
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
		
		let res = await awaitPost("/mng/memberUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./memberList2`, "연구 회원 정보가 변경되었습니다.");
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
			action:'retire_member',
			idx: idx,
			}
		
		let res = await awaitPost("/mng/memberUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./memberList2`, "회원이 삭제처리되었습니다.");
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
		let res = await awaitPost("/mng/memberUpdate.do", 
			{
			action:'check_id2',
			idx: idx,
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
async function validation_hp2(idx, mtHp){
	
	try{
		let res = await awaitPost("/mng/memberUpdate.do", 
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
		let res = await awaitPost("/mng/memberUpdate.do", 
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

$("#mtHospitalCode").on('change', function() {
	if(this.value == "0"){
		$("#mtHospital").show();
		$("#mtHospital").parent().css("padding-bottom","2.4rem");
	}else{
		$("#mtHospital").hide();
		$("#mtHospital").parent().css("padding-bottom","0");
		$("#mtHospitalError").addClass("d-none");
	}
});

</script>


<c:if test="${member.mtDiagnosis eq 2}">
<script>
$(document).ready(function() {
	$(".mtDiagnosisClass").hide();
});
</script>
</c:if>
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
