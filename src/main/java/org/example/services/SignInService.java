package org.example.services;

import org.example.dto.UserDto;
import org.example.dto.UserForm;

public interface SignInService {
    UserDto signIn(UserForm userForm);
}
