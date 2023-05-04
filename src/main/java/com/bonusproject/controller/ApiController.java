package com.bonusproject.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@RestController
@RequestMapping("/api")
public class ApiController {

    private Logger logger = Logger.getLogger("ApiController");
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
    public ResponseEntity<?> getATableData(@RequestParam(required = true) String tableName) {
        String sql = "SELECT * FROM "+ tableName;
        try {
            List<Map<String, Object>> tableData = jdbcTemplate.queryForList(sql);
            logger.info("** Data retrieved successfully **");
            return ResponseEntity.ok(tableData);
        } catch (Exception e) {
            String errorMessage = "Error retrieving table data: " + e.getMessage();
            logger.info("** Error retrieving table data: " + e.getLocalizedMessage() + " **");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorMessage);
        }
    }
}