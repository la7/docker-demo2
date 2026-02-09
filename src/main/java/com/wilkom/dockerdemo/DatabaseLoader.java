package com.wilkom.dockerdemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.wilkom.dockerdemo.dto.TeamDTO;
import com.wilkom.dockerdemo.model.Team;
import com.wilkom.dockerdemo.service.TeamService;

import lombok.extern.slf4j.Slf4j;

/**
 * This class is to preload data
 */
@Component
@Slf4j
public class DatabaseLoader implements CommandLineRunner {

    @Autowired
    TeamService teamService;

    @Override
    public void run(String... args) throws Exception {
        Team team = new Team(1L, "Emmanuel ADEBAYOR", 2022, null);
        TeamDTO t = teamService.saveTeam(team);
        log.info(t.toString());
    }
}
