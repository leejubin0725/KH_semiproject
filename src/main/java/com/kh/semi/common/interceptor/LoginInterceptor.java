package com.kh.semi.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.user.model.vo.User;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		
		if (loginUser != null) {
			return true;
		} else {

			session.setAttribute("alertMsg", "로그인 후 이용할 수 있습니다.");

			response.sendRedirect(request.getContextPath());
			
			return false;
		}
	}

}
