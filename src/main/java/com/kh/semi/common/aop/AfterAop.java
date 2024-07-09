package com.kh.semi.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class AfterAop {
	
	@After(value = "CommonPointCut.implPointCut()")
	public void AfterService(JoinPoint jp) {
		log.debug("start : " + jp.getTarget().getClass().getSimpleName());
	}
}
