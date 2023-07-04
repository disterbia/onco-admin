package net.huray.onco.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import net.huray.onco.domain.Member;
import net.huray.onco.repository.MemberRepository;


@Component
public class ScheduledService {
	
	private final MemberRepository memberRepository;
	
	public ScheduledService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	//탈퇴 7일뒤 마스킹 처리
	@Scheduled(cron = "0 0 0 * * 0") //매주 일요일 0시 0분 실행
//	@Scheduled(cron = "0 0/1 * * * *") //1분 간격 실행 (테스트)
    public void shceduled01() {
		
		//-14일 ~ -7일자에 탈퇴한 회원 리스트
		Calendar calendar = Calendar.getInstance();

		calendar.add(Calendar.DAY_OF_YEAR, -14); // 14일 전
		Date from = calendar.getTime();

		calendar.add(Calendar.DAY_OF_YEAR, 7); // 7일 전 (현재로부터 7일 전)
		Date to = calendar.getTime();
		
		
        List<Member> members = memberRepository.findAllByMtLevelAndMtTypeAndMtRdateBetween(10, 1, from, to);
        
        for (Member member : members) {
        	member.setMtId(maskId(member.getMtId()));
        	member.setMtName(maskName(member.getMtName()));
        	member.setMtHp(maskHp(member.getMtHp()));
        	member.setMtEmail(maskEmail(member.getMtEmail()));
        	member.setMtBirth(null);
        	member.setMtAddr(maskAddr(member.getMtAddr()));
        	member.setMtAddrDetail(null);
			memberRepository.save(member);
		}
    }
	
	//아이디 마스킹
	private String maskId(String id) {
		String maskedId = "";
		for(int i = 0; i < id.length(); i++) {
			maskedId += "*";
		}
		return maskedId;
	}
	
	// 이름 마스킹
	private String maskName(String name) {
        if (name == null || name.length() < 2) {
            return name;
        }
        String lastName = name.substring(0, name.length() - 2);
        String maskedName = lastName + "**";
        return maskedName;
    }
	// 휴대폰번호 마스킹
	private String maskHp(String hp) {
        if (hp == null || hp.length() < 4) {
            return hp;
        }
        String lastFourDigits = hp.substring(hp.length() - 4);
        String maskedHp = "***-****-" + lastFourDigits;
        return maskedHp;
    }
	// 이메일 마스킹
	private String maskEmail(String email) {
        if (email == null || email.length() == 0) {
            return email;
        }
        int atIndex = email.indexOf('@');
        if (atIndex == -1) {
            return email;
        }
        String maskedEmail = "********" + email.substring(atIndex);
        return maskedEmail;
    }
	
	// 주소 마스킹
	private static String maskAddr(String addr) {
		String[] splitArr = addr.split(" ");
		String maskedAddr = "";
		if(splitArr.length == 1) {
			maskedAddr = splitArr[0] + " *****";
		}else if(splitArr.length > 1) {
			maskedAddr = splitArr[0] + " " + splitArr[1] + " *****";
		}else {
			maskedAddr = "*****";
		}
		return maskedAddr;
	}
}
