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
    $(".m_header_center").text("1:1 문의 관리 (비회원용)");
    var fileList = [];
    var fileListLocal = [];
    var fileChange = false;
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>1:1 문의 관리</h3> 
                <span class="text-danger fs_15 fs_500">필수 *</span>               
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                	<div class="form-group mt-5">
                        <label>문의유형</label>
                        <input type="text" class="form-control" id="qtType" value="${qtTypeArr[qna.qtType] }" disabled readonly style="color: #22272B; background-color: #e9ecef;">
                    </div> 
                    <div class="d-flex justify-content-between">
	                    <div class="form-group w-50">
	                        <label>이름</label>
	                        <input type="text" class="form-control" id="mtName" value="${qna.mtName }" disabled readonly style="color: #22272B; background-color: #e9ecef;">
	                    </div>
	                    <div class="form-group w-50 ml-3">
	                        <label>연락처</label>
	                        <input type="text" class="form-control" id="mtHp" value="${qna.mtHp }" disabled readonly style="color: #22272B; background-color: #e9ecef;"> 
	                    </div>
                    </div>
                    <div class="form-group">
                        <label>이메일</label>
	                    <input type="text" class="form-control" id="mtEmail" value="${qna.mtEmail }" disabled readonly style="color: #22272B; background-color: #e9ecef;"> 
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input type="text" class="form-control" id="qtTitle" value="${qna.qtTitle }" disabled readonly style="color: #22272B; background-color: #e9ecef;">   
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <input type="text" class="form-control" id="qtContent" value="${qna.qtContent }" disabled readonly style="color: #22272B; background-color: #e9ecef;">  
                    </div>
                    <div class="form-group">
                    	<label>첨부파일 (최대 2개)</label>
                    	<div class="chat_input_footer">
		                    <button type="button" class="btn btn_attachment">
	                        	<i class="bi bi-paperclip"></i>
		                    </button>
   		                    <input class="d-none" type="file" id="multipartFile" multiple onchange="ValidateMultipleInput(this);">
	                    </div>
                    </div>
                    <hr class="hr">
                    <div class="form-group">
                        <label>답변작성</label>
                        <textarea class="form-control noti_form" placeholder="답변 입력" id="qtAnswer" name="content" style="height: 120px;">${qna.qtAnswer}</textarea>                    
                    </div>
                    <div class="mt-5">
                        <button class="btn btn-light mr-2" onclick="open_modal_confirm2('답변 작성을 취소할까요?');">
                            취소
                        </button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('해당 답변을 등록할까요?');">
                            등록
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:forEach var="file" items="${fileList}">
<script type="text/javascript">
fileList.push( { ftName: `${file.ftName}`, ftUuid: `${file.ftUuid}` } );
</script>
</c:forEach>
<script type="text/javascript">

$(document).ready(function() {
	fileList.forEach( (file, index) => {
		set_file(file.ftName, file.ftUuid, index);
	});
});

$('#modal_confirm_btn2').click(function (){
	history.back();
});

$('#modal_confirm_btn').click(function (){
	update_qna();
});


function set_file(fileName, filePath, i){
	let file_html = `
		<div class="d-flex align-items-center">
			<div class="attachment_title my_attachment_title" onclick="downloadFile('./download/\${filePath}', '\${fileName}')" style="cursor: pointer;">\${fileName}</div>
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

async function update_qna(){
	
	error_count = 0;
	
	oEditors.getById["qtAnswer"].exec("UPDATE_CONTENTS_FIELD", []); 

	let idx = ${qna.idx};
	let qtAnswer = $("#qtAnswer").val();

	if(qtAnswer == "" || qtAnswer == null || qtAnswer == '&nbsp;' || qtAnswer == '<br>' || qtAnswer == '<br/>' || qtAnswer == '<p>&nbsp;</p>'){
		$("#qtAnswerError").removeClass('d-none');
		error_count++;
	}else{
		$("#qtAnswerError").addClass('d-none');
	}

	if(error_count > 0){
		return;
	}
	
	let params = {
			action:'update_qna', 
			idx: idx,
			qtAnswer: qtAnswer
		}
	
	console.log(params);
	
// 	return;
	
	let res = await awaitPostMultipart("./qnaUpdate.do", params, true);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./qnaEdit?idx=\${res.idx}`, "답변이 등록되었습니다.");
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
