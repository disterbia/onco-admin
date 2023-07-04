package net.huray.onco;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;
import net.huray.onco.domain.Member;

@Slf4j
@Configuration
@Component
public class CustomSessionRegistry implements SessionAuthenticationStrategy {

	private final SessionRegistry sessionRegistry;
	private final PasswordEncoder passwordEncoder;
    private final UserDetailsService userDetailsService;

    public CustomSessionRegistry(@Lazy SessionRegistry sessionRegistry, @Lazy PasswordEncoder passwordEncoder, @Lazy UserDetailsService userDetailsService) {
        this.sessionRegistry = sessionRegistry;
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
    }
	
	@Override
	public void onAuthentication(Authentication authentication, HttpServletRequest request, HttpServletResponse response) throws SessionAuthenticationException {

		//시큐리티 인증 정보가 같은 세션 삭제
		List<SessionInformation> sessions = sessionRegistry.getAllSessions(authentication.getPrincipal(), true);
		for (SessionInformation sessionInfo : sessions) {
			sessionInfo.expireNow();
		}
		
		//세션, 시큐리티홀더 등록
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60 * 30);
		sessionRegistry.registerNewSession(session.getId(), authentication.getPrincipal());
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
	
	//	로그인후 회원 인증 정보 등록
	public void setMember(Member member, HttpServletRequest request) {
		
        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        
        if(member.getMtType() == 10) {
        	if(member.getMtGrant() == 1) {
        		roles.add(new SimpleGrantedAuthority("ROLE_MASTER"));
        	}
        	roles.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        }else if(member.getMtType() == 1) {
        	roles.add(new SimpleGrantedAuthority("ROLE_USER"));
        }else {
        	return;
        }
        
        HttpSession session = request.getSession();
		session.setAttribute("session_member", member);
        
        User user = new User(member.getMtId(), passwordEncoder.encode(member.getMtPwd()), roles);
        Authentication authentication = new UsernamePasswordAuthenticationToken(user, null, roles);
        onAuthentication(authentication, request, null);
	}
	
	
//	세션리스트에서 등록된 회원 아이디 불러오기
	public void getLoginMembers() {
		List<Object> principals = sessionRegistry.getAllPrincipals();
		for (Object principal: principals) {
		    if (principal instanceof User) {
		    	User user = (User) principal;
		    	log.debug(user.getUsername());
		    }
		}
	}

}