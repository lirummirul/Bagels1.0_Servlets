package org.example.servlets.main;

import org.example.dto.UserDto;
import org.example.listener.InitListener;
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
import java.util.List;

@WebServlet("/profile/menus/saved")
public class SavedMenusServlet extends HttpServlet {
    MenusServiceImpl menusServiceImpl;
    @Override
    public void init(ServletConfig config) throws ServletException {
        menusServiceImpl = (MenusServiceImpl) config.getServletContext().getAttribute("menusService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding(InitListener.ENCODING);
        List<Menu> menuList = menusServiceImpl.saved(User.from((UserDto) req.getSession().getAttribute("user")));
        req.setAttribute("menus", menuList);
        req.setAttribute("user", req.getSession().getAttribute("user"));
        System.out.println(req.getSession().getAttribute("user") + " qweqweqweqwe1");
        req.getRequestDispatcher("/WEB-INF/view/saved_menus.jsp").forward(req, resp);
    }
}
