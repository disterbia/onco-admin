package net.huray.onco.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;
import net.huray.onco.domain.Gene;
import net.huray.onco.domain.Keyword;

@Repository
public interface KewordRepository extends JpaRepository<Keyword, Long>  {
	List<Keyword> findAllByKtWordLikeAndKtLevelNot(String ktWord, int KtLevel);
}