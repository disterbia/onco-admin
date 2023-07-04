<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ttTypeTxt" value="회원약관"/>
<c:set var="ttType" value="1"/>
<c:set var="ttMenu" value="0"/>
<c:set var="ttList" value="ttList"/>
<c:if test="${terms.ttType eq 2}">
	<c:set var="ttTypeTxt" value="개인정보처리방침"/>
	<c:set var="ttType" value="2"/>
	<c:set var="ttMenu" value="1"/>
	<c:set var="ttList" value="ttList2"/>
</c:if>

<c:set var="chk_menu" value="5"/>
<c:set var="chk_sub_menu" value="${ttMenu }"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>

<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("${ttTypeTxt} 관리");
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>${ttTypeTxt} 관리</h3>                
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                    <div class="form-group mt-5">
                        <label>제목</label>
                        <input type="text" class="form-control" id="ttTitle" placeholder="제목 입력" value="${terms.ttTitle }">
                    	<small class="d-none form-text text-danger" id="ttTitleError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">제목을 입력해주세요.</small>  
                    </div>       
                    <div class="form-group">
                        <label>상태</label>
                        <select class="form-control" id="ttLevel">
                         	<option value="1" <c:if test="${terms.ttLevel eq 1}">selected</c:if>>노출</option>
							<option value="2" <c:if test="${terms.ttLevel eq 2}">selected</c:if>>숨김</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control noti_form" placeholder="내용 입력" id="ttContent" name="content">${terms.ttContent }</textarea>                    
                    	<small class="d-none form-text text-danger" id="ttContentError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">내용을 입력해주세요.</small>  
                    </div>
                    <div class="mt-5">
                        <button class="btn btn-light mr-3" onclick="open_modal_confirm2('${ttTypeTxt} 수정을 취소할까요?');">취소</button>
                        <button class="btn btn-danger mr-3" onclick="open_modal_confirm3('${ttTypeTxt} 삭제할까요?')">삭제</button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('${ttTypeTxt} 수정할까요?');">저장</button>
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
	update_terms();
});

$('#modal_confirm_btn3').click(function (){
	delete_terms();
});

async function update_terms(){
	
	oEditors.getById["ttContent"].exec("UPDATE_CONTENTS_FIELD", []); 
	
	let idx = ${terms.idx};
	let ttTitle = $("#ttTitle").val();
	let ttLevel = $("#ttLevel").val();
	let ttContent = $("#ttContent").val();
	let error_count = 0;

	
	if(!validation_text(ttTitle)){
		$("#ttTitleError").removeClass('d-none');
		error_count++
	}else{
		$("#ttTitleError").addClass('d-none');
	}

	if(ttContent == "" || ttContent == null || ttContent == '&nbsp;' || ttContent == '<br>' || ttContent == '<br/>' || ttContent == '<p>&nbsp;</p>'){
		$("#ttContentError").removeClass('d-none');
		error_count++;
	}else{
		$("#ttContentError").addClass('d-none');
	}

	if(error_count > 0){
		return;
	}
	
	let res = await awaitPost("./termsUpdate.do", 
			{
				action:'update_terms', 
				idx: idx,
				ttTitle: ttTitle,
				ttLevel: ttLevel,
				ttContent: ttContent
			},
			true
	);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./termsDetail?idx=\${res.idx}`, "${ttTypeTxt}이 수정되었습니다.");
	}else{
		if(res.error_code){
			console.log(res.error_code, res.error_detail);
			open_modal_reload(res.error_code, res.error_detail);
		}else{
			open_modal_reload();
		}
	}
}

async function delete_terms(){
	
	try{
		let idx = ${terms.idx};

		let params = {
			action:'delete_terms',
			idx: idx,
			}
		
		let res = await awaitPost("/mng/termsUpdate.do", params, false);

		if(res.result == 'success'){
			console.log(res);
			open_modal_replace(`./${termsList}`, "${ttTypeTxt}이 삭제되었습니다.");
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
	elPlaceHolder : "ttContent", //저는 textarea의 id와 똑같이 적어줬습니다.
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
