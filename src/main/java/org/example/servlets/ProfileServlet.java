package org.example.servlets;

import org.example.dto.UserDto;
import org.example.listener.InitListener;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html" + InitListener.ENCODING);
        resp.setCharacterEncoding(InitListener.ENCODING);
        UserDto userDto = (UserDto) req.getSession().getAttribute("user");
        req.setAttribute("username", userDto.getLogin());
        req.getRequestDispatcher("WEB-INF/view/profile.jsp").forward(req, resp);
    }
}
