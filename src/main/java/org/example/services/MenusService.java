package org.example.services;

import org.example.model.User;
import org.example.model.Menu;

import java.util.List;
import java.util.Optional;

public interface MenusService {
    List<Menu> menus();
    Optional<Menu> findMenu(Long id);
    void like(Menu menu, User user);
    void unlike(Menu menu, User user);
    boolean is_liked(Menu menu, User user);
    List<Menu> saved(User user);

}
