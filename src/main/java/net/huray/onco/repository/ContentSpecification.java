package net.huray.onco.repository;

import java.util.Map;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Content;
import net.huray.onco.domain.Keyword;

@Slf4j
@Service
public class ContentSpecification {

	public Specification<Content> setSpecs(Map<String, Object> map) {

		Specification<Content> spec = (root, query, criteriaBuilder) -> null;

		// 콘텐츠레벨
		if (map.containsKey("ctLevel")) {
			spec = spec.and(ContentSpecification.equalsCtLevel((int) map.get("ctLevel")));
		}

		if (map.containsKey("search_filter")) {
			if (map.containsKey("search_filter2")) {
				spec = spec.and(ContentSpecification.equalsDtIdx(Integer.parseInt((String) map.get("search_filter"))))
						.and(ContentSpecification.equalsGtIdx(Integer.parseInt((String) map.get("search_filter2"))));
			} else {
				spec = spec.and(ContentSpecification.equalsDtIdx(Integer.parseInt((String) map.get("search_filter"))));
			}
		} else {
			if (map.containsKey("search_filter2")) {
				if(map.get("search_filter2").equals("0")){
					spec = spec.and(ContentSpecification.notEqualsGtIdx(0));
				}else{
					spec = spec.and(ContentSpecification.equalsGtIdx(Integer.parseInt((String) map.get("search_filter2"))));
				}
				
			}
		}

		if (map.containsKey("search_type")) {
			if (map.containsKey("search_type2")) {
				spec = spec.and(ContentSpecification.equalsCtCategory(1)).and(ContentSpecification.equalsCtCategory(2));
			} else {
				spec = spec.and(ContentSpecification.equalsCtCategory(1));
			}
		} else {
			if (map.containsKey("search_type2")) {
				spec = spec.and(ContentSpecification.equalsCtCategory(2));
			}
		}

		if (map.containsKey("search_value")) {
			spec = spec.and(ContentSpecification.likeCtTitle((String) map.get("search_value")))
					.or(ContentSpecification.likeCtContent((String) map.get("search_value")));
		}

		return spec;
	}

	public static Specification<Content> equalsCtLevel(int ctLevel) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("ctLevel"), ctLevel);
	}

	public static Specification<Content> equalsCtCategory(int ctCategory) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("ctCategory"), ctCategory);
	}

	public static Specification<Content> equalsDtIdx(int dtIdx) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("dtIdx"), dtIdx);
	}

	public static Specification<Content> equalsGtIdx(int gtIdx) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.equal(root.get("gtIdx"), gtIdx);
	}
	public static Specification<Content> notEqualsGtIdx(int gtIdx) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.notEqual(root.get("gtIdx"), gtIdx);
	}

	public static Specification<Content> likeCtTitle(String ctTitle) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ctTitle"), "%" + ctTitle + "%");
	}

	public static Specification<Content> likeCtContent(String ctContent) {
		return (root, query, CriteriaBuilder) -> CriteriaBuilder.like(root.get("ctContent"), "%" + ctContent + "%");
	}
}
