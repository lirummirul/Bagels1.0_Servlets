package org.example.dto;

import lombok.*;
import org.example.model.Menu;
import org.example.model.User;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
@Builder
public class MenuDto {
    Long id;
    String name;
    Integer price_per_piece;
    Integer count;
    String in_total;
    String description;
    User account;

    public static MenuDto from(Menu menu){
        return MenuDto.builder()
                .id(menu.getId())
                .name(menu.getName())
                .price_per_piece(menu.getPrice_per_piece())
                .count(menu.getCount())
                .in_total(menu.getIn_total())
                .description(menu.getDescription()).build();
    }
}