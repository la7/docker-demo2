package com.wilkom.dockerdemo.dto;

import java.util.Set;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;

import com.wilkom.dockerdemo.model.Team;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * DTO class to manage Players
 * 
 * @author Wilson
 * @version 1.0
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TeamDTO {
    private long id;
    private String coach;
    private long teamYear;
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private Set<PlayerDTO> players;

    public static TeamDTO convertTeamToTeamDTO(Team team) {
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration()
                .setMatchingStrategy(MatchingStrategies.LOOSE);
        TeamDTO dto = modelMapper.map(team, TeamDTO.class);
        if (team.getPlayers() != null) {
            dto.setPlayers(team.getPlayers().stream().map(p -> PlayerDTO.convertPlayerToPlayerDTO(p))
                    .collect(Collectors.toSet()));
        }
        return dto;
    }
}