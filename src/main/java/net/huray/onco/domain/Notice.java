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

@Schema(description = "공지사항 테이블")
@Entity(name = "notice_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Notice {
	
	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
	@Schema(description = "1=> 노출, 2=> 숨김, 10=>삭제")
    @Column(name = "nt_level", columnDefinition = "TINYINT")
    private int ntLevel;
    
	@Schema(description = "타이틀")
    @Column(name = "nt_title")
    private String ntTitle ;
    
	@Schema(description = "내용")
    @Column(name = "nt_content", columnDefinition = "MEDIUMBLOB")
    private String ntContent ;
    
	@Schema(description = "등록일")
    @Column(name = "nt_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ntWdate;
    
	@Schema(description = "수정일")
    @Column(name = "nt_edate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ntEdate;
    
	@Schema(description = "삭제일")
    @Column(name = "nt_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ntRdate;
    
	@Schema(description = "조회수")
    @Column(name = "nt_view")
    private int ntView;
    
}