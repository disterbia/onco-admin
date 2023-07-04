package net.huray.onco.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Faq;

@Repository
public interface FaqRepository extends JpaRepository<Faq, Long> , JpaSpecificationExecutor<Faq> {
    Page<Faq> findAll(Specification<Faq> spec, Pageable pageable);
    Faq findOneByIdxAndFtLevelNot(int idx, int ntLevel);
    Faq findOneByIdxAndFtLevel(int idx, int ntLevel);
}