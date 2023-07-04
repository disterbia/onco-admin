package net.huray.onco.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.CustomSessionRegistry;
import net.huray.onco.domain.Content;
import net.huray.onco.domain.Diagnosis;
import net.huray.onco.domain.Faq;
import net.huray.onco.domain.File;
import net.huray.onco.domain.Gene;
import net.huray.onco.domain.Keyword;
import net.huray.onco.domain.Member;
import net.huray.onco.domain.Notice;
import net.huray.onco.domain.Qna;
import net.huray.onco.domain.Terms;
import net.huray.onco.repository.AdminActions;
import net.huray.onco.repository.ContentRepository;
import net.huray.onco.repository.ContentSpecification2;
import net.huray.onco.repository.DiagnosisRepository;
import net.huray.onco.repository.FaqRepository;
import net.huray.onco.repository.FaqSpecification;
import net.huray.onco.repository.GeneRepository;
import net.huray.onco.repository.KeywordRepository;
import net.huray.onco.repository.MemberRepository;
import net.huray.onco.repository.MemberSpecification;
import net.huray.onco.repository.NoticeRepository;
import net.huray.onco.repository.NoticeSpecification;
import net.huray.onco.repository.QnaRepository;
import net.huray.onco.repository.QnaSpecification;
import net.huray.onco.repository.TermsRepository;
import net.huray.onco.repository.TermsSpecification;

@Slf4j
@Service

public class MngService {

	@Autowired
	PageLogic pageLogic;

	@Autowired
	MemberSpecification memberSpecification;
	
	@Autowired
	NoticeSpecification noticeSpecification;
	
	@Autowired
	FaqSpecification faqSpecification;
	
	@Autowired
	QnaSpecification qnaSpecification;
	
	@Autowired
	ContentSpecification2 contentSpecification2;
	
	@Autowired
	TermsSpecification termsSpecification;
	
	@Autowired
	FileService fileService;
	
	@Autowired
	ExcelService excelService;

	private final MemberRepository memberRepository;
	
	private final DiagnosisRepository diagnosisRepository;
	
	private final NoticeRepository noticeRepository;
	
	private final FaqRepository faqRepository;
	
	private final QnaRepository qnaRepository;
	
	private final ContentRepository contentRepository;
	
	private final GeneRepository geneRepository;
	
	private final KeywordRepository keywordRepository;
	
	private final TermsRepository termsRepository;

	public MngService(MemberRepository memberRepository, DiagnosisRepository diagnosisRepository, NoticeRepository noticeRepository, FaqRepository faqRepository, QnaRepository qnaRepository, ContentRepository contentRepository, GeneRepository geneRepository, KeywordRepository keywordRepository, TermsRepository termsRepository) {
		this.memberRepository = memberRepository;
		this.diagnosisRepository = diagnosisRepository;
		this.noticeRepository = noticeRepository;
		this.faqRepository = faqRepository;
		this.qnaRepository = qnaRepository;
		this.contentRepository = contentRepository;
		this.geneRepository = geneRepository;
		this.keywordRepository = keywordRepository;
		this.termsRepository = termsRepository;
	}

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private CustomSessionRegistry customSessionRegistry;
	

	// 로그인 업데이트
	public HashMap<String, Object> mngLoginUpdateDo(@Valid Member member, BindingResult bindingResult,
			HttpServletRequest request, Model model) {

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", "error");

		String mt_id = member.getMtId();
		String mt_pass = member.getMtPwd();

		member = memberRepository.findByMtIdAndMtTypeAndMtLevelNot(mt_id, 10, 10);

		if (member != null) {

			if (passwordEncoder.matches(mt_pass, member.getMtPwd())) {
				
				customSessionRegistry.setMember(member, request);
				
				//로그인 일시
				member.setMtLdate(new Date());
				memberRepository.save(member);

				returnMap.put("result", "success");
			} else {
				returnMap.put("result", "fail");
			}
		} else {
			returnMap.put("result", "error");
		}
		return returnMap;
	}

	//관리자 목록
	public void mngAdminList(HttpServletRequest request, Model model) {

		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);

		// 관리자
		map.put("mtLevelNot", 10);
		map.put("mtType", 10);

		// 쿼리호출
		Page<Member> result = memberRepository.findAll(memberSpecification.setSpecs(map),
				PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));

		// 회원정보입력
		model.addAttribute("members", result.getContent());

		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	//관리자 상세
	public void mngAdminDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Member member = memberRepository.findOneByIdxAndMtType(idx, 10);
		
		// 회원정보입력
		model.addAttribute("member", member);
	}
	
	//사용자 상세
	public void mngMemberDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Member member = memberRepository.findOneByIdxAndMtType(idx, 1);
		
		// 회원정보입력
		model.addAttribute("member", member);
		model.addAttribute("diagnoisList", diagnosisRepository.findAll());
	}
	
	//연구 회원 상세
	public void mngMemberDetail2(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Member member = memberRepository.findOneByIdxAndMtType(idx, 2);
		
		// 회원정보입력
		model.addAttribute("member", member);
		model.addAttribute("diagnoisList", diagnosisRepository.findAll());
	}
	
	//사용자 폼
	public void mngMemberForm(HttpServletRequest request, Model model) {
		model.addAttribute("diagnoisList", diagnosisRepository.findAll());
	}
	
	
	//사용자 목록
	public void mngMemberList(HttpServletRequest request, Model model) {

		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);

		// 사용자
//		map.put("mtLevelNot", 10);
		map.put("mtType", 1);

		// 쿼리호출
		Page<Member> result = memberRepository.findAll(memberSpecification.setSpecs(map),
				PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));

		// 회원정보입력
		model.addAttribute("members", result.getContent());

		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
		
		// 선택된회원 정보
		HttpSession session = request.getSession();
		List<Integer> list = (ArrayList<Integer>)session.getAttribute("memberSelectedList"); 
		model.addAttribute("memberSelectedList", list);
		model.addAttribute("memberSelectedListCnt", list == null ? 0 : list.isEmpty() ? 0 : list.size());
	}
	
	//연구 사용자 목록
	public void mngMemberList2(HttpServletRequest request, Model model) {

		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);

		// 사용자
//		map.put("mtLevelNot", 10);
		map.put("mtType", 2);

		// 쿼리호출
		Page<Member> result = memberRepository.findAll(memberSpecification.setSpecs(map),
				PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));

		// 회원정보입력
		model.addAttribute("members", result.getContent());

		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
		
		// 선택된회원 정보
		HttpSession session = request.getSession();
		List<Integer> list = (ArrayList<Integer>)session.getAttribute("memberSelectedList"); 
		model.addAttribute("memberSelectedList", list);
		model.addAttribute("memberSelectedListCnt", list == null ? 0 : list.isEmpty() ? 0 : list.size());
	}

	// 관리자 업데이트
	public HashMap<String, Object> mngAdminUpdateDo(@Valid Member member, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		log.debug(action);

		switch (action) {
		// 아이디 중복 확인
		case AdminActions.ACTION_CHECK_ID:
			map = checkMemberId(member, map);
			break;
		// 아이디 중복 확인2
		case AdminActions.ACTION_CHECK_ID2:
			map = checkMemberId2(member, map);
			break;
		// 휴대폰 중복 확인
		case AdminActions.ACTION_CHECK_HP:
			map = checkMemberHp(member, map);
			break;
		// 휴대폰 중복 확인2
		case AdminActions.ACTION_CHECK_HP2:
			map = checkMemberHp2(member, map);
			break;
		// 이메일 중복 확인
		case AdminActions.ACTION_CHECK_EMAIL:
			map = checkMemberEmail(member, map);
			break;
		// 이메일 중복 확인2
		case AdminActions.ACTION_CHECK_EMAIL2:
			map = checkMemberEmail2(member, map);
			break;
		// 회원 등록
		case AdminActions.ACTION_INSERT_MEMBER:
			map = insertMember(member, map);
			break;
		// 회원 등록
		case AdminActions.ACTION_INSERT_MEMBER2:
			map = insertMember2(member, map);
			break;
		// 관리자 등록
		case AdminActions.ACTION_INSERT_ADMIN:
			map = insertAdmin(member, map);
			break;
		// 관리자 수정
		case AdminActions.ACTION_UPDATE_ADMIN:
			map = updateAdmin(member, map);
			break;
		// 관리자 삭제
		case AdminActions.ACTION_DELETE_ADMIN:
			map = deleteAdmin(member, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	// 사용자 업데이트
	public HashMap<String, Object> mngMemberUpdateDo(@Valid Member member, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		log.debug(action);

		switch (action) {
		// 아이디 중복 확인
		case AdminActions.ACTION_CHECK_ID:
			map = checkMemberId(member, map);
			break;
		// 아이디 중복 확인2
		case AdminActions.ACTION_CHECK_ID2:
			map = checkMemberId2(member, map);
			break;
		// 휴대폰 중복 확인
		case AdminActions.ACTION_CHECK_HP:
			map = checkMemberHp(member, map);
			break;
		// 휴대폰 중복 확인2
		case AdminActions.ACTION_CHECK_HP2:
			map = checkMemberHp2(member, map);
			break;
		// 이메일 중복 확인
		case AdminActions.ACTION_CHECK_EMAIL:
			map = checkMemberEmail(member, map);
			break;
		// 이메일 중복 확인2
		case AdminActions.ACTION_CHECK_EMAIL2:
			map = checkMemberEmail2(member, map);
			break;
		// 회원 등록
		case AdminActions.ACTION_INSERT_MEMBER:
			map = insertMember(member, map);
			break;
		// 연구 회원 등록
		case AdminActions.ACTION_INSERT_MEMBER2:
			map = insertMember2(member, map);
			break;
		// 회원 수정
		case AdminActions.ACTION_UPDATE_MEMBER:
			map = updateMember(member, map);
			break;
		// 연구 회원 등록
		case AdminActions.ACTION_UPDATE_MEMBER2:
			map = updateMember2(member, map);
			break;
		// 회원 삭제
		case AdminActions.ACTION_RETIRE_MEMBER:
			map = retireMember(member, map);
			break;
		default:
			break;
		}
		return map;
	}


	// 중복아이디 확인
	private HashMap<String, Object> checkMemberId(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_id = memberRepository.countByMtIdAndMtLevelNot(member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberId Error: " + e);
			return map;
		}
	}
	
	// 중복아이디 확인 - 본인 제외
	private HashMap<String, Object> checkMemberId2(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_id = memberRepository.countByIdxNotAndMtIdAndMtLevelNot(member.getIdx(), member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberId Error: " + e);
			return map;
		}
	}

	// 중복휴대폰 확인
	private HashMap<String, Object> checkMemberHp(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_hp = memberRepository.countByMtHpAndMtLevelNot(member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberId Error: " + e);
			return map;
		}
	}

	// 중복휴대폰 확인 - 본인 제외
	private HashMap<String, Object> checkMemberHp2(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_hp = memberRepository.countByIdxNotAndMtHpAndMtLevelNot(member.getIdx(), member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberHp2 Error: " + e);
			return map;
		}
	}

	// 중복이메일 확인
	private HashMap<String, Object> checkMemberEmail(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_email = memberRepository.countByMtEmailAndMtLevelNot(member.getMtEmail(), 10);
			if (duplicate_email > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 이메일입니다");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberEmail Error: " + e);
			return map;
		}
	}

	// 중복이메일 확인 - 본인 제외
	private HashMap<String, Object> checkMemberEmail2(Member member, HashMap<String, Object> map) {
		try {
			long duplicate_email = memberRepository.countByIdxNotAndMtEmailAndMtLevelNot(member.getIdx(), member.getMtEmail(), 10);
			if (duplicate_email > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 이메일입니다.");
				return map;
			} else {
				map.put("result", "success");
			}
			return map;
		} catch (Exception e) {
			log.error("checkMemberEmail2 Error: " + e);
			return map;
		}
	}

	// 관리자 생성
	private HashMap<String, Object> insertAdmin(Member member, HashMap<String, Object> map) {
		try {
			//관리자 레벨 부여
			member.setMtType(10);
			//패스워드 암호화
			member.setMtPwd(passwordEncoder.encode(member.getMtPwd()));
			//가입일 추가
			member.setMtWdate(new Date());

			long duplicate_id = memberRepository.countByMtIdAndMtLevelNot(member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}
			
			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByMtEmailAndMtLevelNot(member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByMtHpAndMtLevelNot(member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}

			int idx = memberRepository.save(member).getIdx();

			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertAdmin Error: " + e);
			return map;
		}
	}
	
	// 관리자 수정
	private HashMap<String, Object> updateAdmin(Member member, HashMap<String, Object> map) {
		try {

			long duplicate_id = memberRepository.countByIdxNotAndMtIdAndMtLevelNot(member.getIdx(), member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}

			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByIdxNotAndMtHpAndMtLevelNot(member.getIdx(), member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByIdxNotAndMtEmailAndMtLevelNot(member.getIdx(), member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}
			
			
			Member member2 = memberRepository.findOneByIdxAndMtLevelNot(member.getIdx(), 10);
			
			//이름
			member2.setMtName(member.getMtName());
			
			//ID
			member2.setMtId(member.getMtId());
			
			//HP
			member2.setMtHp(member.getMtHp());
			
			//Email
			member2.setMtEmail(member.getMtEmail());
			
			//Birth
			member2.setMtBirth(member.getMtBirth());
			
			//Level
			member2.setMtLevel(member.getMtLevel());
			
			//Group
			member2.setMtGroup(member.getMtGroup());
			
			//Grant
			member2.setMtGrant(member.getMtGrant());
			
			//Password
			if(member.getMtPwd() != null) {
				member2.setMtPwd(passwordEncoder.encode(member.getMtPwd()));
			}
			
			//수정일 추가
			member2.setMtEdate(new Date());

			int idx = memberRepository.save(member2).getIdx();
			
			
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateAdmin Error: " + e);
			return map;
		}
	}
	
	// 관리자 삭제
	private HashMap<String, Object> deleteAdmin(Member member, HashMap<String, Object> map) {
		try {
			
			Member member2 = memberRepository.findOneByIdxAndMtLevelNot(member.getIdx(), 10);
			//Level
			member2.setMtLevel(10);
			//삭제일 추가
			member2.setMtRdate(new Date());

			int idx = memberRepository.save(member2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteAdmin Error: " + e);
			return map;
		}
	}

	
	// 회원 생성
	private HashMap<String, Object> insertMember(Member member, HashMap<String, Object> map) {
		try {
			
			//사용자 레벨 부여
			member.setMtType(1);
			//패스워드 암호화
			member.setMtPwd(passwordEncoder.encode(member.getMtPwd()));
			//가입일 추가
			member.setMtWdate(new Date());
			
			if(member.getMtDiagnosis() == 2) {
				member.setMtDiagnosisCode(0);
				member.setMtDiagnosisDate(null);
				member.setMtDiagnosisName(null);
				member.setMtHospital(null);
			}

			long duplicate_id = memberRepository.countByMtIdAndMtLevelNot(member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}

			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByMtEmailAndMtLevelNot(member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByMtHpAndMtLevelNot(member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}

			int idx = memberRepository.save(member).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertMember Error: " + e);
			return map;
		}
	}
	
	// 연구 회원 생성
	private HashMap<String, Object> insertMember2(Member member, HashMap<String, Object> map) {
		try {
			
			//사용자 레벨 부여
			member.setMtType(2);
			
			//가입일 추가
			member.setMtWdate(new Date());
			
			if(member.getMtDiagnosis() == 2) {
				member.setMtDiagnosisCode(0);
				member.setMtDiagnosisDate(null);
				member.setMtDiagnosisName(null);
				member.setMtHospital(null);
				member.setMtDoctor(null);
			}

			long duplicate_id = memberRepository.countByMtIdAndMtLevelNot(member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}

			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByMtEmailAndMtLevelNot(member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByMtHpAndMtLevelNot(member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}

			int idx = memberRepository.save(member).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertMember2 Error: " + e);
			return map;
		}
	}

	// 회원 수정
	private HashMap<String, Object> updateMember(Member member, HashMap<String, Object> map) {
		try {

			long duplicate_id = memberRepository.countByIdxNotAndMtIdAndMtLevelNot(member.getIdx(), member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}

			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByIdxNotAndMtHpAndMtLevelNot(member.getIdx(), member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByIdxNotAndMtEmailAndMtLevelNot(member.getIdx(), member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}
			
			
			Member member2 = memberRepository.findOneByIdxAndMtLevelNot(member.getIdx(), 10);
			
			//이름
			member2.setMtName(member.getMtName());
			
			//성별
			member2.setMtGender(member.getMtGender());
			
			//ID
			member2.setMtId(member.getMtId());
			
			//HP
			member2.setMtHp(member.getMtHp());
			
			//Email
			member2.setMtEmail(member.getMtEmail());
			
			//Birth
			member2.setMtBirth(member.getMtBirth());
			
			//Level
			member2.setMtLevel(member.getMtLevel());
			
			//Address
			member2.setMtAddr(member.getMtAddr());
			
			//Address Detail
			member2.setMtAddrDetail(member.getMtAddrDetail());
			
			//Password
			if(member.getMtPwd() != null) {
				member2.setMtPwd(passwordEncoder.encode(member.getMtPwd()));
			}
			
			//수정일 추가
			member2.setMtEdate(new Date());
			
			//확진정보 추가
			//확진
			if(member.getMtDiagnosis() == 1) {
				member2.setMtDiagnosis(1);
				member2.setMtDiagnosisCode(member.getMtDiagnosis());
				member2.setMtDiagnosisDate(member.getMtDiagnosisDate());
				member2.setMtDiagnosisName(member.getMtDiagnosisName());
				member2.setMtHospital(member.getMtHospital());
			}
			//미확진
			else if(member.getMtDiagnosis() == 2) {
				member2.setMtDiagnosis(2);
				member2.setMtDiagnosisCode(0);
				member2.setMtDiagnosisDate(null);
				member2.setMtDiagnosisName(null);
				member2.setMtHospital(null);
			}
			
			
			

			int idx = memberRepository.save(member2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateMember Error: " + e);
			return map;
		}
	}
	
	// 연구 회원 수정
	private HashMap<String, Object> updateMember2(Member member, HashMap<String, Object> map) {
		try {

			long duplicate_id = memberRepository.countByIdxNotAndMtIdAndMtLevelNot(member.getIdx(), member.getMtId(), 10);
			if (duplicate_id > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 아이디입니다.");
				return map;
			}

			if(!member.getMtEmail().equals("")) {
				long duplicate_email = memberRepository.countByIdxNotAndMtHpAndMtLevelNot(member.getIdx(), member.getMtEmail(), 10);
				if (duplicate_email > 0) {
					map.put("error_code", "error");
					map.put("error_detail", "이미 사용중인 이메일입니다");
					return map;
				}
			}

			long duplicate_hp = memberRepository.countByIdxNotAndMtEmailAndMtLevelNot(member.getIdx(), member.getMtHp(), 10);
			if (duplicate_hp > 0) {
				map.put("error_code", "error");
				map.put("error_detail", "이미 사용중인 휴대폰 번호입니다.");
				return map;
			}
			
			
			Member member2 = memberRepository.findOneByIdxAndMtLevelNot(member.getIdx(), 10);
			
			//이름
			member2.setMtName(member.getMtName());
			
			//성별
			member2.setMtGender(member.getMtGender());
			
			//병록번호
			member2.setMtHospitalId(member.getMtHospitalId());
			
			//ID
			member2.setMtId(member.getMtId());
			
			//HP
			member2.setMtHp(member.getMtHp());
			
			//Email
			member2.setMtEmail(member.getMtEmail());
			
			//Birth
			member2.setMtBirth(member.getMtBirth());
			
			//Level
			member2.setMtLevel(member.getMtLevel());
			
			//AgreeDate
			member2.setMtAgreeDate(member.getMtAgreeDate());
			
			//Memo
			member2.setMtMemo(member.getMtMemo());		
			
			//수정일 추가
			member2.setMtEdate(new Date());
			
			//Address
			member2.setMtAddr(member.getMtAddr());
			
			//Address Detail
			member2.setMtAddrDetail(member.getMtAddrDetail());
			
			//확진정보 추가
			//확진
			if(member.getMtDiagnosis() == 1) {
				member2.setMtDiagnosis(1);
				member2.setMtDiagnosisCode(member.getMtDiagnosis());
				member2.setMtDiagnosisDate(member.getMtDiagnosisDate());
				member2.setMtDiagnosisName(member.getMtDiagnosisName());
				member2.setMtHospital(member.getMtHospital());
				member2.setMtDoctor(member.getMtDoctor());
			}
			//미확진
			else if(member.getMtDiagnosis() == 2) {
				member2.setMtDiagnosis(2);
				member2.setMtDiagnosisCode(0);
				member2.setMtDiagnosisDate(null);
				member2.setMtDiagnosisName(null);
				member2.setMtHospital(null);
			}

			int idx = memberRepository.save(member2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateMember Error: " + e);
			return map;
		}
	}
	
	// 회원 탈퇴
	private HashMap<String, Object> retireMember(Member member, HashMap<String, Object> map) {
		try {
			
			Member member2 = memberRepository.findOneByIdxAndMtLevelNot(member.getIdx(), 10);
			//Level
			member2.setMtLevel(10);
			//삭제일 추가
			member2.setMtRdate(new Date());

			int idx = memberRepository.save(member2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteAdmin Error: " + e);
			return map;
		}
	}
	
	//공지사항 목록
	public void mngNoticeList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		map.put("ntLevelNot", 10);
		
		// 쿼리호출
		Page<Notice> result = noticeRepository.findAll(noticeSpecification.setSpecs(map), PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("notices", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	
	//공지 업데이트
	public HashMap<String, Object> mngNoticeUpdateDo(@Valid Notice notice, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// 공지등록
		case AdminActions.ACTION_INSERT_NOTICE:
			map = insertNotice(notice, map);
			break;
		// 공지수정
		case AdminActions.ACTION_UPDATE_NOTICE:
			map = updateNotice(notice, map);
			break;
		// 공지삭제
		case AdminActions.ACTION_DELETE_NOTICE:
			map = deleteNotice(notice, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	//공지 등록
	private HashMap<String, Object> insertNotice(@Valid Notice notice, HashMap<String, Object> map) {
		try {
			notice.setNtWdate(new Date());

			int idx = noticeRepository.save(notice).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertNotice Error: " + e);
			return map;
		}
	}
	
	//공지 상세
	public void mngNoticeDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Notice notice = noticeRepository.findOneByIdxAndNtLevelNot(idx, 10);
		
		// 공지 정보 저장
		model.addAttribute("notice", notice);
	}

	//공지 수정
	private HashMap<String, Object> updateNotice(@Valid Notice notice, HashMap<String, Object> map) {
		try {
			
			Notice notice2 = noticeRepository.findOneByIdxAndNtLevelNot(notice.getIdx(), 10);
			
			notice2.setNtTitle(notice.getNtTitle());
			notice2.setNtLevel(notice.getNtLevel());
			notice2.setNtContent(notice.getNtContent());
			notice2.setNtEdate(new Date());

			int idx = noticeRepository.save(notice2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateNotice Error: " + e);
			return map;
		}
	}

	//공지 삭제
	private HashMap<String, Object> deleteNotice(@Valid Notice notice, HashMap<String, Object> map) {
		try {
			
			Notice notice2 = noticeRepository.findOneByIdxAndNtLevelNot(notice.getIdx(), 10);

			notice2.setNtLevel(10);
			notice2.setNtRdate(new Date());

			int idx = noticeRepository.save(notice2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteNotice Error: " + e);
			return map;
		}
	}
	
	//FAQ 목록
	public void mngFaqList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();
	
		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		map.put("ftLevelNot", 10);
		
		// 쿼리호출
		Page<Faq> result = faqRepository.findAll(faqSpecification.setSpecs(map), PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("faqs", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	//FAQ 업데이트
	public HashMap<String, Object> mngFaqUpdateDo(@Valid Faq faq, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// FAQ 등록
		case AdminActions.ACTION_INSERT_FAQ:
			map = insertFaq(faq, map);
			break;
		// FAQ 수정
		case AdminActions.ACTION_UPDATE_FAQ:
			map = updateFaq(faq, map);
			break;
		// FAQ 삭제
		case AdminActions.ACTION_DELETE_FAQ:
			map = deleteFaq(faq, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	//FAQ 등록
	private HashMap<String, Object> insertFaq(@Valid Faq faq, HashMap<String, Object> map) {
		try {
			faq.setFtWdate(new Date());

			int idx = faqRepository.save(faq).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertFaq Error: " + e);
			return map;
		}
	}
	
	//FAQ 상세
	public void mngFaqDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Faq faq = faqRepository.findOneByIdxAndFtLevelNot(idx, 10);
		
		// 공지 정보 저장
		model.addAttribute(faq);
	}

	//FAQ 수정
	private HashMap<String, Object> updateFaq(@Valid Faq faq, HashMap<String, Object> map) {
		try {
			
			Faq faq2 = faqRepository.findOneByIdxAndFtLevelNot(faq.getIdx(), 10);
			
			faq2.setFtTitle(faq.getFtTitle());
			faq2.setFtLevel(faq.getFtLevel());
			faq2.setFtContent(faq.getFtContent());
			faq2.setFtEdate(new Date());

			int idx = faqRepository.save(faq2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateFaq Error: " + e);
			return map;
		}
	}

	//FAQ 삭제
	private HashMap<String, Object> deleteFaq(@Valid Faq faq, HashMap<String, Object> map) {
		try {
			
			Faq faq2 = faqRepository.findOneByIdxAndFtLevelNot(faq.getIdx(), 10);

			faq2.setFtLevel(10);
			faq2.setFtRdate(new Date());

			int idx = faqRepository.save(faq2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteFaq Error: " + e);
			return map;
		}
	}
	
	//QNA 목록
	public void mngQnaList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();
	
		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		map.put("qtLevelNot", 10);
		
		// 쿼리호출
		Page<Qna> result = qnaRepository.findAll(qnaSpecification.setSpecs(map), PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("qnas", result.getContent());
		
		model.addAttribute("qnasTotal", qnaRepository.countByQtLevelNot(10));
		
		model.addAttribute("qnas1", qnaRepository.countByQtTypeAndQtLevelNot(1, 10));
		
		model.addAttribute("qnas2", qnaRepository.countByQtTypeAndQtLevelNot(2, 10));
		
		model.addAttribute("qnas3", qnaRepository.countByQtTypeAndQtLevelNot(3, 10));
		
		model.addAttribute("qnas4", qnaRepository.countByQtTypeAndQtLevelNot(4, 10));
		
		model.addAttribute("qnas5", qnaRepository.countByQtTypeAndQtLevelNot(5, 10));
		
		model.addAttribute("qnas6", qnaRepository.countByQtLevel(1));
		
		model.addAttribute("qnas7", qnaRepository.countByQtLevel(2));
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	//QNA 업데이트
	public HashMap<String, Object> mngQnaUpdateDo(@Valid Qna qna, String action, ArrayList<MultipartFile> files, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// FAQ 등록
		case AdminActions.ACTION_INSERT_QNA:
			map = insertQna(qna, files, map);
			break;
		// FAQ 수정
		case AdminActions.ACTION_UPDATE_QNA:
			map = updateQna(qna, map);
			break;
		// FAQ 삭제
		case AdminActions.ACTION_DELETE_QNA:
			map = deleteQna(qna, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	//QNA 등록
	private HashMap<String, Object> insertQna(@Valid Qna qna, ArrayList<MultipartFile> files, HashMap<String, Object> map) {
		try {
			qna.setQtWdate(new Date());

			int idx = qnaRepository.save(qna).getIdx();
			
			if(files != null) {
				fileService.save("qna", idx, files);
			}
			
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertQna Error: " + e);
			return map;
		}
	}
	
	//QNA 상세
	public void mngQnaDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Qna qna = qnaRepository.findOneByIdxAndQtLevelNot(idx, 10);
		
		// 데이터
		model.addAttribute("qna", qna);
		model.addAttribute("fileList", fileService.findAll("qna", (long)idx));
	}

	//QNA 답변등록
	private HashMap<String, Object> updateQna(@Valid Qna qna, HashMap<String, Object> map) {
		try {
			
			Qna qna2 = qnaRepository.findOneByIdxAndQtLevelNot(qna.getIdx(), 10);
			
			qna2.setQtLevel(2);
			qna2.setQtEdate(new Date());
			qna2.setQtAnswer(qna.getQtAnswer());
			qna2.setQtAdate(new Date());

			int idx = qnaRepository.save(qna2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateQna Error: " + e);
			return map;
		}
	}

	//QNA 삭제
	private HashMap<String, Object> deleteQna(@Valid Qna qna, HashMap<String, Object> map) {
		try {
			
			Qna qna2 = qnaRepository.findOneByIdxAndQtLevelNot(qna.getIdx(), 10);

			qna2.setQtLevel(10);
			qna2.setQtRdate(new Date());

			int idx = qnaRepository.save(qna2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteQna Error: " + e);
			return map;
		}
	}
	
	//컨텐츠 목록
	public void mngContentList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();
	
		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		map.put("ctLevelNot", 10);
		
		// 쿼리호출
		Page<Content> result = contentRepository.findAll(contentSpecification2.setSpecs(map), PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		log.debug(result.getTotalPages() + ", " + result.getTotalElements());
		
		// 데이터
		model.addAttribute("diagnoisList", diagnosisRepository.findAllByDtLevelNot(10));
		model.addAttribute("geneList", geneRepository.findAllByGtLevelNot(10));
		model.addAttribute("contents", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
		
	}
	
	//컨텐츠 폼
	public void mngContentForm(HttpServletRequest request, Model model) {
		// 데이터
		model.addAttribute("diagnoisList", diagnosisRepository.findAllByDtLevelNot(10));
		model.addAttribute("geneList", geneRepository.findAllByGtLevelNot(10));
	}
	
	//컨텐츠 상세
	public void mngContentDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		// 데이터
		model.addAttribute("diagnoisList", diagnosisRepository.findAllByDtLevelNot(10));
		model.addAttribute("geneList", geneRepository.findAllByGtLevelNot(10));
		model.addAttribute("content", contentRepository.findOneByIdxAndCtLevelNot(idx,10));
		model.addAttribute("keywordList", keywordRepository.findAllByCtIdxAndKtLevelNot(idx,10));
		model.addAttribute("fileList", fileService.findAll("content", (long)idx));
		// TODO Auto-generated method stub
		
	}
	
	//컨텐츠 업데이트
	public HashMap<String, Object> mngContentUpdateDo(Content content, ArrayList<String> keywordList, String action, ArrayList<MultipartFile> files, BindingResult bindingResult, HttpServletRequest request, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", "error");

		switch (action) {
		// 컨텐츠 등록
		case AdminActions.ACTION_INSERT_CONTENT:
			map = insertContent(content, keywordList, files, map);
			break;
		// 컨텐츠 수정
		case AdminActions.ACTION_UPDATE_CONTENT:
			map = updateContent(content, keywordList, files, map);
			break;
		// 컨텐츠 삭제
		case AdminActions.ACTION_DELETE_CONTENT:
			map = deleteContent(content, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	//컨텐츠 등록
	private HashMap<String, Object> insertContent(Content content, ArrayList<String> keywordList, ArrayList<MultipartFile> files, HashMap<String, Object> map) {
		try {
			content.setCtWdate(new Date());

			int idx = contentRepository.save(content).getIdx();
			
			if(files != null) {
				fileService.save("content", idx, files);
				
				File file = fileService.findAll("content", (long)idx).get(0);
				content.setCtThumbnail(file.getFtUuid());
				contentRepository.save(content);
			}
			
			if(keywordList != null) {
				for(String word : keywordList) {
					Keyword keyword = Keyword.builder().ctIdx(idx).ktLevel(1).ktWord(word).build();
					keywordRepository.save(keyword); 
				}
			}
			
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertContent Error: " + e);
			return map;
		}
	}
	
	//컨텐츠 삭제
	private HashMap<String, Object> deleteContent(Content content, HashMap<String, Object> map) {
		try {
			Content content2 = contentRepository.findOneByIdxAndCtLevelNot(content.getIdx(), 10);
			//Level
			content2.setCtLevel(10);
			//삭제일 추가
			content2.setCtRdate(new Date());

			int idx = contentRepository.save(content2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteContent Error: " + e);
			return map;
		}
	}
	
	//컨텐츠 수정
	private HashMap<String, Object> updateContent(Content content, ArrayList<String> keywordList, ArrayList<MultipartFile> files, HashMap<String, Object> map) {
		try {
			
			Content content2 = contentRepository.findOneByIdxAndCtLevelNot(content.getIdx(), 10);
			
			content2.setDtIdx(content.getDtIdx());
			content2.setGtIdx(content.getGtIdx());
			content2.setCtLevel(content.getCtLevel());
			content2.setCtCategory(content.getCtCategory());
			content2.setCtTitle(content.getCtTitle());
			content2.setCtContent(content.getCtContent());
			content2.setCtUrl(content.getCtUrl());
			content2.setCtEdate(new Date());

			int idx = contentRepository.save(content2).getIdx();
			
			
			if(files != null) {
				//기존 파일 논리 삭제
				fileService.delete("content", idx);
				//신규 파일 생성
				fileService.save("content", idx, files);
				
				File file = fileService.findAll("content", (long)idx).get(0);
				content2.setCtThumbnail(file.getFtUuid());
				contentRepository.save(content2);
			}
			
			//키워드 등록
			if(keywordList != null) {
				//기존 키워드 모두 삭제
				keywordRepository.deleteAllByCtIdx(idx);
				
				for(String word : keywordList) {
					Keyword keyword = Keyword.builder().ctIdx(idx).ktLevel(1).ktWord(word).build();
					keywordRepository.save(keyword); 
				}	
			}
			
			map.put("idx", idx);
			map.put("result", "success");
			return map;

		} catch (Exception e) {
			log.error("updateContent Error: " + e);
			return map;
		}
	}
	
	
	//약관 목록
	public void mngTermsList(HttpServletRequest request, Model model, int ttType) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		map.put("ttLevelNot", 10);
		
		map.put("ttType", ttType);
		
		// 쿼리호출
		Page<Terms> result = termsRepository.findAll(termsSpecification.setSpecs(map), PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("termsList", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	
	//약관, 개인정보처리방침 업데이트
	public HashMap<String, Object> mngTermsUpdateDo(@Valid Terms terms, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// 약관등록
		case AdminActions.ACTION_INSERT_TERMS:
			map = insertTerms(terms, map);
			break;
		// 약관수정
		case AdminActions.ACTION_UPDATE_TERMS:
			map = updateTerms(terms, map);
			break;
		// 약관삭제
		case AdminActions.ACTION_DELETE_TERMS:
			map = deleteTerms(terms, map);
			break;
		default:
			break;
		}
		return map;
	}
	
	//약관, 개인정보처리방침 등록
	private HashMap<String, Object> insertTerms(@Valid Terms terms, HashMap<String, Object> map) {
		try {
			terms.setTtWdate(new Date());

			int idx = termsRepository.save(terms).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertTerms Error: " + e);
			return map;
		}
	}
	
	//약관, 개인정보처리방침 상세
	public void mngTermsDetail(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt((String)request.getParameter("idx"));
		
		Terms terms = termsRepository.findOneByIdxAndTtLevelNot(idx, 10);
		
		// 공지 정보 저장
		model.addAttribute("terms", terms);
	}

	//약관, 개인정보처리방침 업데이트
	private HashMap<String, Object> updateTerms(@Valid Terms terms, HashMap<String, Object> map) {
		try {
			
			Terms terms2 = termsRepository.findOneByIdxAndTtLevelNot(terms.getIdx(), 10);
			
			terms2.setTtTitle(terms.getTtTitle());
			terms2.setTtLevel(terms.getTtLevel());
			terms2.setTtContent(terms.getTtContent());
			terms2.setTtEdate(new Date());

			int idx = termsRepository.save(terms2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateTerms Error: " + e);
			return map;
		}
	}

	//약관 삭제
	private HashMap<String, Object> deleteTerms(@Valid Terms terms, HashMap<String, Object> map) {
		try {
			
			Terms terms2 = termsRepository.findOneByIdxAndTtLevelNot(terms.getIdx(), 10);

			terms2.setTtLevel(10);
			terms2.setTtRdate(new Date());

			int idx = termsRepository.save(terms2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteTerms Error: " + e);
			return map;
		}
	}
	
	//변이정보 목록
	public void mngGeneList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		if(!map.containsKey("search_value")) {
			map.put("search_value", "");
		}
		
		// 쿼리호출
		Page<Gene> result = geneRepository.findAllByGtLevelNotAndGtNameContains(10, (String)map.get("search_value") , PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("genes", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	//변이정보 업데이트
	public HashMap<String, Object> mngGeneUpdateDo(@Valid Gene gene, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// 변이정보 등록
		case AdminActions.ACTION_INSERT_GENE:
			map = insertGene(gene, map);
			break;
		// 변이정보 수정
		case AdminActions.ACTION_UPDATE_GENE:
			map = updateGene(gene, map);
			break;
		// 변이정보 삭제
		case AdminActions.ACTION_DELETE_GENE:
			map = deleteGene(gene, map);
			break;
		// 변이정보 중복확인
		case AdminActions.ACTION_CHECK_GENE:
			map = checkGene(gene, map);
			break;
		default:
			break;
		}
		return map;
	}

	//변이정보 등록
	private HashMap<String, Object> insertGene(@Valid Gene gene, HashMap<String, Object> map) {
		try {
			long cnt = geneRepository.countByGtNameAndGtLevelNot(gene.getGtName(), 10);
			if(cnt > 0) {
				map.put("error_code", "duplicate");
				map.put("error_detail", "이미 존재하는 변이정보입니다.");
				return map;
			}
			
			gene.setGtLevel(1);
			gene.setGtWdate(new Date());

			int idx = geneRepository.save(gene).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertGene Error: " + e);
			return map;
		}
	} 
	
	//변이정보 수정
	private HashMap<String, Object> updateGene(@Valid Gene gene, HashMap<String, Object> map) {
		try {
			long cnt = geneRepository.countByIdxNotAndGtNameAndGtLevelNot(gene.getIdx(), gene.getGtName(), 10);
			
			if(cnt > 0) {
				map.put("error_code", "duplicate");
				map.put("error_detail", "이미 존재하는 변이정보입니다.");
				return map;
			}
			
			Gene gene2 = geneRepository.findByIdxAndGtLevelNot(gene.getIdx(), 10);
			gene2.setGtEdate(new Date());
			gene2.setGtName(gene.getGtName());

			int idx = geneRepository.save(gene2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateGene Error: " + e);
			return map;
		}
	} 
	
	//변이정보 삭제
	private HashMap<String, Object> deleteGene(@Valid Gene gene, HashMap<String, Object> map) {
		try {
			Gene gene2 = geneRepository.findByIdxAndGtLevelNot(gene.getIdx(), 10);
			gene2.setGtRdate(new Date());
			gene2.setGtLevel(10);

			int idx = geneRepository.save(gene2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteGene Error: " + e);
			return map;
		}
	} 

	//변이정보 중복확인
	private HashMap<String, Object> checkGene(@Valid Gene gene, HashMap<String, Object> map) {
		try {
			long cnt = geneRepository.countByGtNameAndGtLevelNot(gene.getGtName(), 10);
			if(cnt > 0) {
				return map;
			}
			map.put("result", "success");
			return map;

		} catch (Exception e) {
			log.error("chceckGene Error: " + e);
			return map;
		}
	} 
	
	
	
	//암종정보 목록
	public void mngDiagnosisList(HttpServletRequest request, Model model) {
		// mapper에서 사용할 검색 파라미터 객체 선언
		Map<String, Object> map = new HashMap<String, Object>();

		// 페이징, 로우갯수, 검색값 입력
		map = pageLogic.getParameters(request, map);
		
		if(!map.containsKey("search_value")) {
			map.put("search_value", "");
		}
		
		// 쿼리호출
		Page<Diagnosis> result = diagnosisRepository.findAllByDtLevelNotAndDtNameContains(10, (String)map.get("search_value") , PageRequest.of(Integer.parseInt((String) map.get("pg")) - 1, 10, Sort.Direction.DESC, "idx"));
		
		// 데이터
		model.addAttribute("diagnosisList", result.getContent());
		
		// 페이지정보
		model.addAttribute("page", pageLogic.setParameters(map, result));
	}
	
	//암종정보 업데이트
	public HashMap<String, Object> mngDiagnosisUpdateDo(@Valid Diagnosis diagnosis, String action, BindingResult bindingResult,
			HttpServletRequest request, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");

		switch (action) {
		// 암종정보 등록
		case AdminActions.ACTION_INSERT_DIAGNOSIS:
			map = insertDiagnosis(diagnosis, map);
			break;
		// 암종정보 수정
		case AdminActions.ACTION_UPDATE_DIAGNOSIS:
			map = updateDiagnosis(diagnosis, map);
			break;
		// 암종정보 삭제
		case AdminActions.ACTION_DELETE_DIAGNOSIS:
			map = deleteDiagnosis(diagnosis, map);
			break;
		// 암종정보 중복확인
		case AdminActions.ACTION_CHECK_DIAGNOSIS:
			map = checkDiagnosis(diagnosis, map);
			break;
		default:
			break;
		}
		return map;
	}

	//암종정보 등록
	private HashMap<String, Object> insertDiagnosis(@Valid Diagnosis diagnosis, HashMap<String, Object> map) {
		try {
			long cnt = diagnosisRepository.countByDtNameAndDtLevelNot(diagnosis.getDtName(), 10);
			if(cnt > 0) {
				map.put("error_code", "duplicate");
				map.put("error_detail", "이미 존재하는 암종정보입니다.");
				return map;
			}
			
			diagnosis.setDtLevel(1);
			diagnosis.setDtWdate(new Date());

			int idx = diagnosisRepository.save(diagnosis).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("insertDiagnosis Error: " + e);
			return map;
		}
	} 
	
	//암종정보 수정
	private HashMap<String, Object> updateDiagnosis(@Valid Diagnosis diagnosis, HashMap<String, Object> map) {
		try {
			long cnt = diagnosisRepository.countByIdxNotAndDtNameAndDtLevelNot(diagnosis.getIdx(), diagnosis.getDtName(), 10);
			
			if(cnt > 0) {
				map.put("error_code", "duplicate");
				map.put("error_detail", "이미 존재하는 암종정보입니다.");
				return map;
			}
			
			Diagnosis diagnosis2 = diagnosisRepository.findByIdxAndDtLevelNot(diagnosis.getIdx(), 10);
			diagnosis2.setDtEdate(new Date());
			diagnosis2.setDtName(diagnosis.getDtName());

			int idx = diagnosisRepository.save(diagnosis2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("updateDiagnosis Error: " + e);
			return map;
		}
	} 
	
	//암종정보 삭제
	private HashMap<String, Object> deleteDiagnosis(@Valid Diagnosis diagnosis, HashMap<String, Object> map) {
		try {
			Diagnosis diagnosis2 = diagnosisRepository.findByIdxAndDtLevelNot(diagnosis.getIdx(), 10);
			diagnosis2.setDtRdate(new Date());
			diagnosis2.setDtLevel(10);

			int idx = diagnosisRepository.save(diagnosis2).getIdx();
			map.put("idx", idx);
			map.put("result", "success");

			return map;

		} catch (Exception e) {
			log.error("deleteDiagnosis Error: " + e);
			return map;
		}
	} 

	//암종정보 중복확인
	private HashMap<String, Object> checkDiagnosis(@Valid Diagnosis diagnosis, HashMap<String, Object> map) {
		try {
			long cnt = diagnosisRepository.countByDtNameAndDtLevelNot(diagnosis.getDtName(), 10);
			if(cnt > 0) {
				return map;
			}
			map.put("result", "success");
			return map;

		} catch (Exception e) {
			log.error("checkDiagnosis Error: " + e);
			return map;
		}
	} 
	
	//다운로드
	public void mngDownloadDo(String fileName, HttpServletRequest request, HttpServletResponse response, Model model) {

		try {
			fileService.s3Downlaod(response, fileName);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//에디터 이미지 업로드
	public String mngUploadDo(MultipartFile multipartFile) {
		return fileService.saveOne("editor", 0, multipartFile);
	}
	
	//업로드 파일 논리 삭제
	public void mngDeleteDo(String ftRefCode, int ftRefIdx) {
		fileService.delete(ftRefCode, ftRefIdx);
	}
	
	//논리 삭제 파일 물리 삭제
	public void mngDeleteS3Do() {
		fileService.s3Delete();
	}
	
	//약관 다운로드
	public HashMap<String, Object> mngTermsDo(@Valid Terms terms, HttpServletRequest request, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");
		terms = termsRepository.findTop1ByTtTypeAndTtLevelNotOrderByIdxDesc(terms.getTtType(), 10);
		if(terms != null) {
			map.put("result", "success");
			map.put("ttContent", terms.getTtContent());
			map.put("ttTitle", terms.getTtTitle());
		}
		return map;
	}
	
	//엑셀 다운로드
	public ResponseEntity<Object> mngExcelDo(HttpServletRequest request) {
		List<Member> memberList = excelService.getMemberSelectedList(request);
		return excelService.memberList(memberList);
	}
	
	//엑셀 선택
	public HashMap<String, Object> mngExcelSelectDo(ArrayList<Integer> selectList, String action, HttpServletRequest request, Model model) {
		return excelService.mngExcelSelectDo(selectList, action, request, model);
	}
}