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

@Schema(description = "약관 테이블")
@Entity(name = "terms_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Terms {

	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
	@Schema(description = "1=> 노출, 2=> 미노출, 10=>삭제")
    @Column(name = "tt_level", columnDefinition = "TINYINT")
    private int ttLevel;

	@Schema(description = "1=> 이용약관, 2=> 개인정보처리방침")
    @Column(name = "tt_type", columnDefinition = "TINYINT")
    private int ttType;

	@Schema(description = "제목")
    @Column(name = "tt_title")
    private String ttTitle ;

	@Schema(description = "내용")
    @Column(name = "tt_content", columnDefinition = "MEDIUMBLOB")
    private String ttContent ;

	@Schema(description = "등록일")
    @Column(name = "tt_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ttWdate;

	@Schema(description = "수정일")
    @Column(name = "tt_edate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ttEdate;

	@Schema(description = "삭제일")
    @Column(name = "tt_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ttRdate;
    
}