package com.wilkom.dockerdemo.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wilkom.dockerdemo.dto.PlayerDTO;
import com.wilkom.dockerdemo.model.Player;
import com.wilkom.dockerdemo.repository.PlayerRepository;

@Service
public class PlayerService {
    @Autowired
    private PlayerRepository playerRepository;

    /**
     * Persists a player into the Db
     * 
     * @param player
     * @return A PlayerDto object
     */
    public PlayerDTO savePlayer(Player player) {
        Player saved = playerRepository.save(player);
        return PlayerDTO.convertPlayerToPlayerDTO(saved);
    }

    /**
     * Find a player in DB from his ID
     * 
     * @param id
     * @return A PlayerDto object
     */
    public PlayerDTO getPlayerById(Long id) {
        Optional<Player> found = playerRepository.findById(id);
        if (found.isEmpty())
            return null;
        return PlayerDTO.convertPlayerToPlayerDTO(found.get());
    }
}
