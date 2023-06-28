package org.example.model;

import org.example.dto.MenuForm;
import org.example.dto.MenuDto;
import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@EqualsAndHashCode
public class Menu {
    Long id;
    String name;
    Integer price_per_piece;
    Integer count;
    String in_total;
    String description;
    User account;

    public static Menu from(MenuForm menuForm){
        return Menu.builder()
                .id(menuForm.getId())
                .name(menuForm.getName())
                .price_per_piece(menuForm.getPrice_per_piece())
                .count(menuForm.getCount())
                .in_total(menuForm.getIn_total())
                .description(menuForm.getDescription()).build();
    }
}
