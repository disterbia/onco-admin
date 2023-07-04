package net.huray.onco.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> , JpaSpecificationExecutor<Member> {
    Page<Member> findAll(Specification<Member> spec, Pageable pageable);
    Member findByMtId(String mtId);
	Member findOneByMtId(String mtId);
	Member findByMtIdAndMtLevelNot(String mtId, int mtLevel);
	long countByMtDi(String mtDi);
	long countByMtHpAndMtLevel(String mtId, int mtLevel);
	long countByMtIdAndMtLevel(String mtId, int mtLevel);
	long countByMtIdAndMtLevelNot(String mtId, int mtLevel);
	long countByMtHpAndMtLevelNot(String mtHp, int mtLevel);
	long countByMtEmailAndMtLevelNot(String mtEmail, int mtLevel);
	long countByIdxNotAndMtIdAndMtLevelNot(int idx, String mtId, int mtLevel);
	long countByIdxNotAndMtHpAndMtLevelNot(int idx, String mtHp, int mtLevel);
	long countByIdxNotAndMtEmailAndMtLevelNot(int idx, String mtEmail, int mtLevel);
	Member findOneByIdxAndMtType(int idx, int mtType);
	Member findOneByIdxAndMtLevelNot(int idx, int mtLevel);
	Member findByMtIdAndMtTypeAndMtLevelNot(String mtId, int mtType, int mtLevel);
	List<Member> findAllByMtLevelAndMtTypeAndMtRdateBetween(int mtLevel, int mtType, Date from, Date to);
	long countByMtTypeAndMtLevelNot(int mtType, int mtLevel);
	long countByMtTypeAndMtLevel(int mtType, int mtLevel);
	@Query("SELECT mt.idx FROM member_t mt WHERE mt.mtType = :mtType")
    List<Integer> findAllByMtType(@Param("mtType") int mt_type);
	List<Member> findAllByIdxIn(List<Integer> idxList);
	List<Member> findAllByIdxInAndMtType(List<Integer> idxList, int mtType);
}