package com.wave.repository;

import com.wave.domain.Country;
import com.wave.domain.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface NewsRepository extends JpaRepository<News, Long> {

    @Modifying
    @Query("DELETE FROM News n WHERE n.country = :country")
    void deleteAllByCountry(@Param("country") Country country);
}
