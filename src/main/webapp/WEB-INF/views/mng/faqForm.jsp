<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="chk_menu" value="4"/>
<c:set var="chk_sub_menu" value="1"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("자주묻는 질문(FAQ) 등록");
</script>
 
<script type="text/javascript" src="${CDN_HTTP}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<div class="wrap">
    <div class="container content_wrap">
        <div class="row">
            <div class="col-12 d-flex justify-content-between">
                <h3 class="h3"><button class="btn btn_back" onclick="history.back();"><i class="bi bi-arrow-left"></i></button>자주묻는 질문(FAQ) 등록</h3>                
            </div>    
            <div class="col-12">     
                <hr class="hr">
                <div class="message_body">  
                    <div class="form-group mt-5">
                        <label>질문</label>
                        <input type="text" class="form-control" id="ftTitle" placeholder="질문 입력">
                    	<small class="d-none form-text text-danger" id="ftTitleError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">질문을 입력해주세요.</small>  
                    </div>      
                    <div class="form-group">
                        <label>상태</label>
                        <select class="form-control" id="ftLevel">
                         	<option value="1" selected>노출</option>
							<option value="2">숨김</option>
                        </select>
                    </div> 
                    <div class="form-group">
                        <label>답변</label>
                        <textarea class="form-control noti_form" placeholder="답변 입력" id="ftContent" name="content"></textarea>                    
                    	<small class="d-none form-text text-danger" id="ftContentError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">답변을 입력해주세요.</small>  
                    </div>
                    <div class="mt-5">
                        <button class="btn btn-light mr-2" onclick="open_modal_confirm2('FAQ 작성을 취소할까요?');">
                            취소
                        </button>
                        <button type="button" class="btn btn-primary"  onclick="open_modal_confirm('FAQ를 등록할까요?');">
                            등록
                        </button>
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
	insert_faq();
});

async function insert_faq(){
	
	oEditors.getById["ftContent"].exec("UPDATE_CONTENTS_FIELD", []); 

	let ftTitle = $("#ftTitle").val();
	let ftLevel = $("#ftLevel").val();
	let ftContent = $("#ftContent").val();
	let error_count = 0;

	
	if(!validation_text(ftTitle)){
		$("#ftTitleError").removeClass('d-none');
		error_count++
	}else{
		$("#ftTitleError").addClass('d-none');
	}

	if(ftContent == "" || ftContent == null || ftContent == '&nbsp;' || ftContent == '<br>' || ftContent == '<br/>' || ftContent == '<p>&nbsp;</p>'){
		$("#ftContentError").removeClass('d-none');
		error_count++;
	}else{
		$("#ftContentError").addClass('d-none');
	}

	if(error_count > 0){
		return;
	}
	
	let params = {
			action:'insert_faq', 
			ftTitle: ftTitle,
			ftLevel: ftLevel,
			ftContent: ftContent
		}
	
	console.log(params);
	
	let res = await awaitPost("./faqUpdate.do", params, true);
	
	if(res.result == 'success'){
		console.log(res);
		open_modal_replace(`./faqDetail?idx=\${res.idx}`, "새로운 FAQ이 등록되었습니다.");
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
	elPlaceHolder : "ftContent", //저는 textarea의 id와 똑같이 적어줬습니다.
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
