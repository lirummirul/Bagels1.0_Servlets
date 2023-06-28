package org.example.listener;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.util.StdDateFormat;
import org.example.dao.impl.UsersRepositoryJdbcTempleteImpl;
import org.example.dao.impl.MenuRepositoryJdbcTemplateImpl;
import org.example.dao.*;
import org.example.services.*;
import org.example.services.impl.*;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class InitListener implements ServletContextListener {
    public static final String ENCODING = "UTF-8";
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://localhost:5432/Menu1");
        dataSource.setUsername("postgres");
        dataSource.setPassword("postgres");

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        UsersRepository usersRepository = new UsersRepositoryJdbcTempleteImpl(dataSource);
        MenuRepository menusRepository = new MenuRepositoryJdbcTemplateImpl(dataSource, usersRepository);

        ValidationServiceImpl validationService = new ValidationServiceImpl(usersRepository);
        MenusServiceImpl menusServiceImpl = new MenusServiceImpl(menusRepository);
        SignUpService signUpService = new SignUpServiceImpl(usersRepository, passwordEncoder, validationService);
        SignInService signInService = new SignInServiceImpl(usersRepository, passwordEncoder);

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        StdDateFormat dateFormat = new StdDateFormat().withColonInTimeZone(true);
        objectMapper.setDateFormat(dateFormat);
        servletContext.setAttribute("objectMapper", objectMapper);
        servletContext.setAttribute("signUpService", signUpService);
        servletContext.setAttribute("signInService", signInService);
        servletContext.setAttribute("validationService", validationService);
        servletContext.setAttribute("menusService", menusServiceImpl);
    }
}
