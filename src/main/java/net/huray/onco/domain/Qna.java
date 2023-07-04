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

@Schema(description = "1:1문의 테이블")
@Entity(name = "qna_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Qna {
	
	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;

	@Schema(description = "문의자, member_t.idx, 0 => 비회원")
    @Column(name = "mt_idx")
    private int mtIdx;

	@Schema(description = "답변자, member_t.idx")
    @Column(name = "mt_idx2")
    private int mtIdx2;

	@Schema(description = "문의자 명")
    @Column(name = "mt_name")
    private String mtName ;

	@Schema(description = "문의자 핸드폰번호")
    @Column(name = "mt_hp")
    private String mtHp ;

	@Schema(description = "문의자 이메일")
    @Column(name = "mt_email")
    private String mtEmail ;

	@Schema(description = "1=> 미답변, 2=> 답변완료, 10=>삭제")
    @Column(name = "qt_level", columnDefinition = "TINYINT")
    private int qtLevel;

	@Schema(description = "1=> 서비스지취소요청, 2=> 서비스지신청관련, 3=>서비스지내용관련, 4=>회원가입관련, 5=>기타")
    @Column(name = "qt_type", columnDefinition = "TINYINT")
    private int qtType;

	@Schema(description = "제목")
    @Column(name = "qt_title")
    private String qtTitle ;

	@Schema(description = "내용")
    @Column(name = "qt_content")
    private String qtContent ;

	@Schema(description = "답변")
    @Column(name = "qt_answer", columnDefinition = "MEDIUMBLOB")
    private String qtAnswer ;

	@Schema(description = "등록일")
    @Column(name = "qt_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date qtWdate;

	@Schema(description = "수정일")
    @Column(name = "qt_edate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date qtEdate;

	@Schema(description = "삭제일")
    @Column(name = "qt_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date qtRdate;

	@Schema(description = "답변일")
    @Column(name = "qt_adate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date qtAdate;

	@Schema(description = "조회수")
    @Column(name = "qt_view")
    private int qtView;
    
}