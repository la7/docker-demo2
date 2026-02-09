package com.wilkom.dockerdemo.dto;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.wilkom.dockerdemo.model.Player;
import com.wilkom.dockerdemo.model.PositionEnum;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO class to manage Players
 * 
 * @author Wilson
 * @version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlayerDTO {
    private Long number;
    private String name;
    private String lastname;
    private PositionEnum position;
    private Boolean isCaptain;
    @JsonIgnore
    private TeamDTO team;

    public static PlayerDTO convertPlayerToPlayerDTO(Player player) {
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration()
                .setMatchingStrategy(MatchingStrategies.LOOSE);

        return modelMapper.map(player, PlayerDTO.class);
    }

}