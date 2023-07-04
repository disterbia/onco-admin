package net.huray.onco.repository;

import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Notice;

@Slf4j
@Service
public class NoticeSpecification {
	
	
	public Specification<Notice> setSpecs(Map<String, Object> map){
		
		Specification<Notice> spec = (root, query, criteriaBuilder) -> null;
		

		//회원레벨
		if(map.containsKey("ntLevelNot")) {
			spec = spec.and(NoticeSpecification.equalsNtLevelNot((int)map.get("ntLevelNot")));
		}

		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("ntTitle")){
					spec = spec.and(NoticeSpecification.likeNtTitle((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("ntContent")){
					spec = spec.and(NoticeSpecification.likeNtContent((String)map.get("search_value")));
				}
			}else {
				spec = spec.and(NoticeSpecification.likeNtTitle((String)map.get("search_value")).or(NoticeSpecification.likeNtContent((String)map.get("search_value"))));
			}
		}
		
		return spec;
	}
	
	
	
 	public static Specification<Notice> equalsNtLevelNot(int ntLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("ntLevel"), ntLevel);
    }

    public static Specification<Notice> likeNtTitle(String ntTitle) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ntTitle"),"%" + ntTitle + "%");
    }
    
    public static Specification<Notice> likeNtContent(String ntContent) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ntContent"),"%" + ntContent + "%");
    }
    
}
