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

@Schema(description = "파일정보 테이블")
@Entity(name = "file_t")
@Getter
@Setter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class File {
	
	@Schema(description = "고유 idx")
    @Id
    @Column(name = "idx")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private long idx;

	@Schema(description = "참조 코드")
    @Column(name = "ft_ref_code")
    private String ftRefCode;

	@Schema(description = "참조 idx")
    @Column(name = "ft_ref_idx")
    private long ftRefIdx;

	@Schema(description = "1=>활성, 2=>비활성, 10=>삭제")
    @Column(name = "ft_level", columnDefinition = "TINYINT")
    private int ftLevel;

	@Schema(description = "파일 실제 이름")
    @Column(name = "ft_name")
    private String ftName;

	@Schema(description = "파일 S3 이름")
    @Column(name = "ft_uuid")
    private String ftUuid;

	@Schema(description = "파일 크기")
    @Column(name = "ft_size")
    private long ftSize;

	@Schema(description = "파일 확장자")
    @Column(name = "ft_ext")
    private String ftExt;

	@Schema(description = "파일 생성일")
    @Column(name = "ft_wdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ftWdate;

	@Schema(description = "파일 삭제일")
    @Column(name = "ft_rdate")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ftRdate;

}