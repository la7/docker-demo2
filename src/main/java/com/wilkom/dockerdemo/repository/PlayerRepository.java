package com.wilkom.dockerdemo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.wilkom.dockerdemo.model.Player;

@Repository
public interface PlayerRepository extends JpaRepository<Player, Long> {

}