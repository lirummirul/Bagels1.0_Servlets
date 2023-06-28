package org.example.servlets.main;

import org.example.dto.UserDto;
import org.example.listener.InitListener;
import org.example.model.User;
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

@WebServlet("/menu")
public class MainMenuServlet extends HttpServlet {
    MenusServiceImpl menusServiceImpl;
    @Override
    public void init(ServletConfig config) throws ServletException {
        ServletContext context = config.getServletContext();
        menusServiceImpl = (MenusServiceImpl) context.getAttribute("menusService");
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Long id = Long.parseLong(req.getParameter("id"));
        Menu menu = menusServiceImpl.findMenu(id).orElse(null);
        if (menu == null) {
            resp.sendError(404);
            return;
        }
        req.setAttribute("menu", menu);
        if (req.getSession().getAttribute("user") != null){
            req.setAttribute("is_liked", menusServiceImpl.is_liked(menu, User.from((UserDto) req.getSession().getAttribute("user"))));
            req.setAttribute("user", req.getSession().getAttribute("user"));
        }
        resp.setCharacterEncoding(InitListener.ENCODING);
        req.getRequestDispatcher("/WEB-INF/view/menu.jsp").forward(req, resp);
    }
}
