package com.wilkom.dockerdemo.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Entity class to persist all players
 * 
 * @author Wilson
 * @version 1.0
 */
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Player {
    @Id
    private Long number;
    private String name;
    private String lastname;
    private PositionEnum position;
    private Boolean isCaptain;
    @ManyToOne
    private Team team;
}
