package com.wave.repository;

import com.wave.domain.Country;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CountryRepository extends JpaRepository<Country, Long> {

    @Query("SELECT c FROM Country c WHERE c.category IN (com.wave.dto.type.ECategory.EMERGENCY, com.wave.dto.type.ECategory.ALERT, com.wave.dto.type.ECategory.CAUTION)")
    List<Country> findCountriesByCategories();

    @Query("SELECT c FROM Country c WHERE c.isDonate = true")
    List<Country> findByDonateTrue();

}
