
//알림창
function open_modal_alert(text="", focus_text="", button_label=""){

    if(focus_text == "" && text == ""){
        $('#modal_alert_body').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_alert_body').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_alert_body').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }

    if(button_label !== ""){
        $('#modal_alert_btn').val(button_label);
    }else{
        $('#modal_alert_btn').val('확인');
    }

    $('#modal_alert').modal();
}

//알림창 - 새로고침
function open_modal_reload(text="", focus_text="", button_label=""){

    if(focus_text == "" && text == ""){
        $('#modal_reload_body').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_reload_body').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_reload_body').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }

    if(button_label !== ""){
        $('#modal_reload_btn').val(button_label);
    }else{
        $('#modal_reload_btn').val('닫기');
    }

    $('#modal_reload').modal();
}




//알림창 - 페이지 이동
var open_modal_go_url = "";

function open_modal_go(url="", text="", focus_text="", button_label=""){

    open_modal_go_url = url;

    if(focus_text == "" && text == ""){
        $('#modal_go_body').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_go_body').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_go_body').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }

    if(button_label !== ""){
        $('#modal_go_btn').val(button_label);
    }else{
        $('#modal_go_btn').val('확인');
    }

    $('#modal_go').modal();
}




//알림창 - 페이지 리다이렉션
var open_modal_replace_url = "";

function open_modal_replace(url="", text="", focus_text="", button_label=""){
	
	$('.modal').modal('hide');

    open_modal_replace_url = url;

    if(focus_text == "" && text == ""){
        $('#modal_replace_body').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_replace_body').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_replace_body').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }

    if(button_label !== ""){
        $('#modal_replace_btn').val(button_label);
    }else{
        $('#modal_replace_btn').val('확인');
    }

    $('#modal_replace').modal();
}

function open_modal_confirm(text="", focus_text="", button_label=""){
	
	if(focus_text == "" && text == ""){
        $('#modal_confirm_body').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_confirm_body').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_confirm_body').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }
	
	if(button_label !== ""){
        $('#modal_confirm_btn').val(button_label);
    }else{
        $('#modal_confirm_btn').val('확인');
    }

    $('#modal_confirm').modal();
}

function open_modal_confirm2(text="", focus_text="", button_label=""){
	
	if(focus_text == "" && text == ""){
        $('#modal_confirm_body2').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_confirm_body2').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_confirm_body2').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }
	
	if(button_label !== ""){
        $('#modal_confirm_btn2').val(button_label);
    }else{
        $('#modal_confirm_btn2').val('확인');
    }

    $('#modal_confirm2').modal();
}

function open_modal_confirm3(text="", focus_text="", button_label=""){
	
	if(focus_text == "" && text == ""){
        $('#modal_confirm_body3').html(
            `<p><span class="text-danger">Error<br></span>오류가 발생했습니다.<br>잠시후 다시 시도해주세요</p>`
        );
    }else if(focus_text == ""){
        $('#modal_confirm_body3').html(
            `<p>${text}</p>`
        );
    }else{
        $('#modal_confirm_body3').html(
            `<p><span class="text-danger">${focus_text}</span><br>${text}</p>`
        );
    }
	
	if(button_label !== ""){
        $('#modal_confirm_btn3').val(button_label);
    }else{
        $('#modal_confirm_btn3').val('확인');
    }

    $('#modal_confirm3').modal();
}



$(window).bind("pageshow", function(event) {
	
	$('#modal_reload').on('hidden.bs.modal', function () {
	    location.reload();
	});
	
	$('#modal_go').on('hidden.bs.modal', function () {
	    if(open_modal_go_url == ""){
	        location.href = './index.php';
	        return;
	    }
	    location.href = open_modal_go_url;
	});
	
	$('#modal_replace').on('hidden.bs.modal', function () {
	    if(open_modal_replace_url == ""){
	        location.replace('./index.php');
	        return;
	    }
	    location.replace(open_modal_replace_url);
	});
	
	$('#modal_term').on('show.bs.modal', function () {
		getTerm();
	});
	
	$('#modal_term2').on('show.bs.modal', function () {
		getTerm2();
	});
});

async function getTerm2(){
	try {
        let res = await awaitPost('./mngTerms.do', {ttType: 1});   
		if(res.result == 'success'){
			display_term2(res);
		}else{
			open_modal_alert();
		}
    } catch (error) {
    	open_modal_alert();
    }
}

function display_term2(data){
	try {
		$("#modal_term_body2").html(data.ttContent);
    } catch (error) {
		open_modal_alert();
    }
}

async function getTerm(){
	try {
        let res = await awaitPost('./mngTerms.do', {ttType: 2});   
		if(res.result == 'success'){
			display_term(res);
		}else{
			open_modal_alert();
		}
    } catch (error) {
    	open_modal_alert();
    }
}

function display_term(data){
	try {
		$("#modal_term_body").html(data.ttContent);
    } catch (error) {
		open_modal_alert();
    }
}