package com.kh.semi.common.aop;

import org.aspectj.lang.annotation.Pointcut;

public class CommonPointCut {
	
	@Pointcut("execution(* com.kh.semi..*Impl.*(..))")
	public void implPointCut() {}

}
