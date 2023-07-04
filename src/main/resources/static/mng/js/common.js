//시작일, 종료일
var sdate, edate, sdate2, edate2;

$(document).ready(function(){
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //Date picker
    
     //시작일1
     sdate = $( "#datepicker" ).datepicker({
    	 changeYear: true,
         changeMonth: true,
         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         showButtonPanel: true,
         currentText: '오늘',
         closeText: '닫기',
         dateFormat: "yy.mm.dd",
         nextText: '다음 달',
         prevText: '이전 달'
     }).on( "change", function() {
       edate.datepicker( "option", "minDate", getDate( this ) );
     });
    
     //종료일1
     edate = $( "#datepicker2" ).datepicker({
		 changeYear: true,
         changeMonth: true,
         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         showButtonPanel: true,
         currentText: '오늘',
         closeText: '닫기',
         dateFormat: "yy.mm.dd",
         nextText: '다음 달',
         prevText: '이전 달'
     }).on( "change", function() {
       sdate.datepicker( "option", "maxDate", getDate( this ) );
     });
    
     //시작일2
     sdate2 = $( "#datepicker3" ).datepicker({
		 changeYear: true,
         changeMonth: true,
         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         showButtonPanel: true,
         currentText: '오늘',
         closeText: '닫기',
         dateFormat: "yy.mm.dd",
         nextText: '다음 달',
         prevText: '이전 달'
     }).on( "change", function() {
       edate2.datepicker( "option", "minDate", getDate( this ) );
     });
    
     //종료일2
     edate2 = $( "#datepicker4" ).datepicker({
		 changeYear: true,
         changeMonth: true,
         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         showButtonPanel: true,
         currentText: '오늘',
         closeText: '닫기',
         dateFormat: "yy.mm.dd",
         nextText: '다음 달',
         prevText: '이전 달'
     }).on( "change", function() {
       sdate2.datepicker( "option", "maxDate", getDate( this ) );
     });

    //날짜 가져오기
    function getDate( element ) {
     var dateFormat = "yy.mm.dd";
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
      return date;
    }

    //오늘 날짜 클릭이벤트
    $(document).on('click', "button.ui-datepicker-current", function() {
        $.datepicker._curInst.input.datepicker('setDate', new Date())   
    });
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //사이드 드롭다운    
    $('.main_lnb_title').on('click',function(){
        if($(this).parent().children().hasClass("sub_lnb")){
           $(this).parent().toggleClass("on");
        }
      });
    //탭 클릭 이벤트
    $(".tab_style1 li").click(function() {
        var idx = $(this).index();
        $(".tab_style1 > li").removeClass("on");
        $(".tab_style1 > li").eq(idx).addClass("on");
        $(".tab_style1_contents > ul").hide();
        $(".tab_style1_contents > ul").eq(idx).show();
    });

    //버튼 셀렉트
    $(".btn_select .btn").on('click',function(){
        $(".btn_select .btn").removeClass('on');
        $(this).addClass('on');
        
    });

    //버튼 셀렉트2
    $(".btn_select2 .btn").on('click',function(){
        $(".btn_select2 .btn").removeClass('on');
        $(this).addClass('on');
    });

    //알림 이벤트
    $(".btn_bell").on("click",function(){
        $(".noti_wrap").toggleClass("on");
    });
    $(".close_noti").on('click',function(){
        $(".noti_wrap").removeClass("on");
    });
     
    $(".btn_hamburger").on("click",function(){
        $(".side_menu").addClass("on");
    });
    $(".mobile_side_close").on("click",function(){
        $(".side_menu").removeClass("on");
    });

    //처음 로딩되었을때 textarea 높이
    var textareaHeight = $(".chat_input_body textarea.form-control").innerHeight();

    //textarea 값변경시 마다 발생되는 이벤트
    $(".chat_input_body textarea.form-control").bind('propertychange change keyup paste input',function(key){                

        //Lines Array
        let lines = $(".chat_input_body textarea.form-control").val().split(/\r|\r\n|\n/);

        if(lines.length > 2){
            $(this).css({
                'height':textareaHeight + ((lines.length-2) * 10)
            });
        }else{
            $(this).css({
                'height':'auto'
            });          
        }
    });

    //메세지 원문 접기
    $(".pre_message_folding").on('click',function(){
        $(this).toggleClass('on');
        if($(this).hasClass('on') == true){
            $(this).children(".pre_message_text").text('원문 접기');
        }else{
            $(this).children(".pre_message_text").text('원문 펼치기');
        }
    });
});

