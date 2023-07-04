package net.huray.onco.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class PageLogic {
	
	public Map<String, Object> getParameters(HttpServletRequest request, Map<String, Object> map){

	    // 모든 파라미터 이름을 가져와서 처리
	    for (String parameterName : request.getParameterMap().keySet()) {
	        String[] parameterValues = request.getParameterValues(parameterName);

	     // 배열 파라미터인 경우 콤마로 join하여 문자열로 변환
	        if (parameterValues.length > 1) {
	            String joinedValue = String.join(",", parameterValues);
	            map.put(parameterName, joinedValue);
	        } else {
	            String value = parameterValues[0] != null ? parameterValues[0] : "";
	            map.put(parameterName, value);
	        }
	    }
	    
	    if(!map.containsKey("pg") || map.get("pg") == null || map.get("pg").equals("")) {
	    	map.put("pg", "1");
	    }
	    
	    return map;
	}
	
	public Map<String, Object> setParameters(Map<String, Object> map, Page<?> page) {
		

		int n_limit = 10;
		map.put("n_limit", n_limit);
		
		//counts
		long counts = page.getTotalElements();
		map.put("counts", counts);
		
		//n_page
		int n_page = (int)(counts / n_limit) < 1 ? 1 : (int)(counts % n_limit) > 0 ?  (int)(counts / n_limit) + 1 : (int) Math.ceil( (double) counts / n_limit);
		map.put("n_page", n_page);
	    
		//pg
		int pg = Integer.parseInt((String) map.get("pg"));
		
		//n_from
		int n_from = (pg - 1) * n_limit;
	    map.put("n_from", n_from);
	    
	    //counts
	    long remainingCounts = counts - n_from;
	    map.put("counts", remainingCounts);
	    
	    //n_start
	    int n_start = ((pg - 1) / 5) * 5 + 1;
	    map.put("n_start", n_start);
	    
	    //n_end
	    int n_end = n_start + 5;
	    if (n_end >= n_page) {
	        n_end = n_page;
	    }
	    map.put("n_end", n_end);
	    
	    return map;
	}
}
