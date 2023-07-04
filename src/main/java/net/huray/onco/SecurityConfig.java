

package net.huray.onco;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.DefaultHttpFirewall;
import org.springframework.security.web.firewall.HttpFirewall;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
//	@Autowired
//	@Qualifier("sessionRegistry")
//	private SessionRegistry sessionRegistry;
	
	@Autowired
    private CustomSessionRegistry customSessionRegistry;
	
	
    // 인증 예외처리
	@Bean
    public WebSecurityCustomizer configure() {
        return (web) -> 
        web.ignoring().antMatchers("/favicon.ico","/resources/**","/errorPage","/error/**", "/mng/download/**");
    }
	
	//웹 - 사용자용
    @Bean
    protected SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	
			http
				.antMatcher("/main/**").authorizeRequests()
				.antMatchers("/main/login","/main/loginUpdate.do", "/main/join**/**","/main/index","/main/service**",
				"/main/company**","/main/medical**","/main/new**/**","/main/notice**/**","/main/nice**","/main/query**/**","/main/faq","/main",
				"/main/privacyPolicy","/main/terms").permitAll()
			    .antMatchers("/main/logout").authenticated()
			    .antMatchers("/main/**").hasRole("USER")
			    
	        .and()
				.formLogin()
			    .loginPage("/main/login")
			    .defaultSuccessUrl("/main/index")
			.and()
				.logout()
			    .logoutUrl("/main/logout")
				.logoutSuccessUrl("/main/login")
				.invalidateHttpSession(	true)
				.deleteCookies("JSESSIONID")
			.and()
				.exceptionHandling()
				.accessDeniedPage("/main/login")
			
			.and()
				.sessionManagement()
				.sessionAuthenticationStrategy(customSessionRegistry)
				.maximumSessions(1)
				.maxSessionsPreventsLogin(true)
				.expiredUrl("/main/login");
		
		return http.build();
    }
    
    //웹 - 관리자용
    @Bean
    protected SecurityFilterChain securityFilterChain2(HttpSecurity http) throws Exception {
    	
    	 	http
	    	 	.antMatcher("/mng/**").authorizeRequests()
	            .antMatchers("/mng/login","/mng/loginUpdate.do", "/mng/join**", "/mng/mngTerms.do").permitAll()
	            .antMatchers("/mng/logout").authenticated()
	            .antMatchers("/mng", "/mng/", "/mng/index", "/mng/memberList2", "/mng/memberForm2", "/mng/memberDetail2", "/mng/memberUpdate.do", "/mng/excelSelect.do", "/mng/excel.do").hasAnyRole("ADMIN", "MASTER")
	            .antMatchers("/mng/**").hasRole("MASTER")
	        .and()
	        	.formLogin()
	            .loginPage("/mng/login")
	            .defaultSuccessUrl("/mng/index")
	        .and()
	        	.logout()
	            .logoutUrl("/mng/logout")
	            .logoutSuccessUrl("/mng/login")
	            .invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
			.and()
				.exceptionHandling()
				.accessDeniedPage("/mng/login")
	 		.and()
	 			.sessionManagement()
				.sessionAuthenticationStrategy(customSessionRegistry)
				.maximumSessions(1)
				.maxSessionsPreventsLogin(true)
				.expiredUrl("/mng/login");
	    	 
	    		return http.build();
    }
    
     
    @Bean
    public HttpFirewall defaultHttpFirewall() {
        return new DefaultHttpFirewall();
    }
    
    @Bean
    public PasswordEncoder getPasswordEncoder() {
       return new BCryptPasswordEncoder();
    }
    
    @Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }
}
