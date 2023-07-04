package net.huray.onco.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Content;
import net.huray.onco.domain.Diagnosis;
import net.huray.onco.domain.Faq;
import net.huray.onco.domain.Gene;
import net.huray.onco.domain.Keyword;
import net.huray.onco.domain.Member;
import net.huray.onco.domain.Notice;
import net.huray.onco.domain.Qna;
import net.huray.onco.domain.Terms;
import net.huray.onco.service.MngService;

@Controller
@Order(Ordered.HIGHEST_PRECEDENCE)
@Slf4j
public class MngController {
	
	@Autowired
	MngService mngService;
	
	public String getRoot(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			Member user = (Member)session.getAttribute("session_member");
			if(user == null) {
				return "redirect:/mng/login";
			}else if(user.getMtGrant() == 0) {
				return "redirect:/main";
			}else if(user.getMtGrant() == 1) {
				return "redirect:/mng/adminList";
			}else if(user.getMtGrant() == 2) {
				return "redirect:/mng/memberList2";
			}else {
				return "/mng/login";
			}
		} catch (Exception e) {
			return "/mng/login";
		}
	}
	
	
	@GetMapping("/mng")
    public String mng(HttpServletRequest request) {
    	log.info("/mng");
    	return getRoot(request);
    }
	
    @GetMapping("/mng/")
    public String mng2(HttpServletRequest request) {
    	log.info("/mng/");
    	return getRoot(request);
    }
    
    @GetMapping("/mng/index")
    public String mngIndex(HttpServletRequest request, Model model) {
    	log.info("/mng/index");
    	return getRoot(request);
    }
    
    @GetMapping("/mng/login")
    public String mngLogin() {
    	log.info("/mng/login");
        return "/mng/login";
    }
    
    //로그인
  	@PostMapping("/mng/loginUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngLoginUpdateDo(@Valid @ModelAttribute Member Member, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/loginUpdate.do");
          return mngService.mngLoginUpdateDo(Member, bindingResult, request, model);
  	}
  	
  	//로그아웃
  	@GetMapping("/mng/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		log.debug("/mng/logout");
		HttpSession session= request.getSession(false);
		SecurityContextHolder.clearContext();
        if(session != null) {
            session.invalidate();
        }
		new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
        return "redirect:/mng/login";
    }
    
  	//관리자 목록
    @GetMapping("/mng/adminList")
    public String mngAdminList(HttpServletRequest request, Model model) {
    	log.info("/mng/adminList");
    	mngService.mngAdminList(request, model);
        return "/mng/adminList";
    }
    
    //관리자 등록 화면
    @GetMapping("/mng/adminForm")
    public String mngAdminForm() {
    	log.info("/mng/adminForm");
        return "/mng/adminForm";
    }
    
    //관리자 상세 화면
    @GetMapping("/mng/adminDetail")
    public String mngAdminDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/adminDetail");
    	mngService.mngAdminDetail(request, model);
        return "/mng/adminDetail";
    }
    
    //관리자 업데이트
  	@PostMapping("/mng/adminUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngAdminUpdateDo(@Valid @ModelAttribute Member member, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/adminUpdate.do");
          return mngService.mngAdminUpdateDo(member, action, bindingResult, request, model);
  	}
    
  	//사용자 목록
    @GetMapping("/mng/memberList")
    public String mngMemberList(HttpServletRequest request, Model model) {
    	log.info("/mng/memberList");
    	mngService.mngMemberList(request, model);
        return "/mng/memberList";
    }
    
    //연구 회원 목록
    @GetMapping("/mng/memberList2")
    public String mngMemberList2(HttpServletRequest request, Model model) {
    	log.info("/mng/memberList2");
    	mngService.mngMemberList2(request, model);
        return "/mng/memberList2";
    }
    
    //사용자 등록 화면
    @GetMapping("/mng/memberForm")
    public String mngMemberForm(HttpServletRequest request, Model model) {
    	log.info("/mng/memberForm");
    	mngService.mngMemberForm(request, model);
        return "/mng/memberForm";
    }
    
    //연구 회원 등록 화면
    @GetMapping("/mng/memberForm2")
    public String mngMemberForm2(HttpServletRequest request, Model model) {
    	log.info("/mng/memberForm2");
    	mngService.mngMemberForm(request, model);
        return "/mng/memberForm2";
    }
    
    //사용자 상세 화면
    @GetMapping("/mng/memberDetail")
    public String mngMemberDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/memberDetail");
    	mngService.mngMemberDetail(request, model);
        return "/mng/memberDetail";
    }
    
    //연구 회원 상세 화면
    @GetMapping("/mng/memberDetail2")
    public String mngMemberDetail2(HttpServletRequest request, Model model) {
    	log.info("/mng/memberDetail2");
    	mngService.mngMemberDetail2(request, model);
        return "/mng/memberDetail2";
    }
    
    //탈퇴 사용자 상세 화면
    @GetMapping("/mng/memberRetireDetail")
    public String mngMemberRetireDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/memberDetail");
    	mngService.mngMemberDetail(request, model);
        return "/mng/memberRetireDetail";
    }
    
    //사용자 업데이트
  	@PostMapping("/mng/memberUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngMemberUpdateDo(@Valid @ModelAttribute Member member, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/memberUpdate.do");
          return mngService.mngMemberUpdateDo(member, action, bindingResult, request, model);
  	}
    
    //공지 목록
    @GetMapping("/mng/noticeList")
    public String mngNoticeList(HttpServletRequest request, Model model) {
    	log.info("/mng/noticeList");
    	mngService.mngNoticeList(request, model);
        return "/mng/noticeList";
    }
    
    //공지 등록 화면
    @GetMapping("/mng/noticeForm")
    public String mngNoticeForm() {
    	log.info("/mng/noticeForm");
        return "/mng/noticeForm";
    }
    
    //공지 상세 화면
    @GetMapping("/mng/noticeDetail")
    public String mngNoticeDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/noticeDetail");
    	mngService.mngNoticeDetail(request, model);
        return "/mng/noticeDetail";
    }
    
    //공지 관리 화면
    @GetMapping("/mng/noticeEdit")
    public String mngNoticeEdit(HttpServletRequest request, Model model) {
    	log.info("/mng/noticeEdit");
    	mngService.mngNoticeDetail(request, model);
        return "/mng/noticeEdit";
    }
    
    //공지 업데이트
  	@PostMapping("/mng/noticeUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngNoticeUpdateDo(@Valid @ModelAttribute Notice notice, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/memberUpdate.do");
          return mngService.mngNoticeUpdateDo(notice, action, bindingResult, request, model);
  	}
  	
  	//FAQ 목록
    @GetMapping("/mng/faqList")
    public String mngFaqList(HttpServletRequest request, Model model) {
    	log.info("/mng/faqList");
    	mngService.mngFaqList(request, model);
        return "/mng/faqList";
    }
    
    //FAQ 등록 화면
    @GetMapping("/mng/faqForm")
    public String mngFaqForm() {
    	log.info("/mng/faqForm");
        return "/mng/faqForm";
    }
    
    //FAQ 상세 화면
    @GetMapping("/mng/faqDetail")
    public String mngFaqDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/faqDetail");
    	mngService.mngFaqDetail(request, model);
        return "/mng/faqDetail";
    }
    
    //FAQ 관리 화면
    @GetMapping("/mng/faqEdit")
    public String mngFaqEdit(HttpServletRequest request, Model model) {
    	log.info("/mng/faqEdit");
    	mngService.mngFaqDetail(request, model);
        return "/mng/faqEdit";
    }
    
    //FAQ 업데이트
  	@PostMapping("/mng/faqUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngFaqUpdateDo(@Valid @ModelAttribute Faq faq, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/faqUpdate.do");
          return mngService.mngFaqUpdateDo(faq, action, bindingResult, request, model);
  	}
  	
  	
  	//QNA 목록
    @GetMapping("/mng/qnaList")
    public String mngQnaList(HttpServletRequest request, Model model) {
    	log.info("/mng/qnaList");
    	mngService.mngQnaList(request, model);
        return "/mng/qnaList";
    }
    
    //QNA 등록 화면
    @GetMapping("/mng/qnaForm")
    public String mngQnaForm() {
    	log.info("/mng/qnaForm");
        return "/mng/qnaForm";
    }
    
    //QNA 상세 화면
    @GetMapping("/mng/qnaDetail")
    public String mngQnaDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/qnaDetail");
    	mngService.mngQnaDetail(request, model);
        return "/mng/qnaDetail";
    }
    
    //QNA 관리 화면
    @GetMapping("/mng/qnaEdit")
    public String mngQnaEdit(HttpServletRequest request, Model model) {
    	log.info("/mng/qnaEdit");
    	mngService.mngQnaDetail(request, model);
        return "/mng/qnaEdit";
    }
    
    //QNA 업데이트
  	@PostMapping("/mng/qnaUpdate.do")
  	@ResponseBody
    public HashMap<String, Object> mngQnaUpdateDo(
    		  @ModelAttribute Qna qna, 
    		  @RequestParam(value="action") String action,
    		  @RequestPart(value="files", required = false) ArrayList<MultipartFile> files,
    		  BindingResult bindingResult, HttpServletRequest request, Model model) {
			log.debug("/mng/qnaUpdate.do");
  		
          return mngService.mngQnaUpdateDo(qna, action, files, bindingResult, request, model);
  	}
  	
  	//컨텐츠 목록
    @GetMapping("/mng/contentList")
    public String mngContentList(HttpServletRequest request, Model model) {
    	log.info("/mng/contentList");
    	mngService.mngContentList(request, model);
        return "/mng/contentList";
    }
    
    //컨텐츠 등록 화면
    @GetMapping("/mng/contentForm")
    public String mngContentForm(HttpServletRequest request, Model model) {
    	log.info("/mng/contentForm");
    	mngService.mngContentForm(request, model);
        return "/mng/contentForm";
    }
    
    //컨텐츠 상세 화면
    @GetMapping("/mng/contentDetail")
    public String mngContentDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/contentDetail");
    	mngService.mngContentDetail(request, model);
        return "/mng/contentDetail";
    }
    
    //컨텐츠 관리 화면
    @GetMapping("/mng/contentEdit")
    public String mngContentEdit(HttpServletRequest request, Model model) {
    	log.info("/mng/contentEdit");
    	mngService.mngContentDetail(request, model);
        return "/mng/contentEdit";
    }
    
    //컨텐츠 업데이트
  	@PostMapping("/mng/contentUpdate.do")
  	@ResponseBody
    public HashMap<String, Object> mngContentUpdateDo(
    		  @ModelAttribute Content content, 
    		  @RequestParam(value="keywordList", required = false) ArrayList<String> keywordList,
    		  @RequestParam(value="action") String action,
    		  @RequestPart(value="files", required = false) ArrayList<MultipartFile> files,
    		  BindingResult bindingResult, HttpServletRequest request, Model model) {
			log.debug("/mng/contentUpdate.do");
		
          return mngService.mngContentUpdateDo(content, keywordList, action, files, bindingResult, request, model);
  	}
  	
  	
    //회원약관 목록
    @GetMapping("/mng/termsList")
    public String mngTermsList(HttpServletRequest request, Model model) {
    	log.info("/mng/termsList");
    	mngService.mngTermsList(request, model, 1);
        return "/mng/termsList";
    }
    
    //개인정보처리방침 목록
    @GetMapping("/mng/termsList2")
    public String mngTermsList2(HttpServletRequest request, Model model) {
    	log.info("/mng/termsList2");
    	mngService.mngTermsList(request, model, 2);
        return "/mng/termsList2";
    }
    
    //회원약관, 개인정보처리방침 등록 화면
    @GetMapping("/mng/termsForm")
    public String mngTermsForm() {
    	log.info("/mng/termsForm");
        return "/mng/termsForm";
    }
    
    //회원약관, 개인정보처리방침 상세 화면
    @GetMapping("/mng/termsDetail")
    public String mngTermsDetail(HttpServletRequest request, Model model) {
    	log.info("/mng/termsDetail");
    	mngService.mngTermsDetail(request, model);
        return "/mng/termsDetail";
    }
    
    //회원약관, 개인정보처리방침 관리 화면
    @GetMapping("/mng/termsEdit")
    public String mngTermsEdit(HttpServletRequest request, Model model) {
    	log.info("/mng/termsEdit");
    	mngService.mngTermsDetail(request, model);
        return "/mng/termsEdit";
    }
    
    //회원약관 업데이트
  	@PostMapping("/mng/termsUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngTermsUpdateDo(@Valid @ModelAttribute Terms terms, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/termsUpdate.do");
          return mngService.mngTermsUpdateDo(terms, action, bindingResult, request, model);
  	}
  	
  	//변이정보 목록
    @GetMapping("/mng/geneList")
    public String mngGeneList(HttpServletRequest request, Model model) {
    	log.info("/mng/geneList");
    	mngService.mngGeneList(request, model);
        return "/mng/geneList";
    }
    
    //변이정보 업데이트
  	@PostMapping("/mng/geneUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngGeneUpdateDo(@Valid @ModelAttribute Gene gene, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/geneUpdate.do");
          return mngService.mngGeneUpdateDo(gene, action, bindingResult, request, model);
  	}
  	
  	//암종정보 목록
    @GetMapping("/mng/diagnosisList")
    public String mngDiagnosisList(HttpServletRequest request, Model model) {
    	log.info("/mng/diagnosisList");
    	mngService.mngDiagnosisList(request, model);
        return "/mng/diagnosisList";
    }
    
    //암종정보 업데이트
  	@PostMapping("/mng/diagnosisUpdate.do")
  	@ResponseBody
      public HashMap<String, Object> mngDiagnosisUpdateDo(@Valid @ModelAttribute Diagnosis diagnosis, @RequestParam(value="action") String action, BindingResult bindingResult, HttpServletRequest request, Model model) {
  		log.debug("/mng/diagnosisUpdate.do");
          return mngService.mngDiagnosisUpdateDo(diagnosis, action, bindingResult, request, model);
  	}
  	

  	//파일 가져오기
  	@GetMapping("/mng/download/{fileName}")
    public void mngDownloadDo(@PathVariable("fileName") String fileName, HttpServletRequest request, HttpServletResponse response,  Model model) {
		log.debug("/mng/download/");
		mngService.mngDownloadDo(fileName, request, response, model);
  	}
  	
  	//에디터 파일 업로드
  	@PostMapping("/mng/upload")
  	@ResponseBody
    public String mngContentUpdateDo(@RequestPart(value="file", required = false) MultipartFile multipartFile) {
		log.debug("/mng/upload");
        return mngService.mngUploadDo(multipartFile);
  	}
  	
  	//에디터 파일 모달창
  	@GetMapping("/mng/Photo_Quick_UploadPopup")
    public String Photo_Quick_UploadPopup() {
    	log.info("/mng/Photo_Quick_UploadPopup");
        return "/mng/Photo_Quick_UploadPopup";
    }
  	
  	//파일 논리 삭제
  	@GetMapping("/mng/delete/{ftRefCode}/{ftRefIdx}")
    public void mngDeleteDo(@PathVariable("ftRefCode") String ftRefCode, @PathVariable("ftRefIdx") int ftRefIdx) {
		log.debug("/mng/delete/");
		mngService.mngDeleteDo(ftRefCode, ftRefIdx);
  	}
  	
  	//논리 삭제 파일 물리 삭제 
  	@GetMapping("/mng/delete/s3")
    public void mngDeleteS3Do() {
		log.debug("/mng/delete/s3");
		mngService.mngDeleteS3Do();
  	}
  	
  	//회원약관, 개인정보처리방침 불러오기
    @PostMapping("/mng/mngTerms.do")
  	@ResponseBody
    public HashMap<String, Object> mngTermsDo(@Valid @ModelAttribute Terms terms, HttpServletRequest request, Model model) {
    	log.info("/mng/mngTerms.do");
    	return mngService.mngTermsDo(terms, request, model);
    }
    
    //회원정보 엑셀다운로드
    @RequestMapping(value="/mng/excel.do", method=RequestMethod.GET)
    public ResponseEntity<Object> mngExcelDo(HttpServletRequest request) {
    	log.debug("/mng/excel.do");
    	return mngService.mngExcelDo(request);
    }
    
    //회원정보 선택리스트 업데이트
  	@PostMapping("/mng/excelSelect.do")
  	@ResponseBody
    public HashMap<String, Object> mngExCelSelectDo(@RequestParam(value="selectList[]", required = false) ArrayList<Integer> selectList, @RequestParam(value="action") String action, HttpServletRequest request, Model model) {
			log.debug("/mng/mngExCelSelectDo.do");
			return mngService.mngExcelSelectDo(selectList, action, request, model);
  	}
}
