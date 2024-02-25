package com.wave.dto.type;

public enum ECategory {

    EMERGENCY,
    ALERT,
    CAUTION,
    NONE


    ;

    public static ECategory fromString(String category){
        return ECategory.valueOf(category.toUpperCase());
    }
}
