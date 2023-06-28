package org.example.dto;

import lombok.*;
import org.example.model.User;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@EqualsAndHashCode
public class MenuForm {
    Long id;
    String name;
    Integer price_per_piece;
    Integer count;
    String in_total;
    String description;
    User account;
}