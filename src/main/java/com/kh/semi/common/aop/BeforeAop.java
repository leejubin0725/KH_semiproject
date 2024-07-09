package com.kh.semi.common.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class BeforeAop {
	@Before(value = "CommonPointCut.implPointCut()")
	public void beforeService(JoinPoint jp) {
		log.debug("start : " + jp.getTarget().getClass().getSimpleName() + "-" + jp.getSignature().getName());
		log.debug("(" + Arrays.toString(jp.getArgs()) + ")");
	}
}
