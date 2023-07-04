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

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Schema(description = "유전자 변이 테이블")
@Entity(name = "gene_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Gene {

    @Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
    @Schema(description = "유전자 이름")
    @Column(name = "gt_name")
    private String gtName ;
    
    @Schema(description = "1=>정상, 2=>미노출, 10=>삭제")
    @Column(name = "gt_level", columnDefinition = "TINYINT")
    private int gtLevel;
    
    @Schema(description = "생성일")
    @Column(name = "gt_wdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date gtWdate;
    
    @Schema(description = "수정일")
    @Column(name = "gt_edate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date gtEdate;
    
    @Schema(description = "삭제일")
    @Column(name = "gt_rdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date gtRdate;

}