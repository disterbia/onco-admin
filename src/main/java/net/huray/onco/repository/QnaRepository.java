package net.huray.onco.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Qna;

@Repository
public interface QnaRepository extends JpaRepository<Qna, Long> , JpaSpecificationExecutor<Qna> {
    Page<Qna> findAll(Specification<Qna> spec, Pageable pageable);
    Qna findOneByIdxAndQtLevelNot(int idx, int qtLevel);
    Qna findOneByIdxAndQtLevel(int idx, int qtLevel);
	long countByQtLevelNot(int qtLevel);
	long countByQtTypeAndQtLevelNot(int qtType, int qtLevel);
	long countByQtLevel(int qtLevel);
}