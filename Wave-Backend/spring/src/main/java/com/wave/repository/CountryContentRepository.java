package com.wave.repository;

import com.wave.domain.CountryContent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CountryContentRepository extends JpaRepository<CountryContent, Long> {
}
