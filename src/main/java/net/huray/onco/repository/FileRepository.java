package net.huray.onco.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.File;

@Repository
public interface FileRepository extends JpaRepository<File, Long> , JpaSpecificationExecutor<File> {
    List<File> findAllByFtRefCodeAndFtRefIdxAndFtLevelNot(String ftRefCode, String ftRefIdx, int ftLevel);

	List<File> findAllByFtRefCodeAndFtRefIdxAndFtLevel(String refCode, long refIdx, int ftLevel);

	File findByFtUuidAndFtLevelNot(String ftUuid, int ftLevel);

	List<File> findAllByFtLevel(int ftLevel);
}