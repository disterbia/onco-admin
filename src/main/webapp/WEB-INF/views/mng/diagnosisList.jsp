<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="chk_menu" value="3"/>
<c:set var="chk_sub_menu" value="2"/>
<c:set var="get_txt" value="?search_filter=${param.search_filter}&search_value=${param.search_value}&pg="/>


<%@ include file="./inc/config.jsp"%>
<%@ include file="./inc/head.jsp"%>
<%@ include file="./inc/nav.jsp"%>

<script>
    $(".default_m_header").addClass("on");
    $(".m_header_center").text("암종정보 관리");
</script>
 
<div class="wrap">
    <div class="container content_wrap">
        <form  action="" method="" onSubmit="return false">
            <div class="row">
                <div class="col-12">
                    <h3 class="h3">암종정보 관리</h3>
	                <button type="button" class="btn btn-light btn-sm position-absolute" data-target="#create_group" data-toggle="modal">+ 암종정보 추가</button>  
                </div>                
                <div class="col-12 col-xl-6 search_group">
                    <div class="form-group">
                        <label>검색어 입력</label>
                        <select class="form-control" id="search_filter" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter}">selected</c:if>>암명</option>
                        </select>
                    </div>
                    <div class="form-group form_search_left">            
                        <input type="text" class="form-control" placeholder="검색어 입력" value="${param.search_value}" id="search_value" onKeyPress="if( event.keyCode==13 ){diagnosis_search();}">
                        <img class="ic_search" src="${CDN_HTTP}/images/ic_search.png" alt="검색">                        
                    </div>
                </div>    
                <div class="col-12 col-xl-6">
                    <div class="btn_wrap">
                        <button type="button" class="btn btn-primary" onclick="diagnosis_search();">검색</button>
                        <button type="button" class="btn btn-link" onclick="location.href='${path}'"><img src="${CDN_HTTP}/images/ic_ini.png" alt="초기화">초기화</button>
                    </div>
                </div>
            </div>        
        </form>
    </div>
	<div class="container content_wrap">
		<div class="row">
			<div class="col-12 table-responsive">
				<h3 class="h3">목록</h3>
				<table class="table table-hover">
					<thead>
						<tr> 
							<th>번호</th>
							<th>암명</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty diagnosisList }">
								<tr>
									<th colspan="6">----------내역이 없습니다----------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="counts" value="${page['counts']}"></c:set>
								<c:forEach items="${diagnosisList}" var="diagnosis">
									<tr>
										<td>${counts}</td>
										<td>${diagnosis.dtName }</td>
										<fmt:formatDate value="${diagnosis.dtWdate}" pattern="yyyy.MM.dd HH:mm" var="dtWdate" />
										<td>${dtWdate }</td>
										<td>
											<button class="btn btn-sm btn-outline-light"  data-target="#create_group2" data-toggle="modal" onclick="selected_idx = ${diagnosis.idx}; $('#dtName2').val('${diagnosis.dtName}')">수정</button>
											<button class="btn btn-sm btn-outline-light" onclick="open_modal_confirm('해당 암종정보를 삭제할까요?'); selected_idx = ${diagnosis.idx};">삭제</button>
										</td>
									</tr>
								<c:set var="counts" value="${counts - 1}"/>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>   
			</div>
		﻿<%@ include file="./inc/paging.jsp" %>
		</div>
	</div>
</div>
<div class="modal fade" id="create_group" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
        	<h5 class="modal-title">암종정보 추가</h5>
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body">
            <div class="input-group">
                <input type="text" class="form-control form-control-sm" placeholder="새로운 암종정보를 입력해주세요." id="dtName" onkeyup="if( event.keyCode==13 ){insert_diagnosis();}">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary btn-sm" style="padding: 0.45rem 1.5rem;" type="button" id="button-addon2" onclick="insert_diagnosis();">추가</button>
                </div>
            </div>
            <small class="d-none form-text text-danger text-left invalid_message" id="dtNameError"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 암종정보입니다.</small>
        </div>
        </div>
    </div>
</div>


<div class="modal fade" id="create_group2" tabindex="-1" >
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-dialog-sm">
        <div class="modal-content">
        <div class="modal-header">
        	<h5 class="modal-title">암종정보 수정</h5>
            <button type="button" class="close btn_close" data-dismiss="modal" aria-label="Close">
                <img src="${CDN_HTTP}/images/ic_x.png" alt="닫기">
            </button>
        </div>
        <div class="modal-body">
            <div class="input-group">
                <input type="text" class="form-control form-control-sm" placeholder="암종정보를 입력해주세요." id="dtName2" onkeyup="if( event.keyCode==13 ){update_diagnosis();}">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary btn-sm" style="padding: 0.45rem 1.5rem;" type="button" id="button-addon2" onclick="update_diagnosis();">변경</button>
                </div>
            </div>
            <small class="d-none form-text text-danger text-left invalid_message" id="dtNameError2"><img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 암종정보입니다.</small>
        </div>
        </div>
    </div>
</div>

<script>
	//해당 페이지 검색옵션
	haveSearchValue = true,  haveSearchFilter = true;
	haveDatePicker2 = false, haveDatePicker = false, haveSearchType = false;
	
	function diagnosis_search(){
		console.log(make_search_path(`${path}`));
		location.href = make_search_path(`${path}`);
	}
	
	var selected_idx = 0;
	
	//암종정보 추가
	async function insert_diagnosis(){
		
		$('#dtNameError').addClass('d-none');
		
		if(!validation_text($("#dtName").val())){
			$('#dtNameError').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">암종정보를 입력해주세요.</small>`);
			$('#dtNameError').removeClass('d-none');
			return;
		}
		
		let params = {
				action:'insert_diagnosis', 
				dtName: $("#dtName").val()
			}
		
		let res = await awaitPost("./diagnosisUpdate.do", params, true);
		
		$('#create_group').modal('hide');
		
		if(res.result == 'success'){
			console.log(res);
			open_modal_reload("새로운 암종정보가 등록되었습니다.");
		}else{
			if(res.error_code){
				if(res.error_code == "duplicate"){
					$('#dtNameError').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 암종정보입니다.</small>`);
					$('#dtNameError').removeClass('d-none');
				}else{
					console.log(res.error_code, res.error_detail);
					open_modal_alert(res.error_code, res.error_detail);
				}
			}else{
				open_modal_alert();
			}
		}
		
		$("#dtName").val("");
		$('#dtNameError').addClass('d-none');
	}
	
	//암종정보 수정
	async function update_diagnosis(){
		
		$('#dtNameError2').addClass('d-none');
		
		if(selected_idx == 0 || !validation_text($("#dtName2").val())){
			$('#dtNameError2').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">암종정보를 입력해주세요.</small>`);
			$('#dtNameError2').removeClass('d-none');
			return;
		}
		
		let params = {
				action:'update_diagnosis', 
				idx: selected_idx,
				dtName: $("#dtName2").val()
			}
		
		let res = await awaitPost("./diagnosisUpdate.do", params, true);
		
		if(res.result == 'success'){
			$('#create_group2').modal('hide');
			console.log(res);
			open_modal_reload("암종정보가 수정되었습니다.");
		}else{
			if(res.error_code){
				if(res.error_code == "duplicate"){
					$('#dtNameError2').html(`<img class="mr-2" src="${CDN_HTTP}/images/ic_label_danger.png">이미 존재하는 암종정보입니다.</small>`);
					$('#dtNameError2').removeClass('d-none');
				}else{
					$('#create_group2').modal('hide');
					console.log(res.error_code, res.error_detail);
					open_modal_alert(res.error_code, res.error_detail);
				}
			}else{
				$('#create_group2').modal('hide');
				open_modal_alert();
			}
		}
	}
	
	$('#modal_confirm_btn').click(function (){
		delete_diagnosis();
	});
	
	async function delete_diagnosis(){
		
		console.log(selected_idx)
		
		if(selected_idx == 0){
			open_modal_alert("삭제할 암종정보를 선택해주세요.");
			return;
		}
		
		let params = {
				action:'delete_diagnosis', 
				idx: selected_idx
			}
		
		let res = await awaitPost("./diagnosisUpdate.do", params, true);
		
		if(res.result == 'success'){
			console.log(res);
			open_modal_reload("암종정보가 삭제처리되었습니다.");
		}else{
			if(res.error_code){
				console.log(res.error_code, res.error_detail);
				open_modal_alert(res.error_code, res.error_detail);
			}else{
				open_modal_alert();
			}
		}
	}
</script>


<%@ include file="./inc/tail.jsp"%>
