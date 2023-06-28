package org.example.dto;

import org.example.model.User;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Getter
@Setter
@Builder
public class UserDto {
    String login;

    public static UserDto from(User user){
        return UserDto.builder().
        login(user.getLogin()).build();
    }
}
