package net.huray.onco.domain;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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

@Schema(description = "콘텐츠 테이블")
@Entity(name = "content_t")
@Getter
@Setter
@NoArgsConstructor
@Builder 
@AllArgsConstructor
public class Content {
	
	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
	@Schema(description = "병명정보  diagnosis_t.idx")
    @Column(name = "dt_idx")
    private Integer dtIdx;
    
	@Schema(description = "변이정보  gene_t.idx")
    @Column(name = "gt_idx")
    private Integer gtIdx;
    
	@Schema(description = "1=> 노출, 2=> 숨김, 10=>삭제")
    @Column(name = "ct_level", columnDefinition = "TINYINT")
    private int ctLevel;
    
	@Schema(description = "0=> 전체, 1=> 약제정보, 2=>임상시험")
    @Column(name = "ct_category", columnDefinition = "TINYINT")
    private int ctCategory;
    
	@Schema(description = "타이틀")
    @Column(name = "ct_title")
    private String ctTitle;

	@Schema(description = "내용")
    @Column(name = "ct_content", columnDefinition = "MEDIUMBLOB")
    private String ctContent;

	@Schema(description = "영상URL")
    @Column(name = "ct_url")
    private String ctUrl;

	@Schema(description = "썸네일정보")
    @Column(name = "ct_thumbnail")
    private String ctThumbnail;

	@Schema(description = "등록일")
    @Column(name = "ct_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ctWdate;

	@Schema(description = "수정일")
    @Column(name = "ct_edate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ctEdate;

	@Schema(description = "삭제일")
    @Column(name = "ct_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ctRdate;

	@Schema(description = "조회수")
    @Column(name = "ct_view")
    private int ctView;

    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name="dt_idx", referencedColumnName="idx", insertable = false, updatable = false, nullable = true)
    private Diagnosis diagnosis;

    @ManyToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name="gt_idx", referencedColumnName="idx", insertable = false, updatable = false, nullable = true)
    private Gene gene;

    @OneToMany(mappedBy = "content", cascade = CascadeType.ALL)
    private List<Keyword> keywords;


public String getDtName() {
    if (this.diagnosis != null) {
        return this.diagnosis.getDtName();
    } else {
        return null;
    }
}

public String getGtName() {
    if (this.gene != null) {
        return this.gene.getGtName();
    } else {
        return null;
    }
}

    
}