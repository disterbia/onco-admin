package net.huray.onco.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import net.huray.onco.domain.Gene;

@Repository
public interface GeneRepository extends JpaRepository<Gene, Long>, JpaSpecificationExecutor<Gene>  {
	Page<Gene> findAllByGtLevelNotAndGtNameContains(int gtLevel, String gtName, Pageable pageable);
	List<Gene> findAll();
	List<Gene> findAllByGtLevelNot(int gtLevel);
	Gene findByIdxAndGtLevelNot(int idx, int gtLevel);
	long countByGtNameAndGtLevelNot(String gtName, int gtLevel);
	long countByIdxNotAndGtNameAndGtLevelNot(int idx, String gtName, int gtLevel);
}