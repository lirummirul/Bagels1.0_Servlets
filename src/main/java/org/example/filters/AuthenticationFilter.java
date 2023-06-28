package org.example.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        HttpSession session = request.getSession(false);
        boolean isAuthenticated = false;
        boolean sessionExists = session != null;
        String requestUri = request.getRequestURI();
        boolean isRequestOnOpenPage = requestUri.equals("/login") ||
                requestUri.equals("/signUp") || requestUri.equals("/menus") || requestUri.equals("/menu");
        boolean isRequestOnPageWithNoNeedToAuthorize = requestUri.equals("/menus")
                || requestUri.equals("/menu");
        if (sessionExists) {
            isAuthenticated = session.getAttribute("user") != null;
        }

        if (isAuthenticated && !isRequestOnOpenPage || !isAuthenticated && isRequestOnOpenPage || isRequestOnPageWithNoNeedToAuthorize) {
            filterChain.doFilter(request, response);
        } else if (isAuthenticated) {
            response.sendRedirect("/profile");
        } else {
            response.sendRedirect("/login");
        }

    }
}
