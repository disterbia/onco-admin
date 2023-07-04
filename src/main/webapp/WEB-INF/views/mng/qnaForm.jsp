<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="4"/>
<c:set var="chk_sub_menu" value="2"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("1:1 문의 등록 (비회원용)");
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>1:1 문의 등록 (비회원용)</h3> 
                <span class="text-danger fs_15 fs_500">필수 *</span>               
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                	<div class="form-group mt-5">
                        <label>문의유형<span class="text-danger">*</span></label>
                        <select class="form-control" id="qtType">
                        	<option value="" selected disabled>문의유형 선택</option>
                         	<option value="1">서비스지 취소요청</option>
							<option value="2">서비스지 신청 관련</option>
							<option value="3">서비스지 내용 관련</option>
							<option value="4">회원가입 관련</option>
							<option value="5">기타</option>
                        </select>
                        <small class="d-none form-text text-danger" id="qtTypeError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">문의유형을 선택해주세요.</small>  
                    </div> 
                    <div class="d-flex justify-content-between">
	                    <div class="form-group w-50">
	                        <label>이름<span class="text-danger">*</span></label>
	                        <input type="text" class="form-control" id="mtName" placeholder="이름 입력">
	                    	<small class="d-none form-text text-danger" id="mtNameError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이름을 입력해주세요.</small>  
	                    </div>
	                    <div class="form-group w-50 ml-3">
	                        <label>연락처<span class="text-danger">*</span></label>
	                        <input type="text" class="form-control" placeholder="연락처 입력" id="mtHp" maxlength="13">
	                    	<small class="d-none form-text text-danger" id="mtHpError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">휴대폰 번호 13자리를 모두 입력해주세요.</small>  
	                    </div>
                    </div>
                    <div class="form-group">
                        <label>이메일<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="mtEmail" placeholder="이메일 입력">
                    	<small class="d-none form-text text-danger" id="mtEmailError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이메일을 입력해주세요.</small>  
                    </div>
                    <div class="form-group">
                        <label>제목<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="qtTitle" placeholder="질문 입력">
                    	<small class="d-none form-text text-danger" id="qtTitleError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">제목을 입력해주세요.</small>  
                    </div>
                    <div class="form-group">
                        <label>내용<span class="text-danger">*</span></label>
                        <textarea class="form-control" placeholder="내용 입력" id="qtContent" name="content" style="height: 120px;"></textarea>                    
                    	<small class="d-none form-text text-danger" id="qtContentError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">내용을 입력해주세요.</small>  
                    </div>
                    <div class="form-group">
                    	<label>첨부파일 (최대 2개)</label>
                    	<div class="chat_input_footer">
		                    <button type="button" class="btn btn_attachment" onclick="open_file_select();">
	                        	<i class="bi bi-paperclip"></i>
		                    </button>
   		                    <input class="d-none" type="file" id="multipartFile" multiple onchange="ValidateMultipleInput(this);">
	                    </div>
                    </div>
                    <hr class="hr">
                    <div class="form-group">
                        <label>답변</label>
                        <textarea class="form-control noti_form" placeholder="답변 입력" id="qtAnswer" name="content" style="height: 120px;"></textarea>                    
                    </div>
                    <div class="mt-5">
                        <button class="btn btn-light mr-2" onclick="open_modal_confirm2('QNA 작성을 취소할까요?');">
                            취소
                        </button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('QNA를 등록할까요?');">
                            등록
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

//파일 선택하기 클릭 이벤트
function open_file_select() {
    $('#multipartFile').click();
}

// 파일 확장자 배열
var _validFileExtensions = [".jpg", ".jpeg", ".bmp", ".gif", ".png", ".doc", ".docm", ".docx", ".dot", ".dotm", ".dotx", ".odt", ".pdf", ".rtf", ".txt", ".wps", 
    ".xml", ".xps", ".csv", ".dbf", ".dif", ".ods", ".prn", ".slk", ".xla", ".xlam", ".xls", ".xlsb", ".xlsm", ".xlsx", ".", ".xlt", ".xltm", ".xltx", ".xlw", 
    ".bmp", ".emf", ".gif", ".mp4", ".odp", ".pot", ".potm", ".potx", ".ppa", ".ppam", ".pps", ".ppsm", ".ppsx", ".ppt", ".pptm", ".pptx", ".thmx", ".tif", ".wmf",
    ".wmv", ".zip", ".bin", ".alz", ".cab", ".tar", ".tgz", ".war", ".rar", ".7z"];

// 파일 확장자 확인
function ValidateMultipleInput(oInput) {

    if (oInput.type == "file") {
        let files = oInput.files;
        let count = files.length;
        let invalidFiles = [];
        
        if(files.length > 2){
        	open_modal_alert("최대 2개의 파일까지 첨부가 가능합니다.", "File Error");
        	return false;
        }

        for (let i = 0; i < count; i++) {
            let sFileName = files[i].name;
            let blnValid = false;

            for (let j = 0; j < _validFileExtensions.length; j++) {
                let sCurExtension = _validFileExtensions[j];
                let sFileExt = sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toUpperCase();

                if (sFileExt.toLowerCase() == sCurExtension.toLowerCase()) {
                    blnValid = true;
                    break;
                }
            }

            if (!blnValid) {
                invalidFiles.push(sFileName);
            } else {
            	set_file_local(sFileName, i);
            }
        }
		
        
        if (invalidFiles.length > 0) {
            let invalidExtensions = invalidFiles.join(", ");
            open_modal_alert("\"" + invalidExtensions + "\" - 해당 확장자는 첨부가 불가능한 확장자입니다.", "File Error");
            oInput.value = "";
            return false;
        }
    }
    return true;
}

function set_file(fileName, filePath, i){
	let file_html = `
		<div class="d-flex align-items-center">
			<div class="attachment_title my_attachment_title" onclick="downloadFile('./download/\${filePath}', '\${fileName}')" style="cursor: pointer;">\${fileName}</div>
	        <button type="button" class="btn btn_close my_attachment_xicon" onclick="remove_file(this, \${i});">
	       		<i class="bi bi-x"></i>	
	        </button>
	    </div>
	`;
	$('.chat_input_footer').append(file_html);
}

function set_file_local(fileName, i){
	fileChange = true;
	let file_html = `
		<div class="d-flex align-items-center">
			<div class="attachment_title my_attachment_title">\${fileName}</div>
	        <button type="button" class="btn btn_close my_attachment_xicon" onclick="remove_file_local(this, \${i});">
	       		<i class="bi bi-x"></i>	
	        </button>
	    </div>
	`;
	$('.chat_input_footer').append(file_html);
}

//파일 삭제 버튼 클릭 시
function remove_file(el, i){
	fileChange = true;
	$(el).parent().remove();
}

//파일 삭제 버튼 클릭 시 - local
function remove_file_local(el, i){
	$(el).parent().remove();
	
	let files = $('#multipartFile').prop('files');
    let fileCount = files.length;

 	// 새로운 FileList 객체 생성
    let newFileList = new DataTransfer();

    if (fileCount > 0) {
        // 선택된 파일이 존재하는 경우
        for (let j = 0; j < fileCount; j++) {
            if (j !== i) {
                newFileList.items.add(files[j]);
            }
        }
        //삭제된 파일을 제외한 객체 초기화
        $('#multipartFile')[0].files = newFileList.files;
    }
}


$('#modal_confirm_btn2').click(function (){
	history.back();
});

$('#modal_confirm_btn').click(function (){
	insert_qna();
});

async function insert_qna(){
	
	oEditors.getById["qtAnswer"].exec("UPDATE_CONTENTS_FIELD", []); 

	let qtType = $("#qtType").val();
	let mtName = $("#mtName").val();
	let mtHp = $("#mtHp").val();
	let mtEmail = $("#mtEmail").val();
	let qtTitle = $("#qtTitle").val();
	let qtContent = $("#qtContent").val();
	let qtAnswer = $("#qtAnswer").val();
	let error_count = 0;
	
	if(qtType == null || qtType == ""){
		$("#qtTypeError").removeClass('d-none');
		error_count++
	}else{
		$("#qtTypeError").addClass('d-none');
	}
	
	if(!validation_text(mtName)){
		$("#mtNameError").removeClass('d-none');
		error_count++
	}else{
		$("#mtNameError").addClass('d-none');
	}
	
	if(!validation_text(mtHp)|| mtHp.length != 13){
		$("#mtHpError").removeClass('d-none');
		error_count++
	}else{
		$("#mtHpError").addClass('d-none');
	}
	
	if(!validation_text(mtEmail)){
		$("#mtEmailError").removeClass('d-none');
		error_count++
	}else{
		$("#mtEmailError").addClass('d-none');
	}
	
	if(!validation_text(qtTitle)){
		$("#qtTitleError").removeClass('d-none');
		error_count++
	}else{
		$("#qtTitleError").addClass('d-none');
	}
	
	if(!validation_text(qtContent)){
		$("#qtContentError").removeClass('d-none');
		error_count++
	}else{
		$("#qtContentError").addClass('d-none');
	}

	if(error_count > 0){
		return;
	}

	let params = {
			action:'insert_qna', 
			qtType: qtType,
			mtName: mtName,
			mtHp: mtHp,
			mtEmail: mtEmail,
			qtTitle: qtTitle,
			qtContent: qtContent,
			qtAnswer: qtAnswer
		}
	
	let files = await fileArray($('input[type="file"]').get(0).files);
	if(files.length > 0){
		params['files'] = files;
	}
	
	let res = await awaitPostMultipart("./qnaUpdate.do", params, true);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./qnaEdit?idx=\${res.idx}`, "새로운 1:1문의가 등록되었습니다.");
	}else{
		if(res.error_code){
			console.log(res.error_code, res.error_detail);
			open_modal_reload(res.error_code, res.error_detail);
		}else{
			open_modal_reload();
		}
	}

}


$(document).on('keyup', '#mtHp', function(e) {
	$(this).val( validation_hypen(validation_number($(this).val())) );
});
$(document).on('blur', '#mtHp', function(e) {
	$(this).val( validation_hypen(validation_number($(this).val())) );
});



function awaitMultipart(sendUrl, formData, progress){
	
	token = $("meta[name='_csrf']").attr("content");
	header = $("meta[name='_csrf_header']").attr("content");
	parameter = $("meta[name='_csrf_parameter']").attr("content");
	
	formData.append(parameter, token);	

    return new Promise((resolve, reject) => { // 1.
        $.ajax({
            url: sendUrl,
            type: "POST",
            enctype: 'multipart/form-data',
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            success: (res) => {
                resolve(res);  // 2.
            },
            error: (e) => {
                reject(e);  // 3.
            },
			beforeSend: function(xhr) {
				xhr.setRequestHeader(parameter, token);
				if(progress)show_indicator();
			},
			complete: function () {
				if(progress)hide_indicator();
			},
        });
    });
}
</script>


<%@ include file="./inc/tail.jsp"%>

<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "qtAnswer", //저는 textarea의 id와 똑같이 적어줬습니다.
	sSkinURI : CDN_HTTP + "/editor/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
	fCreator : "createSEditor2",
	htParams : {
		// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseToolbar : true,

		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : false,

		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : false
	}
});

</script>
