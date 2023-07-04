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
    $(".m_header_center").text("연구 회원 목록");
</script>
 
<div class="wrap">
    <div class="container content_wrap">
        <form  action="" method="" onSubmit="return false">
            <div class="row">
                <div class="col-12">
                    <h3 class="h3">연구 회원 목록</h3>
	                <button type="button" class="btn btn-light btn-sm position-absolute" onclick="location.href='./memberForm2'">+ 신규 등록</button>  
                </div>                
                <div class="col-12 col-xl-6 search_group">
                    <div class="form-group">
                        <label>검색어 입력</label>
                        <select class="form-control" id="search_filter" style="min-width:120px;">
                            <option value="all" <c:if test="${empty param.search_filter}">selected</c:if>>통합검색</option>
                            <option value="mtId" <c:if test="${param.search_filter eq 'mtId'}">selected</c:if>>아이디</option>
                            <option value="mtName" <c:if test="${param.search_filter eq 'mtName'}">selected</c:if>>이름</option>
                        	<option value="mtEmail" <c:if test="${param.search_filter eq 'mtEmail'}">selected</c:if>>이메일</option>
                        </select>
                    </div>
                    <div class="form-group form_search_left">            
                        <input type="text" class="form-control" placeholder="검색어 입력" value="${param.search_value}" id="search_value" onKeyPress="if( event.keyCode==13 ){member_search();}">
                        <img class="ic_search" src="${CDN_HTTP}/images/ic_search.png" alt="검색">                        
                    </div>
                </div>
                <div class="col-12 col-xl-6">
                    <div class="btn_wrap">
                        <button type="button" class="btn btn-primary" onclick="member_search();">검색</button>
                        <button type="button" class="btn btn-link" onclick="location.href='${path}'"><img src="${CDN_HTTP}/images/ic_ini.png" alt="초기화">초기화</button>
                    </div>
                </div>
            </div>        
        </form>
    </div>
	<div class="container content_wrap">
		<div class="row">
			<div class="col-12">
            	<header class="table_header">
                        <div class="table_header_left">
		                    <div class="form-check">
		                        <input class="form-check-input" type="checkbox" value="all" id="checkboxMemberAll">
		                        <label class="form-check-label" for="checkboxMemberAll">
		                            <div class="chkbox">
		                                <i class="bi bi-check-lg"></i>
		                            </div>
		                            <span class="fs_15 fw_600">전체<span id="selected_total"></span></span>
		                        </label>
		                    </div>
                        </div>
                        <div class="table_header_right">
                            <div class="category_label_wrap">
                                <button class="btn btn-sm btn-outline-light" onclick="open_modal_confirm('선택된 회원정보를 다운로드 하시겠습니까?')"><img src="${CDN_HTTP}/images/ic_excel.png" class="mb-n1" alt="엑셀"> 엑셀다운로드</button>
                            </div>
                        </div>
                </header>    
			</div>
			<div class="col-12 table-responsive">
				<table class="table table-hover">
					<thead>
						<tr> 
							<th>
								<div class="form-check">
			                        <input class="form-check-input" type="checkbox" value="page" id="checkboxMemberPage">
			                        <label class="form-check-label" for="checkboxMemberPage">
			                            <div class="chkbox">
			                                <i class="bi bi-check-lg"></i>
			                            </div>
			                            <span class="fs_15 fw_600"></span>
			                        </label>
			                    </div>
							</th>
							<th>번호</th>
							<th>상태</th>
							<th>이름</th>
							<th>아이디</th>
							<th>이메일</th>
							<th>연락처</th>
							<th>등록일시</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty members }">
								<tr>
									<th colspan="9">----------내역이 없습니다----------</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="counts" value="${page['counts']}"></c:set>
								<c:set var="memberCnt" value="0" />
								<c:set var="selectedCnt" value="0" />
								<c:forEach items="${members}" var="member">
									<c:set var="memberCnt" value="${memberCnt + 1}" />
									<tr>
										<td>
											<div class="form-check">
												<c:set var="containsIdx" value="false" />
												<c:forEach items="${memberSelectedList}" var="selectedIdx">
												  <c:if test="${member.idx eq selectedIdx}">
												    <c:set var="containsIdx" value="true" />
												    <c:set var="selectedCnt" value="${selectedCnt + 1}" />
												  </c:if>
												</c:forEach>
						                        <input class="form-check-input checkboxMember" type="checkbox" value="${member.idx }" id="checkboxMember${member.idx }"
						                        	<c:if test="${containsIdx eq true}">checked</c:if>
						                        >
						                        <label class="form-check-label" for="checkboxMember${member.idx }">
						                            <div class="chkbox">
						                                <i class="bi bi-check-lg"></i>
						                        </label>
						                    </div>
										</td>
										<td>${counts}</td>
										<td>${mtLevelBadgeArr[member.mtLevel] }</td>
										<td>${member.mtName }</td>
										<td>${member.mtId }</td>
										<td>${member.mtEmail }</td>
										<td>${member.mtHp }</td>
										<fmt:formatDate value="${member.mtWdate}" pattern="yyyy.MM.dd HH:mm" var="mtWdate" />
										<td>${mtWdate }</td>
										<c:choose>
											<c:when test="${member.mtLevel eq 10}">
												<td><button class="btn btn-sm btn-outline-light" onclick="location.href='./memberRetireDetail?idx=${member.idx}';">상세</button></td>
											</c:when>
											<c:otherwise>
											<td><button class="btn btn-sm btn-outline-light" onclick="location.href='./memberDetail2?idx=${member.idx}';">상세</button></td>
											</c:otherwise>
										</c:choose>
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

<script>
	//해당 페이지 검색옵션
	haveSearchValue = true,  haveSearchFilter = true;
	haveDatePicker2 = false, haveDatePicker = false, haveSearchType = false;
	
	function member_search(){
		console.log(make_search_path(`${path}`));
		location.href = make_search_path(`${path}`);
	}
	
	//다운로드 관련 함수 /////////////////////////////////////////
	
	//전체 선택
	var totalSelected = Number('${selectedCnt}');
	var totalSelected = Number('${memberSelectedListCnt}');
	
	//엑셀 다운로드 버튼 컨펌창
	$('#modal_confirm_btn').click(function (){
		excel_download();
	});
	
	//엑셀 다운로드
	function excel_download(){
		if(totalSelected == 0){open_modal_alert("다운로드할 회원을 선택해주세요."); return;}
		window.open('/mng/excel.do','_blank');
	}
	
	//체크박스 이벤트 리스너
	$(document).ready(function() {
		
		countMember(totalSelected);
		
		//전체 선택/해제
        $('#checkboxMemberAll').on('change', function() {
            if ($(this).is(':checked')) {
                var confirmResult = confirm("연구 회원 전체를 선택할까요?");
                if (!confirmResult) {
                    $(this).prop('checked', false);
                }else{
                	selectAllMember("selectAll2");
                	$('.checkboxMember').prop("checked", true);
                	$('#checkboxMemberPage').prop("checked", true);
                }
            } else {
                var confirmResult = confirm("연구 회원 전체를 선택 해제 할까요?");
                if (!confirmResult) {
                    $(this).prop('checked', true);
                }else{
                	selectAllMember("unselectAll2");
                	$('.checkboxMember').prop("checked", false);
                	$('#checkboxMemberPage').prop("checked", false);
                }
            }
        });
	
		//현재 페이지 선택/해제
        $('#checkboxMemberPage').on('change', function() {
        	selectPageMember($(this).is(':checked') ? "select" : "unselect");
        	$('.checkboxMember').prop("checked", $(this).is(':checked'));
        });
		
      	//하나의 체크박스 선택/해제
        $('.checkboxMember').on('change', function() {
        	selectMember($(this).is(':checked') ? "select" : "unselect", $(this).val());
        	if(!$(this).is(':checked')){
        		$('#checkboxMemberPage').prop("checked", false);
        		$('#checkboxMemberAll').prop("checked", false);
        	}
        	
        	if($('.checkboxMember').length == $('.checkboxMember:checked').length){
        		$('#checkboxMemberPage').prop("checked", true);
        	}
        });
    });
	
	//전체회원 체크 / 해제
	async function selectAllMember(action){
		let params = {action: action}
		let res = await awaitPost("/mng/excelSelect.do", params, false);
		if(res.result == 'success'){
			countMember(res.total);
		}else{
			if(res.error_code){
				open_modal_alert(res.error_code, res.error_detail);
			}else{
				open_modal_alert();
			}
		}
	}
	
	//현재 페이지 전체 체크 / 해제
	async function selectPageMember(action){
		
		let list = [];
		$('.checkboxMember').each(function() {
			list.push($(this).val());
		});
		
		let params = {action: action, selectList: list}
		let res = await awaitPost("/mng/excelSelect.do", params, false);
		if(res.result == 'success'){
			countMember(res.total);
		}else{
			if(res.error_code){
				open_modal_alert(res.error_code, res.error_detail);
			}else{
				open_modal_alert();
			}
		}
	}
	
	//선택 회원 체크 / 해제
	async function selectMember(action, value){
		let params = {action: action, selectList: [value]}
		let res = await awaitPost("/mng/excelSelect.do", params, false);
		if(res.result == 'success'){
			countMember(res.total);
		}else{
			if(res.error_code){
				open_modal_alert(res.error_code, res.error_detail);
			}else{
				open_modal_alert();
			}
		}
	}
	//총 선택 회원 표
	function countMember(total){
		totalSelected = total;
		if(total > 0){
			$("#selected_total").text(" (선택: " + total + ")")
		}else{
			$('#checkboxMemberAll').prop("checked", false);
			$("#selected_total").text("");
		}
	}
	
</script>

<c:if test="${memberCnt eq selectedCnt and not empty memberCnt}">
<script>
console.log(`${selectedCnt}, ${memberCnt}`)
$(document).ready(function() {
	$('#checkboxMemberPage').prop("checked", true);
});
</script>
</c:if>


<%@ include file="./inc/tail.jsp"%>
