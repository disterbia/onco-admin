package net.huray.onco.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Content;

@Repository
public interface ContentRepository extends JpaRepository<Content, Long>, JpaSpecificationExecutor<Content> {
    // 최근순 상위 5개 content
    Page<Content> findAll(Specification<Content> spec, Pageable pageable);

    Content findByIdx(int idx);

    // 위 5개를 제외한 where gt_idx is not null 조건인 content 최근순 5개
    @Query("SELECT c FROM content_t c WHERE c.gtIdx != 0 AND c.idx NOT IN :ids ORDER BY c.idx DESC")
    Page<Content> findContentByGene(@Param("ids") List<Integer> ids, Pageable pageable);

    // 위 10개를 제외한 where ct_category = 1 조건인 content 최근순 5개
    @Query("SELECT c FROM content_t c WHERE c.ctCategory = 1 AND c.idx NOT IN :ids ORDER BY c.idx DESC")
    Page<Content> findContentByCategory1(@Param("ids") List<Integer> ids, Pageable pageable);

    // 위 15개를 제외한 where ct_category = 2 content 최근순 5개
    @Query("SELECT c FROM content_t c WHERE c.ctCategory = 2 AND c.idx NOT IN :ids ORDER BY c.idx DESC")
    Page<Content> findContentByCategory2(@Param("ids") List<Integer> ids, Pageable pageable);

    @Modifying
    @Query("UPDATE content_t c set c.ctView = c.ctView + 1 where c.idx = :idx")
    int updateViews(@Param("idx") int idx);

    Content findOneByIdxAndCtLevelNot(int idx, int ctLevel);
}
