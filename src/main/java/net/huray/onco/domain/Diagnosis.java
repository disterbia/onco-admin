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

@Schema(description = "암종 테이블")
@Entity(name = "diagnosis_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Diagnosis {

    @Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
    @Schema(description = "1=>정상, 2=>미노출, 10=>삭제")
    @Column(name = "dt_level", columnDefinition = "TINYINT")
    private int dtLevel;
    
    @Schema(description = "진단명(암명)")
    @Column(name = "dt_name")
    private String dtName ;
    
    @Schema(description = "등록일")
    @Column(name = "dt_wdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dtWdate;
    
    @Schema(description = "수정일")
    @Column(name = "dt_edate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dtEdate;
    
    @Schema(description = "삭제일")
    @Column(name = "dt_rdate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dtRdate;
    

    
 
}