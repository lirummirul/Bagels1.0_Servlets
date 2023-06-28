package org.example.servlets.main;

import org.example.dto.UserDto;
import org.example.listener.InitListener;
import org.example.model.Menu;
import org.example.services.impl.MenusServiceImpl;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/menus")
public class MainServlets extends HttpServlet {
    MenusServiceImpl menusServiceImpl;
    @Override
    public void init(ServletConfig config) throws ServletException {
        ServletContext servletContext = config.getServletContext();
        menusServiceImpl = (MenusServiceImpl) servletContext.getAttribute("menusService");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding(InitListener.ENCODING);
        List<Menu> menus = menusServiceImpl.menus();
        UserDto userDto = ((UserDto)req.getSession().getAttribute("user"));
        req.setAttribute("menus", menus);
        req.setAttribute("user", userDto);
        req.getRequestDispatcher("/WEB-INF/view/menus.jsp").forward(req, resp);
    }
}