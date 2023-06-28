package org.example.servlets.main;

import org.example.dto.UserDto;
import org.example.model.User;
import org.example.model.Menu;
import org.example.services.impl.MenusServiceImpl;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
// djbsk
@WebServlet("/menu/like")
public class LikeMenuServlet extends HttpServlet {
    MenusServiceImpl menusServiceImpl;
    @Override
    public void init(ServletConfig config) throws ServletException {
        menusServiceImpl = (MenusServiceImpl) config.getServletContext().getAttribute("menusService");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        menusServiceImpl.like(Menu.builder().id(Long.parseLong(req.getParameter("id"))).build(), User.from((UserDto) req.getSession().getAttribute("user")));
        resp.setStatus(200);
        resp.getWriter().write("done");
    }
}
