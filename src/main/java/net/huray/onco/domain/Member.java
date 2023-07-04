package net.huray.onco.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Comment;
import org.springframework.format.annotation.DateTimeFormat;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Schema(description = "회원 테이블")
@Entity(name = "member_t")
@Getter
@Setter
@NoArgsConstructor
@Builder 
@AllArgsConstructor
public class Member {

    @Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
    @Schema(description = "회원 id")
    @Column(name = "mt_id")
    private String mtId;
    
    @Schema(description = "진단병원")
    @Column(name = "mt_hospital_id")
    private String mtHospitalId;
    
    @Schema(description = "회원 이메일")
    @Column(name = "mt_email")
    private String mtEmail;
    
    @Schema(description = "비밀번호")
    @Column(name = "mt_pwd")
    private String mtPwd;
    
    @Schema(description = "나이스 본인인증 식별자")
    @Column(name = "mt_di")
    private String mtDi;
    
    @Schema(description = "휴대폰번호")
    @Column(name = "mt_hp")
    private String mtHp;
    
    @Schema(description = "회원레벨 1=>정상, 10=>탈퇴")
    @Column(name = "mt_level", columnDefinition = "TINYINT")
    private int mtLevel;
    
    @Schema(description = "회원유형 1=>일반, 10=>관리자")
    @Column(name = "mt_type", columnDefinition = "TINYINT")
    private int mtType;
    
    @Schema(description = "이름")
    @Column(name = "mt_name")
    private String mtName;
    
    @Schema(description = "로그인 일시")
    @Column(name = "mt_ldate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtLdate;
    
    @Schema(description = "로그아웃 일시")
    @Column(name = "mt_lgdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtLgdate;
    
    @Schema(description = "가입일")
    @Column(name = "mt_wdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtWdate;
    
    @Schema(description = "수정일")
    @Column(name = "mt_edate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtEdate;
    
    @Schema(description = "삭제일")
    @Column(name = "mt_rdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtRdate;
    
    @Schema(description = "생년월일")
    @Column(name = "mt_birth")
    @DateTimeFormat(pattern = "yyyy.MM.dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtBirth;
    
    @Schema(description = "주소")
    @Column(name = "mt_addr")
    private String mtAddr;
    
    @Schema(description = "상세주소")
    @Column(name = "mt_addr_detail")
    private String mtAddrDetail;
    
    @Schema(description = "진단여부 0=>미확진,1=>확진")
    @Column(name = "mt_diagnosis", columnDefinition = "TINYINT")
    private int mtDiagnosis;
    
    @Schema(description = "진단코드 0=>직접입력")
    @Column(name = "mt_diagnosis_code", columnDefinition = "TINYINT")
    private int mtDiagnosisCode;
    
    @Schema(description = "이름")
    @Column(name = "mt_diagnosis_name")
    private String mtDiagnosisName;
    
    @Schema(description = "진단일")
    @Column(name = "mt_diagnosis_date")
    @DateTimeFormat(pattern = "yyyy.MM.dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtDiagnosisDate;
    
    @Schema(description = "병원명")
    @Column(name = "mt_hospital")
    private String mtHospital;
    
    @Schema(description = "담당의")
    @Column(name = "mt_doctor")
    private String mtDoctor;
    
    @Schema(description = "동의서 취득일자")
    @Column(name = "mt_agree_date")
    @DateTimeFormat(pattern = "yyyy.MM.dd")
    @Temporal(TemporalType.TIMESTAMP)
    private Date mtAgreeDate;
    
    @Schema(description = "비고")
    @Column(name = "mt_memo")
    private String mtMemo;
    
    @Schema(description = "소속")
    @Column(name = "mt_group")
    private String mtGroup;

    @Schema(description = "탈퇴사유")
    @Column(name = "mt_exit_reason")
    private String mtExitReason;

    @Schema(description = "권한 1=>전체, 2=>외부회원관리")
    @Column(name = "mt_grant", columnDefinition = "TINYINT")
    private int mtGrant;
    
    @Schema(description = "성별 1=>남, 2=>여")
    @Column(name = "mt_gender", columnDefinition = "TINYINT")
    private int mtGender;
}