package org.example.services.impl;

import org.example.dao.UsersRepository;
import org.example.dto.UserDto;
import org.example.dto.UserForm;
import org.example.model.User;
import org.example.services.SignInService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

public class SignInServiceImpl implements SignInService {

    UsersRepository usersRepository;
    PasswordEncoder passwordEncoder;

    public SignInServiceImpl(UsersRepository usersRepository, PasswordEncoder passwordEncoder) {
        this.usersRepository = usersRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDto signIn(UserForm userForm) {
        User user = usersRepository.findByLogin(userForm.getLogin()).orElse(null);
        if (user == null) throw new UsernameNotFoundException("Неправильное имя пользователя или пароль");
        if (passwordEncoder.matches(userForm.getPassword(), user.getPassword_hash())) return UserDto.from(user);
        else throw new UsernameNotFoundException("Неправильное имя пользователя или пароль");
    }
}
