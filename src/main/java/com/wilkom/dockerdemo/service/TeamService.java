package com.wilkom.dockerdemo.service;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wilkom.dockerdemo.dto.TeamDTO;
import com.wilkom.dockerdemo.model.Team;
import com.wilkom.dockerdemo.repository.TeamRepository;

@Service
public class TeamService {
    @Autowired
    private TeamRepository teamRepository;

    /**
     * Persists or put a team object into DB
     * 
     * @param team
     * @return A saved TeamDto object
     */
    public TeamDTO saveTeam(Team team) {
        Team saved = teamRepository.save(team);
        return TeamDTO.convertTeamToTeamDTO(saved);
    }

    /**
     * Find a team dto by its year
     * 
     * @param year
     * @return A found TeamDto object from its year
     */
    public TeamDTO getTeamByYear(Long year) {
        Optional<Team> foundTeam = teamRepository.findByTeamYear(year);
        if (!foundTeam.isEmpty())
            return TeamDTO.convertTeamToTeamDTO(foundTeam.get());
        return null;
    }
}
