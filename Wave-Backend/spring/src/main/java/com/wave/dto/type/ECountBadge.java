package com.wave.dto.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ECountBadge {
    FIRST_COUNT_BADGE("first donation badge"),
    SECOND_COUNT_BADGE("fifth donation badge"),
    THIRD_COUNT_BADGE("tenth donation badge"),
    FOURTH_COUNT_BADGE("fifty donation badge"),
    FIFTH_COUNT_BADGE("hundred donation badge"),

    ;

    private final String description;




}