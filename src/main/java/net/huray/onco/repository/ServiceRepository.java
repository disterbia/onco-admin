package net.huray.onco.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import net.huray.onco.domain.Service;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long> , JpaSpecificationExecutor<Service> {

    Page<Service> findAll(Specification<Service> spec, Pageable pageable);
    Service findByIdx(int idx);
    long countByMtIdxAndStStateCodeNot(int mtIdx,int stStateCode);
}