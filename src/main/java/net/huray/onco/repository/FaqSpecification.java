package net.huray.onco.repository;

import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Faq;

@Slf4j
@Service
public class FaqSpecification {
	
	
	public Specification<Faq> setSpecs(Map<String, Object> map){
		
		Specification<Faq> spec = (root, query, criteriaBuilder) -> null;
		

		//레벨
		if(map.containsKey("ftLevelNot")) {
			spec = spec.and(FaqSpecification.equalsFtLevelNot((int)map.get("ftLevelNot")));
		}

		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("ftTitle")){
					spec = spec.and(FaqSpecification.likeFtTitle((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("ftContent")){
					spec = spec.and(FaqSpecification.likeFtContent((String)map.get("search_value")));
				}
			}else {
				spec = spec.and(FaqSpecification.likeFtTitle((String)map.get("search_value")).or(FaqSpecification.likeFtContent((String)map.get("search_value"))));
			}
		}
		
		return spec;
	}
	
	
	
 	public static Specification<Faq> equalsFtLevelNot(int ftLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("ftLevel"), ftLevel);
    }

    public static Specification<Faq> likeFtTitle(String ftTitle) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ftTitle"),"%" + ftTitle + "%");
    }
    
    public static Specification<Faq> likeFtContent(String ftContent) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ftContent"),"%" + ftContent + "%");
    }
    
}
