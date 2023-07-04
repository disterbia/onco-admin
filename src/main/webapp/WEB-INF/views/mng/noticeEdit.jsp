<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="4"/>
<c:set var="chk_sub_menu" value="0"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("공지사항 관리");
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>공지사항 관리</h3>                
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                    <div class="form-group mt-5">
                        <label>제목</label>
                        <input type="text" class="form-control" id="ntTitle" placeholder="제목 입력" value="${notice.ntTitle }">
                    	<small class="d-none form-text text-danger" id="ntTitleError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">제목을 입력해주세요.</small>  
                    </div>       
                    <div class="form-group">
                        <label>상태</label>
                        <select class="form-control" id="ntLevel">
                         	<option value="1" <c:if test="${notice.ntLevel eq 1}">selected</c:if>>노출</option>
							<option value="2" <c:if test="${notice.ntLevel eq 2}">selected</c:if>>숨김</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control noti_form" placeholder="내용 입력" id="ntContent" name="content">${notice.ntContent }</textarea>                    
                    	<small class="d-none form-text text-danger" id="ntContentError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">내용을 입력해주세요.</small>  
                    </div>
                    <div class="mt-5">
                        <button class="btn btn-light mr-3" onclick="open_modal_confirm2('공지사항 수정을 취소할까요?');">취소</button>
                        <button class="btn btn-danger mr-3" onclick="open_modal_confirm3('공지사항을 삭제할까요?')">삭제</button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('공지사항을 수정할까요?');">저장</button>
                    </div>

                </div>  
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">


$('#modal_confirm_btn2').click(function (){
	history.back();
});

$('#modal_confirm_btn').click(function (){
	update_notice();
});

$('#modal_confirm_btn3').click(function (){
	delete_notice();
});

async function update_notice(){
	
	oEditors.getById["ntContent"].exec("UPDATE_CONTENTS_FIELD", []); 
	
	let idx = ${notice.idx};
	let ntTitle = $("#ntTitle").val();
	let ntLevel = $("#ntLevel").val();
	let ntContent = $("#ntContent").val();
	let error_count = 0;

	
	if(!validation_text(ntTitle)){
		$("#ntTitleError").removeClass('d-none');
		error_count++
	}else{
		$("#ntTitleError").addClass('d-none');
	}

	if(ntContent == "" || ntContent == null || ntContent == '&nbsp;' || ntContent == '<br>' || ntContent == '<br/>' || ntContent == '<p>&nbsp;</p>'){
		$("#ntContentError").removeClass('d-none');
		error_count++;
	}else{
		$("#ntContentError").addClass('d-none');
	}

	if(error_count > 0){
		return;
	}
	
	let res = await awaitPost("./noticeUpdate.do", 
			{
				action:'update_notice', 
				idx: idx,
				ntTitle: ntTitle,
				ntLevel: ntLevel,
				ntContent: ntContent
			},
			true
	);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./noticeDetail?idx=\${res.idx}`, "공지사항이 수정되었습니다.");
	}else{
		if(res.error_code){
			console.log(res.error_code, res.error_detail);
			open_modal_reload(res.error_code, res.error_detail);
		}else{
			open_modal_reload();
		}
	}
}

async function delete_notice(){
	
	try{
		let idx = ${notice.idx};

		let params = {
			action:'delete_notice',
			idx: idx,
			}
		
		let res = await awaitPost("/mng/noticeUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./notiList`, "공지사항이 삭제되었습니다.");
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

</script>


<%@ include file="./inc/tail.jsp"%>

<script>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
	elPlaceHolder : "ntContent", //저는 textarea의 id와 똑같이 적어줬습니다.
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
