package org.example.dao.impl;

import org.example.dao.UsersRepository;
import org.example.dao.MenuRepository;
import org.example.model.User;
import org.example.model.Menu;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MenuRepositoryJdbcTemplateImpl implements MenuRepository {
    private final JdbcTemplate jdbcTemplate;
    private UsersRepository usersRepository;

    private final RowMapper<Menu> rowMapper = (row, rowNumber) -> Menu.builder()
            .id(row.getLong("id"))
            .name(row.getString("name"))
            .price_per_piece(row.getInt("price_per_piece"))
            .count(row.getInt("count"))
            .in_total(row.getString("in_total"))
            .description(row.getString("description"))
            .account(usersRepository.findByLogin(row.getString("account")).orElse(null)).build();

    public MenuRepositoryJdbcTemplateImpl(DataSource dataSource, UsersRepository usersRepository) {
        jdbcTemplate = new JdbcTemplate(dataSource);
        this.usersRepository = usersRepository;
    }

    @Override
    public void save(Menu entity) {
        //language=sql
        String sql_save = "insert into menu(" +
                "name, " +
                "price_per_piece, " +
                "count, " +
                "in_total, " +
                "description, " +
                "account) values (current_timestamp,?,?,?,?,?,?)";
        jdbcTemplate.update(sql_save, entity.getName(), entity.getPrice_per_piece(),
                entity.getCount(), entity.getIn_total(),
                entity.getDescription(), entity.getAccount().getLogin());

    }

    @Override
    public List<Menu> findAll() {
        //language=sql
        String sql_find_all = "select * from menu";
        return jdbcTemplate.query(sql_find_all, rowMapper);
    }

    @Override
    public List<Menu> menuOf(String login) {
        //language=sql
        String sql_vacancies_of = "select * from menu where account = ?";
        return jdbcTemplate.query(sql_vacancies_of, rowMapper, login);
    }

    @Override
    public Optional<Menu> findById(Long id) {
        //language=sql
        String sql_find_by_id = "select * from menu where id = ?";
        try {
            return Optional.ofNullable(jdbcTemplate.queryForObject(sql_find_by_id, rowMapper, id));
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    @Override
    public void like(Menu menu, User user) {
        //language=sql
        String sql_like = "insert into favorite_blude(menu, account) values (?, ?)";
        jdbcTemplate.update(sql_like, menu.getId(), user.getLogin());
    }

    @Override
    public void unlike(Menu menu, User user) {
        //language=sql
        String sql_unlike = "delete from favorite_blude where menu = ? and account = ?";
        jdbcTemplate.update(sql_unlike, menu.getId(), user.getLogin());
    }

    public boolean is_liked(Menu menu, User user) {
        //language=sql
        String sql_is_liked = "select count(*) from favorite_blude where menu = ? and account = ?";

        return jdbcTemplate.queryForObject(sql_is_liked, Long.class, menu.getId(), user.getLogin()) >= 1;
    }

    public List<Menu> liked(User user){
        List<Menu> list = new ArrayList<>();
        //language=sql
        String sql_liked = "select menu from favorite_blude where account = ?";
        List<Long> listOfMenuIds = jdbcTemplate.queryForList(sql_liked, Long.class, user.getLogin());
        for (Long id: listOfMenuIds
        ) {
            list.add(findById(id).orElse(null));
        }
        return list;
    }
}
