package com.bonusproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UpdateTableController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/update")
    public String showUpdateForm() {
        return "update";
    }

    @PostMapping("/updateTable")
    public String updateTable(@RequestParam("query") String query, Model model) {
        try {
            jdbcTemplate.update(query);
            model.addAttribute("message", "Update successful!");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "result";
    }

}
