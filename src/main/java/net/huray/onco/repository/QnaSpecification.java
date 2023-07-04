package net.huray.onco.repository;

import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Qna;

@Slf4j
@Service
public class QnaSpecification {
	
	
	public Specification<Qna> setSpecs(Map<String, Object> map){
		
		Specification<Qna> spec = (root, query, criteriaBuilder) -> null;
		//레벨
		if(map.containsKey("qtLevelNot")) {
			spec = spec.and(QnaSpecification.equalsQtLevelNot((int)map.get("qtLevelNot")));
		}
		
		//문의유형
		if(map.containsKey("search_type")) {
			if(map.get("search_type").equals("1")){
				spec = spec.and(QnaSpecification.equalsQtType(1));
			}else if(map.get("search_type").equals("2")){
				spec = spec.and(QnaSpecification.equalsQtType(2));
			}else if(map.get("search_type").equals("3")){
				spec = spec.and(QnaSpecification.equalsQtType(3));
			}else if(map.get("search_type").equals("4")){
				spec = spec.and(QnaSpecification.equalsQtType(4));
			}else if(map.get("search_type").equals("5")){
				spec = spec.and(QnaSpecification.equalsQtType(5));
			}
		}
		
		//문의상태
		if(map.containsKey("search_type2")) {
			if(map.get("search_type2").equals("1")){
				spec = spec.and(QnaSpecification.equalsQtLevel(1));
			}else if(map.get("search_type2").equals("2")){
				spec = spec.and(QnaSpecification.equalsQtLevel(2));
			}
		}

		//검색어, 검색필터
		if(map.containsKey("search_value")) {
			if(map.containsKey("search_filter")) {
				if(map.get("search_filter").equals("qtTitle")){
					spec = spec.and(QnaSpecification.likeQtTitle((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("qtContent")){
					spec = spec.and(QnaSpecification.likeQtContent((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("mtName")){
					spec = spec.and(QnaSpecification.likeMtName((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("mtHp")){
					spec = spec.and(QnaSpecification.likeMtHp((String)map.get("search_value")));
				}else if(map.get("search_filter").equals("all")){
					spec = spec.and(QnaSpecification.likeQtTitle((String)map.get("search_value"))
							.or(QnaSpecification.likeQtContent((String)map.get("search_value")))
							.or(QnaSpecification.likeMtName((String)map.get("search_value")))
							.or(QnaSpecification.likeMtHp((String)map.get("search_value"))));
				}
			}else {
				spec = spec.and(QnaSpecification.likeQtTitle((String)map.get("search_value"))
						.or(QnaSpecification.likeQtContent((String)map.get("search_value")))
						.or(QnaSpecification.likeMtName((String)map.get("search_value")))
						.or(QnaSpecification.likeMtHp((String)map.get("search_value"))));
			}
		}
		return spec;
	}
	
	public Specification<Qna> setSpecs2(Map<String, Object> map){
		
		Specification<Qna> spec = (root, query, criteriaBuilder) -> null;
				//레벨
		if(map.containsKey("qtLevelNot")) {
			spec = spec.and(QnaSpecification.equalsQtLevelNot((int)map.get("qtLevelNot")));
		}

        spec = spec.and(QnaSpecification.equalsName((String)map.get("mtName")));
        spec = spec.and(QnaSpecification.equalsHp((String)map.get("mtHp")));
		
		return spec;
	}
	
	
 	public static Specification<Qna> equalsName(String mtName) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("mtName"), mtName);
    }

    public static Specification<Qna> equalsHp(String mtHp) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("mtHp"), mtHp );
    }
	
 	public static Specification<Qna> equalsQtType(int qtType) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("qtType"), qtType);
    }
 	
 	public static Specification<Qna> equalsQtLevelNot(int qtLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("qtLevel"), qtLevel);
    }
 	
 	public static Specification<Qna> equalsQtLevel(int qtLevel) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("qtLevel"), qtLevel);
    }

    public static Specification<Qna> likeQtTitle(String qtTitle) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("qtTitle"),"%" + qtTitle + "%");
    }
    
    public static Specification<Qna> likeQtContent(String qtContent) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("qtContent"),"%" + qtContent + "%");
    }
    
    public static Specification<Qna> likeMtName(String mtName) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("mtName"),"%" + mtName + "%");
    }
    
    public static Specification<Qna> likeMtHp(String mtHp) {
        return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("mtHp"),"%" + mtHp + "%");
    }
    
}
