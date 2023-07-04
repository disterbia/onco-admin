package net.huray.onco.repository;

import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Terms;

@Slf4j
@Service
public class TermsSpecification {
	
	
	public Specification<Terms> setSpecs(Map<String, Object> map){
		
		Specification<Terms> spec = (root, query, criteriaBuilder) -> null;
		

		//레벨
		if(map.containsKey("ttLevelNot")) {
			spec = spec.and(TermsSpecification.equalsTtLevelNot((int)map.get("ttLevelNot")));
		}
		
		//유형
		if(map.containsKey("ttType")) {
			spec = spec.and(TermsSpecification.equalsTtType((int)map.get("ttType")));
		}

		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("ttTitle")){
					spec = spec.and(TermsSpecification.likeTtTitle((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("ttContent")){
					spec = spec.and(TermsSpecification.likeTtContent((String)map.get("search_value")));
				}
			}else {
				spec = spec.and(TermsSpecification.likeTtTitle((String)map.get("search_value")).or(TermsSpecification.likeTtContent((String)map.get("search_value"))));
			}
		}
		
		return spec;
	}
	
	
	
 	public static Specification<Terms> equalsTtLevelNot(int ttLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("ttLevel"), ttLevel);
    }
 	
 	public static Specification<Terms> equalsTtType(int ttType) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("ttType"), ttType);
    }

    public static Specification<Terms> likeTtTitle(String ttTitle) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ttTitle"),"%" + ttTitle + "%");
    }
    
    public static Specification<Terms> likeTtContent(String ttContent) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ttContent"),"%" + ttContent + "%");
    }
    
}
