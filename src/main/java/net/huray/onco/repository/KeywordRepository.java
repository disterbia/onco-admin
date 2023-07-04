package net.huray.onco.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Keyword;

@Repository
public interface KeywordRepository extends JpaRepository<Keyword, Long>  {

	List<Keyword> findAllByCtIdxAndKtLevelNot(int idx, int ktLevel);
	
	@Transactional
	void deleteAllByCtIdx(int ctIdx);
	
}