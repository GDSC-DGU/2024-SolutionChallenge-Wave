package com.wave.service;

import com.wave.domain.Country;
import com.wave.domain.CountryContent;
import com.wave.domain.News;
import com.wave.dto.request.CountryDataListDto;
import com.wave.dto.response.*;
import com.wave.dto.type.ECategory;
import com.wave.dto.type.ErrorCode;
import com.wave.exception.CommonException;
import com.wave.repository.CountryContentRepository;
import com.wave.repository.CountryRepository;
import com.wave.repository.NewsRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class CountryService {

    private final CountryRepository countryRepository;
    private final CountryContentRepository countryContentRepository;
    private final NewsRepository newsRepository;

    @Value("${default.news.image.url}")
    private String DEFAULT_IMAGE_URL;

    // 1.0 지도 가져오기
    @Transactional(readOnly = true)
    public CountryInfoListDto getCountries() {
        List<Country> countries = countryRepository.findAll();

        List<Country> donateCountries = countries.stream()
                .filter(Country::isDonate)
                .toList();

        List<Country> emergencyCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.EMERGENCY)
                .collect(Collectors.toList());

        List<Country> alertCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.ALERT)
                .collect(Collectors.toList());

        List<Country> cautionCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.CAUTION)
                .collect(Collectors.toList());

        return CountryInfoListDto.of(emergencyCountries, alertCountries, cautionCountries, donateCountries);
    }

    // 1.1 지도에서 기부 가능 지역 눌렀을 때
    @Transactional(readOnly = true)
    public CountryDonateInfoDto getDonateCountry(Long countryId) {
        Country country = countryRepository.findById(countryId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNTRY));

        return CountryDonateInfoDto.of(country);
    }

    //1.2 기부 가능 지역 디테일
    @Transactional(readOnly = true)
    public CountryDonateDetailsInfoDto getDonateCountryDetails(Long countryId) {
        Country country = countryRepository.findById(countryId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNTRY));

        return CountryDonateDetailsInfoDto.of(country);
    }

    //1.3 지도에서 기부 불가능 지역 눌렀을 때
    @Transactional(readOnly = true)
    public CountrySearchInfoDto getSearchCountry(Long countryId) {
        Country country = countryRepository.findById(countryId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNTRY));

        return CountrySearchInfoDto.of(country);
    }

    //1.4 기부 불가능 지역 디테일
    @Transactional
    public CountrySearchDetailsInfoDto getSearchCountryDetails(Long countryId) {
        Country country = countryRepository.findById(countryId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNTRY));

        country.updateViews();
        return CountrySearchDetailsInfoDto.of(country);
    }

    //1.5 기부 가능 탭
    public CountryDonateListInfoDto getDonateCountries() {
        List<Country> countries = countryRepository.findByDonateTrue();
        return CountryDonateListInfoDto.of(countries);
    }

    //1.6 기부 불가능 탭
    public CountrySearchListInfoDto getSearchCountries() {
        List<Country> countries = countryRepository.findCountriesByCategories();

        List<Country> emergencyCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.EMERGENCY)
                .toList();

        List<Country> alertCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.ALERT)
                .toList();

        List<Country> cautionCountries = countries.stream()
                .filter(country -> country.getCategory() == ECategory.CAUTION)
                .toList();

        return CountrySearchListInfoDto.of(emergencyCountries, alertCountries, cautionCountries);
    }

    // 1시간마다 뉴스 업데이트
    @Transactional
    public void updateCountryNews(CrawlingDto crawlingDto) {
        log.info("crawlingDto : {}", crawlingDto.id());
        Country country = countryRepository.findById(crawlingDto.id())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COUNTRY));

        newsRepository.deleteAllByCountry(country);
        List<News> newsList = crawlingDto.data().stream()
                .map(newsDto -> News.createNews(
                        newsDto.newsImageUrl() != null && !newsDto.newsImageUrl().isEmpty() ? newsDto.newsImageUrl() : DEFAULT_IMAGE_URL,
                        newsDto.newsTitle(),
                        newsDto.newsUrl(),
                        newsDto.getParsedDate(),
                        country))
                .collect(Collectors.toList());
        newsRepository.saveAll(newsList);
    }

    // 처음 나라 데이터 저장
    @Transactional
    public void saveCountryData(CountryDataListDto countryDataListDto) {
        countryDataListDto.countryDataList().forEach(countryDataDto -> {
            Country country = Country.createCountry(
                    countryDataDto.id().longValue(),
                    countryDataDto.name(),
                    countryDataDto.koreanName(),
                    ECategory.fromString(countryDataDto.category()),
                    countryDataDto.isDonate(),
                    countryDataDto.casualties(),
                    countryDataDto.mainTitle(),
                    countryDataDto.subTitle(),
                    countryDataDto.imageUrl(),
                    countryDataDto.imageProducer(),
                    countryDataDto.detailImageUrl(),
                    countryDataDto.detailImageTitle(),
                    countryDataDto.detailImageProducer());

            CountryContent countryContent1 = CountryContent.createCountryContent(countryDataDto.title1(), countryDataDto.content1(), country);
            CountryContent countryContent2 = CountryContent.createCountryContent(countryDataDto.title2(), countryDataDto.content2(), country);

            country.addCountryContent(countryContent1);
            country.addCountryContent(countryContent2);

            countryRepository.save(country);
            countryContentRepository.save(countryContent1);
            countryContentRepository.save(countryContent2);
        });
    }


}
