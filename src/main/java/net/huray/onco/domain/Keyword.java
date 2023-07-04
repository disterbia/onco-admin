package net.huray.onco.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.Comment;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Schema(description = "키워드 테이블")
@Entity(name = "keyword_t")
@Getter
@Setter
@Builder 
@AllArgsConstructor
@NoArgsConstructor
public class Keyword {
	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int idx;
    
	@Schema(description = "content_t.idx")
    @Column(name = "ct_idx")
    private int ctIdx;
    
	@Schema(description = "1=> 노출, 2=> 숨김, 10=>삭제")
    @Column(name = "kt_level", columnDefinition = "TINYINT")
    private int ktLevel;

	@Schema(description = "키워드 단어")
    @Column(name = "kt_word")
    private String ktWord;
    
    @ManyToOne
    @JoinColumn(name = "ct_idx", insertable = false, updatable = false)
    private Content content;
    
}