package org.example.servlets;

import org.example.dto.UserForm;
import org.example.listener.InitListener;
import org.example.services.SignUpService;
import org.example.services.impl.ValidationServiceImpl;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signUp")
public class SignUpServlet extends HttpServlet {
    private SignUpService signUpService;
    private ValidationServiceImpl validationService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        ServletContext servletContext = config.getServletContext();
        validationService = (ValidationServiceImpl) servletContext.getAttribute("validationService");
        signUpService = (SignUpService) servletContext.getAttribute("signUpService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;  " + InitListener.ENCODING);
        resp.setCharacterEncoding(InitListener.ENCODING);
        String username = req.getParameter("username");
        if (username != null) {
            if (validationService.username_is_not_taken(username)) {
                resp.getWriter().write("Valid");
            } else
                resp.getWriter().write("Invalid");
        } else {
            req.getRequestDispatcher("WEB-INF/view/signup.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        signUpService.signUp(
                UserForm.builder()
                        .login(req.getParameter("username"))
                        .password(req.getParameter("password"))
                        .build());
        resp.sendRedirect("/login");
    }
}
