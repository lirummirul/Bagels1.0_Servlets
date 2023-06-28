package org.example.servlets;

import org.example.dto.UserDto;
import org.example.dto.UserForm;
import org.example.services.SignInService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class SignInServlet extends HttpServlet {

    private SignInService signInService;

    @Override
    public void init(ServletConfig config) {
        ServletContext context = config.getServletContext();
        signInService = (SignInService) context.getAttribute("signInService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("auth_error", req.getAttribute("auth_error"));
        req.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            UserDto userDto = signInService.signIn(UserForm.builder()
                    .login(req.getParameter("username"))
                    .password(req.getParameter("password"))
                    .build());
            HttpSession session = req.getSession();
            session.setAttribute("user", userDto);
            resp.sendRedirect("/profile");
        } catch (UsernameNotFoundException e) {
            req.setAttribute("auth_error", e.getMessage());
            doGet(req, resp);
        }

    }
}
