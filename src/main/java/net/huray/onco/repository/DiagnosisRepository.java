package net.huray.onco.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Diagnosis;

@Repository
public interface DiagnosisRepository extends JpaRepository<Diagnosis, Long>  {
    List<Diagnosis> findAll();
	List<Diagnosis> findAllByDtLevelNot(int dtLevel);
	Page<Diagnosis> findAllByDtLevelNotAndDtNameContains(int dtLevel, String dtName, Pageable pageable);
	long countByDtNameAndDtLevelNot(String dtName, int dtLevel);
	long countByIdxNotAndDtNameAndDtLevelNot(int idx, String dtName, int dtLevel);
	Diagnosis findByIdxAndDtLevelNot(int idx, int dtLevel);
}