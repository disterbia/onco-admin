package net.huray.onco.repository;

import java.util.HashMap;
import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Member;
import net.huray.onco.service.MngService;

@Slf4j
@Service
public class MemberSpecification {
	
	
	public Specification<Member> setSpecs(Map<String, Object> map){
		
		Specification<Member> spec = (root, query, criteriaBuilder) -> null;
		
		//회원레벨
		if(map.containsKey("mtLevel")) {
			spec = spec.and(MemberSpecification.equalsMtLevel((int)map.get("mtLevel")));
		}
		
		//회원레벨
		if(map.containsKey("mtLevelNot")) {
			spec = spec.and(MemberSpecification.equalsMtLevelNot((int)map.get("mtLevelNot")));
		}
		
		
		//회원유형
		if(map.containsKey("mtType")) {
			spec = spec.and(MemberSpecification.equalsMtType((int)map.get("mtType")));
		}
		
		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("mtName")){
					spec = spec.and(MemberSpecification.likeMtName((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("mtEmail")){
					spec = spec.and(MemberSpecification.likeMtEmail((String)map.get("search_value")));
				}
				else {
					spec = spec.and(MemberSpecification.likeMtId((String)map.get("search_value")));
				}
			}else {
				spec = spec.and(MemberSpecification.likeMtName((String)map.get("search_value")).or(MemberSpecification.likeMtId((String)map.get("search_value"))));
			}
		}
		
		return spec;
	}
	
	
	
 	public static Specification<Member> equalsMtLevel(int mtLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("mtLevel"), mtLevel);
    }
 	
 	public static Specification<Member> equalsMtLevelNot(int mtLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("mtLevel"), mtLevel);
    }
 	
 	public static Specification<Member> equalsMtType(int mtType) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("mtType"), mtType);
    }


    public static Specification<Member> likeMtName(String mtName) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("mtName"),"%" + mtName + "%");
    }
    
    public static Specification<Member> likeMtId(String mtId) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("mtId"),"%" + mtId + "%");
    }
    
    public static Specification<Member> likeMtEmail(String mtEmail) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("mtEmail"),"%" + mtEmail + "%");
    }
}
