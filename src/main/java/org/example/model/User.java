package org.example.model;

import org.example.dto.UserDto;
import lombok.*;

@Getter
@Setter
@Builder
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class User {
    String login;
    String password_hash;

    public static User from(UserDto userDto){
        return User.builder()
                .login(userDto.getLogin()).build();
    }
}
