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

import net.huray.onco.domain.Notice;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long> , JpaSpecificationExecutor<Notice> {
    Page<Notice> findAll(Specification<Notice> spec, Pageable pageable);
	Notice findOneByIdxAndNtLevelNot(int idx, int ntLevel);
	Notice findOneByIdxAndNtLevel(int idx, int ntLevel);

	@Modifying
    @Query("UPDATE notice_t n set n.ntView = n.ntView + 1 where n.idx = :idx")
    int updateViews(@Param("idx") int idx);

}