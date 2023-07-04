package net.huray.onco.service;

import org.springframework.stereotype.Service;

import net.huray.onco.domain.Member;
import net.huray.onco.repository.MemberRepository;

import java.util.List;

@Service
public class MemberService {
    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public List<Member> getAllMembers() {
        return memberRepository.findAll();
    }
}