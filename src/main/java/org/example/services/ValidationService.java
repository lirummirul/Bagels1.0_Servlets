package org.example.services;

import org.example.dto.UserDto;
import org.example.model.Menu;

public interface ValidationService {
    boolean username_is_valid(String username);
    boolean editing_or_deleting_is_permited(UserDto userDto, Menu menu);
}
