package org.example.dao.impl;

import org.example.dao.UsersRepository;
import org.example.model.User;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.util.List;
import java.util.Optional;

public class UsersRepositoryJdbcTempleteImpl implements UsersRepository {
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<User> userRowMapper = (row, rowNumber) ->
            User.builder()
                    .login(row.getString("login"))
                    .password_hash(row.getString("password_hash")).build();

    public UsersRepositoryJdbcTempleteImpl(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public Optional<User> findByLogin(String login) {
        //language=sql
        String sql_find = "select * from account where login = ?";
        try {
            return Optional.ofNullable(jdbcTemplate.queryForObject(sql_find, userRowMapper, login));
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    @Override
    public void save(User entity) {
        String sql_save = "insert into account(login, password_hash) values (?, ?)";
        jdbcTemplate.update(sql_save, entity.getLogin(), entity.getPassword_hash());
    }

    @Override
    public List<User> findAll() {
        //language=sql
        String sql_findAll = "select * from account";
        return jdbcTemplate.query(sql_findAll, userRowMapper);
    }
}
