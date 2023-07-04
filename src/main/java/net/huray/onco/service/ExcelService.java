package net.huray.onco.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Diagnosis;
import net.huray.onco.domain.Member;
import net.huray.onco.repository.DiagnosisRepository;
import net.huray.onco.repository.MemberRepository;

//엑셀 다운로드
@Service
@Slf4j
public class ExcelService {
	
	private final DiagnosisRepository diagnosisRepository;
	private final MemberRepository memberRepository;
	
	
	public ExcelService(DiagnosisRepository diagnosisRepository, MemberRepository memberRepository) {
		this.diagnosisRepository = diagnosisRepository;
		this.memberRepository = memberRepository;
	}
	
    public ResponseEntity<Object> memberList(List<Member> list) {
    	
    	if(list == null || list.isEmpty()) {
    		return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body("해당 파일을 찾을 수 없습니다.");
    	}

        try {
        	
        	List<Diagnosis> diagnosisList = diagnosisRepository.findAll();
        	
        	
        	XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("회원정보");
            
            int order = 0; int row = 0;
            Row header = sheet.createRow(row);
            header = createCell(header, order, "회원유형"); order++;
            header = createCell(header, order, "회원상태"); order++;
            header = createCell(header, order, "성명"); order++;
            header = createCell(header, order, "소속"); order++;
            header = createCell(header, order, "성별"); order++;
            header = createCell(header, order, "아이디(서비스ID)"); order++;
            header = createCell(header, order, "휴대폰"); order++;
            header = createCell(header, order, "이메일"); order++;
            header = createCell(header, order, "생년월일"); order++;
            header = createCell(header, order, "주소"); order++;
            header = createCell(header, order, "상세주소"); order++;
            header = createCell(header, order, "진단여부"); order++;
            header = createCell(header, order, "진단명"); order++;
            header = createCell(header, order, "병원명"); order++;
            header = createCell(header, order, "담담의"); order++;
            header = createCell(header, order, "병록번호"); order++;
            header = createCell(header, order, "동의서취득일자"); order++;
            header = createCell(header, order, "비고"); order++;
            header = createCell(header, order, "가입(등록)일시"); order++;
            header = createCell(header, order, "마지막수정일시"); order++;
            header = createCell(header, order, "탈퇴일시"); order++;
            header = createCell(header, order, "탈퇴사유");
            sheet.autoSizeColumn(row);
            sheet.setColumnWidth(row, (sheet.getColumnWidth(row)) + 512);
            row++;
            
            for (Member member : list) {
                Row dataRow = sheet.createRow(row); order = 0;
                dataRow = createCell(dataRow, order, mtType(member.getMtType(), member.getMtType())); order++;
                dataRow = createCell(dataRow, order, mtLevel(member.getMtLevel())); order++;
                dataRow = createCell(dataRow, order, member.getMtName()); order++;
                dataRow = createCell(dataRow, order, member.getMtGroup()); order++;
                dataRow = createCell(dataRow, order, mtGender(member.getMtGender())); order++;
                dataRow = createCell(dataRow, order, member.getMtId()); order++;
                dataRow = createCell(dataRow, order, member.getMtHp()); order++;
                dataRow = createCell(dataRow, order, member.getMtEmail()); order++;
                dataRow = createCell(dataRow, order, dateOnly(member.getMtBirth())); order++;
                dataRow = createCell(dataRow, order, member.getMtAddr()); order++;
                dataRow = createCell(dataRow, order, member.getMtAddrDetail()); order++;
                dataRow = createCell(dataRow, order, mtDiagnosis(member.getMtDiagnosis())); order++;
                dataRow = createCell(dataRow, order, mtDiagnosisName(diagnosisList, member.getMtDiagnosisCode(), member.getMtDiagnosisName())); order++;
                dataRow = createCell(dataRow, order, member.getMtHospital()); order++;
                dataRow = createCell(dataRow, order, member.getMtDoctor()); order++;
                dataRow = createCell(dataRow, order, member.getMtHospitalId()); order++;
                dataRow = createCell(dataRow, order, dateOnly(member.getMtAgreeDate())); order++;
                dataRow = createCell(dataRow, order, member.getMtMemo()); order++;
                dataRow = createCell(dataRow, order, member.getMtWdate()); order++;
                dataRow = createCell(dataRow, order, member.getMtEdate()); order++;
                dataRow = createCell(dataRow, order, member.getMtRdate()); order++;
                dataRow = createCell(dataRow, order, member.getMtExitReason());
                sheet.autoSizeColumn(row);
                sheet.setColumnWidth(row, (sheet.getColumnWidth(row)) + 512);
                row++;
            }

            HttpHeaders headers = new HttpHeaders();

            LocalDateTime now = LocalDateTime.now();
            String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));

            headers.setContentDisposition(ContentDisposition.builder("attachment")
                    .filename("회원정보_" + formatedNow + ".xlsx", StandardCharsets.UTF_8).build());
            headers.add(HttpHeaders.CONTENT_TYPE, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            workbook.write(bos);
            byte[] barray = bos.toByteArray();
            InputStream is = new ByteArrayInputStream(barray);
            Resource resource = new InputStreamResource(is);

            return new ResponseEntity<Object>(resource, headers, HttpStatus.OK);

        } catch (Exception e) {
        	log.debug("memberList Error: " + e);
            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body("해당 파일을 찾을 수 없습니다.");
        }
    }
    
    
    
    //진단명
    private String mtDiagnosisName(List<Diagnosis> diagnosisList, int mtDiagnosisCode, String mtDiagnosisName) {
    	if(mtDiagnosisCode == 0) {
    		return mtDiagnosisName;
    	}else {
    		for (Diagnosis diagnosis : diagnosisList) {
				if(diagnosis.getIdx() == mtDiagnosisCode) {
					return diagnosis.getDtName();
				}
			}
    	}
    	return "";
    }
    
    //진단여부
    private String mtDiagnosis(int mtDiagnosis) {
    	if(mtDiagnosis == 1) {
    		return "확진";
    	}
    	return "미확진";
    }
    
    //회원유형
    private String mtType(int mtType, int mtGrant) {
    	if(mtType == 1) {
    		return "일반회원";
    	}else if(mtType == 2) {
    		return "연구회원";
    	}else if(mtType == 10) {
    		if(mtGrant == 1) {
    			return "전체관리자";
    		}else if(mtGrant == 2) {
    			return "연구관리자";
    		}
    	}
    	return "";
    }
    
    //회원상태
    private String mtLevel(int mtLevel) {
    	if(mtLevel == 1) {
    		return "정상";
    	}else if(mtLevel == 2) {
    		return "정지";
    	}else if(mtLevel == 10) {
    		return "탈퇴";
    	}
    	return "";
    }
    
    //성별
    private String mtGender(int mtGender) {
    	if(mtGender == 1) {
    		return "남성";
    	}if(mtGender == 2) {
    		return "여성";
    	}
    	return "";
    }
    
    //날짜만
    private String dateOnly(Date date) {
    	if(date == null) {
    		return "";
    	}
    	try {
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(date);
		} catch (Exception e) {
			return "";
		}
    }
    
    //Cell
    private Row createCell(Row row, int order, Object item) {
    	try {
    		row.createCell(order).setCellValue(item.toString());
		} catch (Exception e) {
			row.createCell(order).setCellValue("");
		}
    	return row;
    }
    
    //Excel 선택 저장
	public HashMap<String, Object> mngExcelSelectDo(ArrayList<Integer> selectList, String action, HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "error");
		
		//체크 명령
		if("select".equals(action)) {
			try {
				//저장되어있는 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				
				if(selectList == null) {
					selectList = new ArrayList<Integer>();
				}
				
				//기존 저장된 항목 확인
				if(!memberSelectedList.isEmpty()) {
					if(memberSelectedList.size() > 5000) {
						map.put("error_code", "선택 초과");
						map.put("error_detail", "최대 5,000개 까지 선택가능합니다.");
						return map;
					}
				}
				//추가로 요청한 항목 확인
				if(!selectList.isEmpty()) {
					if(selectList.size() + memberSelectedList.size() > 5000) {
						map.put("error_code", "선택 초과");
						map.put("error_detail", "최대 5,000개 까지 선택가능합니다.");
						return map;
					}
				}
				//최초 저장
				if(memberSelectedList.isEmpty() && !selectList.isEmpty()) {
					memberSelectedList = selectList;
				}
				//존재하는 목록에 저장
				else {
					memberSelectedList.addAll(selectList);
					HashSet<Integer> uniqueList = new HashSet<>(memberSelectedList);
					memberSelectedList = new ArrayList<>(uniqueList);
				}
				//세션에 선택된 목록 저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
				
			} catch (Exception e) {
				log.error(e+"");
				return map;
			}
			return map;
		}
		
		//체크 해제 명령
		else if("unselect".equals(action)) {
			try {
				
				//저장되어있는 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				if(selectList == null) {
					selectList = new ArrayList<Integer>();
				}
				
				//최초 저장
				if(memberSelectedList.isEmpty()) {
					map.put("error_code", "error");
					map.put("error_detail", "체크된 회원 목록이 존재하지 않습니다.");
					return map;
				}
				//존재하는 목록에서 제거
				else {
					memberSelectedList.removeAll(selectList);
				}
				
				//세션에 선택된 목록 저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
				
			} catch (Exception e) {
				return map;
			}
			return map;
		}
		
		//일반 회원 전체 선택
		else if("selectAll1".equals(action)) {
			try {
				//기존 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				//일반 회원 목록 모두 불러오기
				List<Integer> memberMtType1List = memberRepository.findAllByMtType(1);

				//중복제거
				memberSelectedList.addAll(memberMtType1List);
				HashSet<Integer> uniqueList = new HashSet<>(memberSelectedList);
				memberSelectedList = new ArrayList<>(uniqueList);
				
				//저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
			} catch (Exception e) {
				return map;
			}
			return map;
		}
		
		
		//연구 회원 전체 선택
		else if("selectAll2".equals(action)) {
			try {
				//기존 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				//연구 회원 목록 모두 불러오기
				List<Integer> memberMtType1List = memberRepository.findAllByMtType(2);

				//중복제거
				memberSelectedList.addAll(memberMtType1List);
				HashSet<Integer> uniqueList = new HashSet<>(memberSelectedList);
				memberSelectedList = new ArrayList<>(uniqueList);
				
				//저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
			} catch (Exception e) {
				return map;
			}
			return map;
		}
		
		//일반 회원 전체 선택 해제
		else if("unselectAll1".equals(action)) {
			try {
				//기존 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				//일반 회원 목록 모두 불러오기
				List<Integer> memberMtType1List = memberRepository.findAllByMtType(1);

				//중복제거
				memberSelectedList.removeAll(memberMtType1List);
				HashSet<Integer> uniqueList = new HashSet<>(memberSelectedList);
				memberSelectedList = new ArrayList<>(uniqueList);
				
				
				//저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
			} catch (Exception e) {
				return map;
			}
			return map;
		}
		
		//연구 회원 전체 선택 해제
		else if("unselectAll2".equals(action)) {
			try {
				//기존 선택된 회원 목록
				List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
				if(memberSelectedList == null) {
					memberSelectedList = new ArrayList<Integer>();
				}
				//일반 회원 목록 모두 불러오기
				List<Integer> memberMtType1List = memberRepository.findAllByMtType(2);

				//중복제거
				memberSelectedList.removeAll(memberMtType1List);
				HashSet<Integer> uniqueList = new HashSet<>(memberSelectedList);
				memberSelectedList = new ArrayList<>(uniqueList);
				
				
				//저장
				session.setAttribute("memberSelectedList", memberSelectedList);
				map.put("result", "success");
				map.put("total", memberSelectedList.isEmpty() ? 0 : memberSelectedList.size());
			} catch (Exception e) {
				return map;
			}
			return map;
		}
		
		else {
			return map;
		}
	}
	
	//저장된 IDX 리스트로 회원 정보를 가져온
	public List<Member> getMemberSelectedList(HttpServletRequest request){
		try {
			HttpSession session = request.getSession();
			List<Integer> memberSelectedList = (ArrayList<Integer>)session.getAttribute("memberSelectedList");
			if(memberSelectedList == null) {
				return null;
			}
			if(memberSelectedList.isEmpty()) {
				return null;
			}
			
			//접속자 권한 확인해서 연구 회원 관리자는 연구회원 리스트만 필터링 처리
			Member user = (Member)session.getAttribute("session_member");
			if(user == null) {
				return null;
			}else if(user.getMtGrant() == 0) {
				return null;
			}else if(user.getMtGrant() == 1) {
				return memberRepository.findAllByIdxIn(memberSelectedList);
			}else if(user.getMtGrant() == 2) {
				return memberRepository.findAllByIdxInAndMtType(memberSelectedList, 2);
			}else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}
}
