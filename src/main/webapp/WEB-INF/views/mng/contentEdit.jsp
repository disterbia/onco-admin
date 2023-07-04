<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="3"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("컨텐츠 관리");
    var keywordList = [];
    var fileList = [];
    var fileListLocal = [];
    var fileChange = false;
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>컨텐츠 관리</h3> 
                <span class="text-danger fs_15 fs_500">필수 *</span>               
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                	<div class="d-flex justify-content-between mt-5">
	                	<div class="form-group w-50">
	                        <label>암종</label>
	                        <select class="form-control" id="dtIdx" style="min-width:120px;">
	                            <option value="" selected>선택안함</option>
	                            <c:forEach var="diagnosis" items="${diagnoisList}">
	                                <option value="${diagnosis.idx}" <c:if test="${content.dtIdx eq diagnosis.idx}">selected</c:if>>${diagnosis.dtName}</option>
	                            </c:forEach>
	                        </select>
	                    </div>
	                    <div class="form-group w-50 ml-2">
	                        <label>변이 정보</label>
	                        <select class="form-control" id="gtIdx" style="min-width:120px;">
	                            <option value="" selected>선택안함</option>
	                            <c:forEach var="gene" items="${geneList}">
	                                <option value="${gene.idx}" <c:if test="${content.gtIdx eq gene.idx}">selected</c:if>>${gene.gtName}</option>
	                            </c:forEach>
	                        </select>                  
	                    </div>  
					</div>
					<div class="form-group w-50">
						<label>카테고리</label>
						<div class="d-flex">
		                   <div class="form-check mr-5">
		                       <input class="form-check-input" type="checkbox" name="ctCategory" value="1" id="ctCategory1">
		                       <label class="form-check-label" for="ctCategory1">
		                           <div class="chkbox">
		                               <i class="bi bi-check-lg"></i>
		                           </div>
		                           약제정보
		                       </label>
		                   </div>
		                   <div class="form-check mr-5">
		                       <input class="form-check-input" type="checkbox" name="ctCategory" value="2" id="ctCategory2">
		                       <label class="form-check-label" for="ctCategory2">
		                           <div class="chkbox">
		                               <i class="bi bi-check-lg"></i>
		                           </div>
		                           임상시험
		                       </label>
		                   </div>
		               </div>     
	                </div> 
					<div class="form-group">
                        <label>제목<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="ctTitle" placeholder="제목 입력" value="${content.ctTitle }">
                    	<small class="d-none form-text text-danger" id="ctTitleError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">제목을 입력해주세요.</small>  
                    </div>
                    <div class="form-group">
                        <label>동영상 URL</label>
                        <input type="text" class="form-control" id="ctUrl" placeholder="동영상 URL 입력" value="${content.ctUrl }">
                    	<small class="d-none form-text text-danger" id="ctUrlError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">동영상 URL을 입력해주세요.</small>  
                    </div>
                    <div class="form-group">
                        <!-- <label>내용<span class="text-danger">*</span></label> -->
						<label>내용</label>
                        <textarea class="form-control noti_form" placeholder="내용 입력" id="ctContent" name="content" style="height: 120px;">${content.ctContent }</textarea>            
                        <small class="d-none form-text text-danger" id="ctContentError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">내용을 입력해주세요.</small>          
                    </div>
                    <div class="form-group">
                    	<label>썸네일<span class="text-danger">*</span><small>이미지 사이즈는 320*295로 업로드 해주세요.</small></label>
                    	<div class="chat_input_footer">
		                    <button type="button" class="btn btn_attachment" onclick="open_file_select();">
	                        	<i class="bi bi-paperclip"></i>
		                    </button>
   		                    <input class="d-none" type="file" id="multipartFile" onchange="ValidateMultipleInput(this);">
	                    </div>
	                     <small class="d-none form-text text-danger" id="fileError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">썸네일을 등록해주세요.</small>          
                    </div>
					<div class="form-group">
	                	<label>기타 키워드
	                         <button type="button" class="btn btn-light btn-sm ml-2" style="padding: 0.15rem 1.5rem;" data-target="#create_group" data-toggle="modal">+ 추가</button> 
						</label>	
	              	 	<div class="d-flex align-items-center flex-wrap" id="keywordList">
	                	</div>	
	                </div>
	                <div class="form-group">
                        <label>상태</label>
                        <select class="form-control" id="ctLevel">
                         	<option value="1" <c:if test="${content.ctLevel eq 1}">selected</c:if>>노출</option>
							<option value="2" <c:if test="${content.ctLevel eq 2}">selected</c:if>>숨김</option>
                        </select>
                    </div> 
                    <div class="mt-5">
                        <button class="btn btn-light mr-2" onclick="open_modal_confirm2('컨텐츠 수정을 취소할까요?');">
                            취소
                        </button>
                        <button class="btn btn-danger mr-2" onclick="open_modal_confirm3('해당 컨텐츠를 삭제할까요?')">삭제</button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('컨텐츠를 수정할까요?');">
                            저장
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="create_group" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
        	<h5 class="modal-title">키워드 추가</h5>
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body">
            <div class="input-group">
                <input type="text" class="form-control form-control-sm" placeholder="새로운 키워드를 입력해주세요." id="keyword" onkeyup="onkeyup_valid_keyword(this.value); if( event.keyCode==13 ){add_keyword();}">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary btn-sm" style="padding: 0.45rem 1.5rem;" type="button" id="button-addon2" onclick="add_keyword();">추가</button>
                </div>
            </div>
            <small class="d-none form-text text-danger text-left invalid_message" id="keywordListError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 키워드입니다.</small>
        </div>
        </div>
    </div>
</div>
<c:forEach var="keyword" items="${keywordList}">
<script type="text/javascript">
keywordList.push(`${keyword.ktWord}`);
$('#keywordList').append(`<span class="badge badge-primary fs_14 mr-3 mb-3">${keyword.ktWord}<button type="button" class="btn btn_close my_attachment_xicon px-0 py-0 mx-0 my-0" onclick="remove_this_keyword(this, '${keyword.ktWord}');"><i class="bi bi-x ml-3" style="color:#fff"></i></button></span>`); 
</script>
</c:forEach>
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

//등록가능한 키워드인지 확인
function onkeyup_valid_keyword(keyword){
	if(keywordList.includes(keyword)){
		$('#keywordListError').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 키워드입니다.</small>`);
		$('#keywordListError').removeClass('d-none');
		return;
	}
	$('#keywordListError').addClass('d-none');
}

//키워드 추가
function add_keyword(){
	$('#keywordListError').addClass('d-none');
	let keyword = $("#keyword").val().trim();
	
	if(!validation_text(keyword)){
		$('#keywordListError').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">키워드를 입력해주세요.</small>`);
		$('#keywordListError').removeClass('d-none');
		return;
	}
	
	if(keywordList.includes(keyword)){
		$('#keywordListError').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 키워드입니다.</small>`);
		$('#keywordListError').removeClass('d-none');
		return;
	}
	
	keywordList.push(keyword);
	$('#keywordList').append(`<span class="badge badge-primary fs_14 mr-3 mb-3">\${keyword}<button type="button" class="btn btn_close my_attachment_xicon px-0 py-0 mx-0 my-0" onclick="remove_this_keyword(this, '\${keyword}');"><i class="bi bi-x ml-3" style="color:#fff"></i></button></span>`); 
	$("#keyword").val("");
}

//키워드 삭제
function remove_this_keyword(thisElement, thisKeyword){
	
	keywordList = keywordList.filter(keyword => keyword !== thisKeyword);
	
	$(thisElement).parent().remove();
}

//카테고리 정수값
var ctCategory = ${content.ctCategory};
$(document).ready(function() {
  $('input[name="ctCategory"]').on('change', function() {
    var selectedValues = $('input[name="ctCategory"]:checked').map(function() {
      return $(this).val();
    }).get();

    if (selectedValues.length === 0) {
    	ctCategory = 0;
    } else if (selectedValues.length === 1 && selectedValues.includes('1')) {
    	ctCategory = 1;
    } else if (selectedValues.length === 1 && selectedValues.includes('2')) {
    	ctCategory = 2;
    } else if (selectedValues.length === 2) {
    	ctCategory = 3;
    }
  });

  setCheckbox(ctCategory);

});

//저장된 카테고리값
function setCheckbox(ctCategory) {
    if (ctCategory === 0) {
        $('input[name="ctCategory"]').prop('checked', false);
    } else if (ctCategory === 1) {
        $('#ctCategory1').prop('checked', true);
        $('#ctCategory2').prop('checked', false);
    } else if (ctCategory === 2) {
        $('#ctCategory1').prop('checked', false);
        $('#ctCategory2').prop('checked', true);
    } else if (ctCategory === 3) {
        $('input[name="ctCategory"]').prop('checked', true);
    }
}

//파일 선택하기 클릭 이벤트
function open_file_select() {
    $('#multipartFile').click();
}

// 파일 확장자 배열 (only image)
var _validFileExtensions = [".jpg", ".jpeg", ".bmp", ".gif", ".png", ".bmp", ".emf", ".gif", ".tif", ".wmf"];

// 파일 확장자 확인
function ValidateMultipleInput(oInput) {

    if (oInput.type == "file") {
        let files = oInput.files;
        let count = files.length;
        let invalidFiles = [];
        
        if(files.length > 1){
        	open_modal_alert("최대 1개의 파일까지 첨부가 가능합니다.", "File Error");
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
	update_content();
});

$('#modal_confirm_btn3').click(function (){
	delete_content();
});

async function delete_content(){
	
	try{
		let idx = ${content.idx};

		let params = {
			action:'delete_content',
			idx: idx,
			}
		
		let res = await awaitPost("/mng/contentUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./contentList`, "컨텐츠가 삭되었습니다.");
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

async function update_content(){
	
	oEditors.getById["ctContent"].exec("UPDATE_CONTENTS_FIELD", []); 
	
	let idx = ${content.idx};
	let dtIdx = $("#dtIdx").val();
	let gtIdx = $("#gtIdx").val();
	let ctTitle = $("#ctTitle").val();
	let ctContent = $("#ctContent").val();
	let ctUrl = $("#ctUrl").val();
	let ctLevel = $("#ctLevel").val();
	let error_count = 0;
	
	if(!validation_text(ctTitle)){
		$("#ctTitleError").removeClass('d-none');
		error_count++
	}else{
		$("#ctTitleError").addClass('d-none');
	}
	
// 	if(ctContent == "" || ctContent == null || ctContent == '&nbsp;' || ctContent == '<br>' || ctContent == '<br/>' || ctContent == '<p>&nbsp;</p>'){
// 		$("#ctContentError").removeClass('d-none');
// 		error_count++;
// 	}else{
// 		$("#ctContentError").addClass('d-none');
// 	}
	
// 	if(!validation_text(ctUrl)){
// 		$("#ctUrlError").removeClass('d-none');
// 		error_count++;
// 	}else{
// 		$("#ctUrlError").addClass('d-none');
// 	}
	
	let files = [];
	
	if(fileChange){
		files = await fileArray($('input[type="file"]').get(0).files);
		if(files.length > 0){
			$("#fileError").addClass('d-none');
		}else{
			$("#fileError").removeClass('d-none');
			error_count++;
		}
	}
	
	
	if(error_count > 0){
		return;
	}

	let params = {
			action:'update_content', 
			idx: idx,
			ctCategory: ctCategory,
			ctTitle: ctTitle,
			ctContent: ctContent,
			ctUrl: ctUrl,
			ctLevel: ctLevel,
			keywordList: keywordList
		}
	
	if(dtIdx != ""){
		params['dtIdx'] = dtIdx;
	}
	if(gtIdx != ""){
		params['gtIdx'] = gtIdx;
	}
	if(files.length > 0){
		params['files'] = files;
	}
	
	let res = await awaitPostMultipart("./contentUpdate.do", params, true);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./contentList`, "컨텐츠가 수정되었습니다.");
	}else{
		if(res.error_code){
			console.log(res.error_code, res.error_detail);
			open_modal_reload(res.error_code, res.error_detail);
		}else{
			open_modal_reload();
		}
	}

}

</script>


<%@ include file="./inc/tail.jsp"%>

<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "ctContent", //저는 textarea의 id와 똑같이 적어줬습니다.
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
