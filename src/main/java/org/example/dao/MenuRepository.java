package org.example.dao;

import org.example.model.User;
import org.example.model.Menu;

import java.util.List;
import java.util.Optional;

public interface MenuRepository extends CrudRepository<Menu> {
    List<Menu> menuOf(String login);
    Optional<Menu> findById(Long id);
    void like(Menu menu, User user);
    void unlike(Menu menu, User user);
    boolean is_liked(Menu menu, User user);
    List<Menu> liked(User user);
}
