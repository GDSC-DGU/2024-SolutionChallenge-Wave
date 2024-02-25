package com.wave.repository;

import com.wave.domain.Country;
import com.wave.domain.DonationCountry;
import com.wave.domain.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DonationCountryRepository extends JpaRepository<DonationCountry, Long>{

    Optional<DonationCountry> findByUserAndCountry(User user, Country country);

    List<DonationCountry> findByUser(User user);

    @Modifying
    @Query("DELETE FROM DonationCountry dc WHERE dc.user.id = :userId")
    void deleteByUserId(@Param("userId") Long userId);
}
