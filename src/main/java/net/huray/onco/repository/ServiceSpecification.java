package net.huray.onco.repository;

import java.util.Map;
import java.util.Date;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ServiceSpecification {

    public Specification<net.huray.onco.domain.Service> setSpecs(Map<String, Object> map){

        Specification<net.huray.onco.domain.Service> spec = (root, query, criteriaBuilder) -> null;

        //레벨
        if(map.containsKey("mtIdx")) {
            spec = spec.and(ServiceSpecification.equalsMtIdx((int)map.get("mtIdx")));
        }

        if(map.containsKey("from") && map.containsKey("to")) {
            spec = spec.and(ServiceSpecification.between((Date)map.get("from"), (Date)map.get("to")));
        }

        return spec;
    }

    public static Specification<net.huray.onco.domain.Service> equalsMtIdx(int mtIdx) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("mtIdx"), mtIdx);
    }

    public static Specification<net.huray.onco.domain.Service> between(java.util.Date from, java.util.Date to) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(root.get("stWdate"), from, to);
    }
}
