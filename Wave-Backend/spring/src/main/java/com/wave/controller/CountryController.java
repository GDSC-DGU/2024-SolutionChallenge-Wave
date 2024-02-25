package com.wave.controller;

import com.wave.dto.common.ResponseDto;
import com.wave.dto.request.CountryDataListDto;
import com.wave.dto.response.CrawlingDto;
import com.wave.service.CountryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/countries")
public class CountryController {

    private final CountryService countryService;

    // 1.0 지도 가져오기
    @GetMapping
    public ResponseDto<?> getCountries() {
        return ResponseDto.ok(countryService.getCountries());
    }

    // 1.1 지도에서 기부 가능 지역 눌렀을 때
    @GetMapping("/donate/{countryId}")
    public ResponseDto<?> getDonateCountry(@PathVariable("countryId") Long countryId) {
        return ResponseDto.ok(countryService.getDonateCountry(countryId));
    }

    //1.2 기부 가능 지역 디테일
    @GetMapping("/donate/{countryId}/details")
    public ResponseDto<?> getDonateCountryDetails(@PathVariable("countryId") Long countryId) {
        return ResponseDto.ok(countryService.getDonateCountryDetails(countryId));
    }

    //1.3 지도에서 기부 불가능 지역 눌렀을 때
    @GetMapping("/search/{countryId}")
    public ResponseDto<?> getSearchCountry(@PathVariable("countryId") Long countryId) {
        return ResponseDto.ok(countryService.getSearchCountry(countryId));
    }

    //1.4 기부 불가능 지역 디테일
    @GetMapping("/search/{countryId}/details")
    public ResponseDto<?> getSearchCountryDetails(@PathVariable("countryId") Long countryId) {
        return ResponseDto.ok(countryService.getSearchCountryDetails(countryId));
    }

    //1.5 기부 가능 탭
    @GetMapping("/donate")
    public ResponseDto<?> getDonateCountries() {
        return ResponseDto.ok(countryService.getDonateCountries());
    }

    //1.6 기부 불가능 탭
    @GetMapping("/search")
    public ResponseDto<?> getSearchCountries() {
        return ResponseDto.ok(countryService.getSearchCountries());
    }

    //================================================================================================
    // 백앤드 데이터 컨트롤러

    // 나라 데이터 저장하기
    // DB 초기화 이후에 사용
    @PostMapping("/countryData")
    public ResponseDto<?> saveCountryData(@RequestBody CountryDataListDto countryDataListDto) {
        countryService.saveCountryData(countryDataListDto);
        return ResponseDto.ok(null);
    }

    // flask로부터 크롤링한 데이터 저장하기
    // 24시간에 한번씩 사용
    @PostMapping("/crawling-news")
    public ResponseDto<?> crawlingNews(@RequestBody CrawlingDto crawlingDto) {
        countryService.updateCountryNews(crawlingDto);
        return ResponseDto.ok(null);
    }


}
