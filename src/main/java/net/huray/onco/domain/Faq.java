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

@Schema(description = "자주묻는질문 테이블")
@Entity(name = "faq_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Faq {

	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
	@Schema(description = "1=> 노출, 2=> 숨김, 10=>삭제")
    @Column(name = "ft_level", columnDefinition = "TINYINT")
    private int ftLevel;
    
	@Schema(description = "질문")
    @Column(name = "ft_title")
    private String ftTitle ;
    
	@Schema(description = "내용")
    @Column(name = "ft_content", columnDefinition = "MEDIUMBLOB")
    private String ftContent ;
    
	@Schema(description = "등록일")
    @Column(name = "ft_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ftWdate;
    
	@Schema(description = "수정일")
    @Column(name = "ft_edate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ftEdate;
    
	@Schema(description = "삭제일")
    @Column(name = "ft_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ftRdate;
        
}