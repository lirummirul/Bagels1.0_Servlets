package org.example.services.impl;

import org.example.dao.MenuRepository;
import org.example.model.User;
import org.example.model.Menu;
import org.example.services.MenusService;

import java.util.List;
import java.util.Optional;

public class MenusServiceImpl implements MenusService {
    private MenuRepository menuRepository;

    public MenusServiceImpl(MenuRepository menuRepository) {
        this.menuRepository = menuRepository;
    }

    public List<Menu> menus(){
        return menuRepository.findAll();
    }
    public Optional<Menu> findMenu(Long id){
        return menuRepository.findById(id);
    }
    public void like(Menu menu, User user){
        menuRepository.like(menu, user);
    }
    public void unlike(Menu menu, User user){
        menuRepository.unlike(menu, user);
    }
    public boolean is_liked(Menu menu, User user){
        return menuRepository.is_liked(menu, user);
    }
    public List<Menu> saved(User user){
        return menuRepository.liked(user);
    }
}
