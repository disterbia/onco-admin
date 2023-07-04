package net.huray.onco.repository;

import java.util.Map;

import javax.persistence.criteria.Join;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Content;
import net.huray.onco.domain.Keyword;

@Slf4j
@Service
public class ContentSpecification2 {
	
	
	public Specification<Content> setSpecs(Map<String, Object> map){
		
		Specification<Content> spec = (root, query, criteriaBuilder) -> null;
		
		//레벨
		if(map.containsKey("ctLevel")) {
			spec = spec.and(ContentSpecification2.equalsCtLevel((int)map.get("ctLevel")));
		}
		
		//레벨 Not
		if(map.containsKey("ctLevelNot")) {
			spec = spec.and(ContentSpecification2.equalsCtLevelNot((int)map.get("ctLevelNot")));
		}
		
		//암 유형
		if(map.containsKey("search_filter2")) {
			if(map.get("search_filter2").equals("all")){
			}else {
				spec = spec.and(ContentSpecification2.equalsDtIdx( Integer.parseInt((String) map.get("search_filter2")) ));
			}
		}
		
		//변이 유형
		if(map.containsKey("search_filter3")) {
			if(map.get("search_filter3").equals("all")){
			}else {
				spec = spec.and(ContentSpecification2.equalsGtIdx( Integer.parseInt((String) map.get("search_filter3")) ));
			}
		}
		
		//정보 유형
		if(map.containsKey("search_type2")) {
			if(map.get("search_type2").equals("all")){
			}else {
				spec = spec.and(ContentSpecification2.equalsCtCategory( Integer.parseInt((String) map.get("search_type2")) ));
			}
		}
		
		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("ctTitle")){
					spec = spec.and(ContentSpecification2.likeCtTitle((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("ctContent")){
					spec = spec.and(ContentSpecification2.likeCtContent((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("ktWord")){
					spec = spec.and(ContentSpecification2.likeKtWord((String)map.get("search_value")));
				}
			}else {
				spec = spec.and(ContentSpecification2.likeCtTitle((String)map.get("search_value"))
						.or(ContentSpecification2.likeCtContent((String)map.get("search_value")))
						.or(ContentSpecification2.likeKtWord((String)map.get("search_value"))));
			}
		}
		
		return spec;
	}
	
	
	
 	public static Specification<Content> equalsCtLevel(int ctLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("ctLevel"), ctLevel);
    }
 	
 	public static Specification<Content> equalsCtLevelNot(int ctLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("ctLevel"), ctLevel);
    }
 	
 	public static Specification<Content> equalsDtIdx(int dtIdx) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("dtIdx"), dtIdx);
    }
 	
 	public static Specification<Content> equalsGtIdx(int gtIdx) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("gtIdx"), gtIdx);
    }

 	public static Specification<Content> equalsCtCategory(int ctCategory) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("ctCategory"), ctCategory);
    }
 	

    public static Specification<Content> likeCtTitle(String ctTitle) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ctTitle"),"%" + ctTitle + "%");
    }
    
    public static Specification<Content> likeCtContent(String ctContent) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ctContent"),"%" + ctContent + "%");
    }
    
    public static Specification<Content> likeKtWord(String ktWord) {
        return (root, query, criteriaBuilder) -> {
            Join<Content, Keyword> keywordJoin = root.join("keywords");
            return criteriaBuilder.like(keywordJoin.get("ktWord"), "%" + ktWord + "%");
        };
    }
}
