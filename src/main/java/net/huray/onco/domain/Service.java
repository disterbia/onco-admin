package net.huray.onco.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Comment;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Schema(description = "서비스 테이블")
@Entity(name = "service_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Service {
    @Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
    @Schema(description = "member_t.idx")
    @Column(name = "mt_idx")
    private int mtIdx ;
    
    @Schema(description = "서비스번호")
    @Column(name = "st_string")
    private String stString ;

    @Schema(description = "신청자 이메일")
    @Column(name = "st_email")
    private String stEmail ;
     
    @Schema(description = "암종idx diagnosis_t.idx")
    @Column(name = "st_diagnosis_code" ,columnDefinition = "TINYINT")
    private int stDiagnosisCode;

    @Schema(description = "암종 diagnosis_t.name")
    @Column(name = "st_diagnosis_name")
    private String stDiagnosisName;

    @Schema(description = "서류 제출 방식코드 1=>홈페이지제출, 2=>이메일제출")
    @Column(name = "st_submit_format_code" ,columnDefinition = "TINYINT")
    private int stSubmitFormatCode;

    @Schema(description = "서비스지 수령 방식코드 1=> 이메일, 2=>문자, 3=>카카오톡")
    @Column(name = "st_receipt_format_code" ,columnDefinition = "TINYINT")
    private int stReceiptFormatCode;

    @Schema(description = "진행상태 코드 1=> 발송대기, 2=>발송완료, 3=>접수대기, 4=>취소, 5=>접수완료" )
    @Column(name = "st_state_code" ,columnDefinition = "TINYINT")
    private int stStateCode;

    @Schema(description = "예상 수령일자")
    @Column(name = "st_receive_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date stReceiveDate;

    @Schema(description = "등록일")
    @Column(name = "st_wdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date stWdate;
    
    @Schema(description = "수정일")
    @Column(name = "st_edate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date stEdate;
    
    @Schema(description = "삭제일")
    @Column(name = "st_rdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date stRdate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="mt_idx", referencedColumnName="idx", insertable = false, updatable = false)
    private Member member;
  
}
