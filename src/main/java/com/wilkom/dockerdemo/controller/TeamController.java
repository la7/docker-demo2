package com.wilkom.dockerdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wilkom.dockerdemo.dto.PlayerDTO;
import com.wilkom.dockerdemo.dto.TeamDTO;
import com.wilkom.dockerdemo.model.Player;
import com.wilkom.dockerdemo.model.Team;
import com.wilkom.dockerdemo.service.PlayerService;
import com.wilkom.dockerdemo.service.TeamService;

/**
 * Global API controller class to expose team resource endpoints
 * 
 * @author Wilson
 * @version 1.0
 */
@RestController
@RequestMapping("/api/team")
public class TeamController {
    @Autowired
    private TeamService teamService;
    @Autowired
    private PlayerService playerService;

    /**
     * Exposes /api/team/{year} endpoint
     * 
     * @param year
     * @return a Team object
     */
    @GetMapping("/{year}")
    public ResponseEntity<?> getTeamFromAYear(@PathVariable Long year) {
        TeamDTO dto = teamService.getTeamByYear(year);
        if (dto == null) {
            return new ResponseEntity<>("Year not found", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(dto, HttpStatus.OK);
    }

    /**
     * Exposes /api/team/{year} endpoint
     * 
     * @param year
     * @param playerDto
     * @return a Created player json object if year found
     */
    @PostMapping("/{Year}")
    public ResponseEntity<?> savePlayerDto(@PathVariable("Year") Long year, @RequestBody PlayerDTO playerDto) {
        TeamDTO teamDto = teamService.getTeamByYear(year);
        if (teamDto == null) {
            return new ResponseEntity<>("Year not found", HttpStatus.NOT_FOUND);
        }
        Team team = new Team(teamDto.getId(), teamDto.getCoach(), teamDto.getTeamYear(), null);
        Player player = new Player(playerDto.getNumber(), playerDto.getName(), playerDto.getLastname(),
                playerDto.getPosition(), playerDto.getIsCaptain(), team);

        return new ResponseEntity<>(playerService.savePlayer(player), HttpStatus.CREATED);
    }
}
