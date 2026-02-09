package com.wilkom.dockerdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wilkom.dockerdemo.dto.PlayerDTO;
import com.wilkom.dockerdemo.model.Player;
import com.wilkom.dockerdemo.model.Team;
import com.wilkom.dockerdemo.service.PlayerService;

/**
 * Global API controller class to expose players resource endpoints
 * 
 * @author Wilson
 * @version 1.0
 */
@RestController
@RequestMapping("/api/player")
public class PlayerController {
    @Autowired
    private PlayerService playerService;

    /**
     * Exposes /api/player/captain/{ID} endpoint
     * 
     * @param id
     * @return a PlayerDto json object if found
     */
    @PutMapping("/captain/{ID}")
    public ResponseEntity<?> updateYearTeamCaptain(@PathVariable("ID") Long id) {
        PlayerDTO playerDto = playerService.getPlayerById(id);
        if (playerDto == null) {
            return new ResponseEntity<>("ID not found", HttpStatus.NOT_FOUND);
        }
        Player player = new Player(playerDto.getNumber(), playerDto.getName(), playerDto.getLastname(),
                playerDto.getPosition(), playerDto.getIsCaptain(), null);
        Team team = new Team(playerDto.getTeam().getId(), playerDto.getTeam().getCoach(), playerDto.getTeam().getTeamYear(),
                null);
        player.setIsCaptain(true);
        player.setTeam(team);

        return new ResponseEntity<>(playerService.savePlayer(player), HttpStatus.OK);
    }

}
