package net.huray.onco.repository;

import javax.validation.Valid;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Terms;

@Repository
public interface TermsRepository extends JpaRepository<Terms, Long> , JpaSpecificationExecutor<Terms> {
    Page<Terms> findAll(Specification<Terms> spec, Pageable pageable);
    Terms findOneByIdxAndTtLevelNot(int idx, int ttLevel);
    Terms findOneByIdxAndTtLevel(int idx, int ttLevel);
	Terms findTop1ByTtTypeAndTtLevelNotOrderByIdxDesc(int ttType, int ttLevel);
}