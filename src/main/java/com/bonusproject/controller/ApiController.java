package com.bonusproject.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@RestController
@RequestMapping("/api")
public class ApiController {

    private Logger logger = Logger.getLogger("TestController");
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/items")
    public List<Map<String, Object>> getAllItems() {
        String sql = "SELECT * FROM items";
        List<Map<String, Object>> items = jdbcTemplate.queryForList(sql);
        return items;
    }

    @GetMapping("/entities")
    public List<Map<String, Object>> getAllEntities() {
        String sql = "SELECT * FROM busEntities";
        List<Map<String, Object>> entites = jdbcTemplate.queryForList(sql);
        return entites;
    }

    @GetMapping("/table")
    public List<Map<String, Object>> getATableData(@RequestParam String tableName) {
        logger.info("*******" + tableName);
        String sql = "SELECT * FROM "+ tableName;
        logger.info(sql);
        List<Map<String, Object>> tableData = jdbcTemplate.queryForList(sql);
        return tableData;
    }
}