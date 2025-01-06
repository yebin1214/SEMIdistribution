package com.kh.user.model.vo;

import java.sql.Timestamp;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter@Setter@Builder

public class Review {
    private int reviewNo;
    private int reviewWriter;
    private int productNo;
    private String reviewContent;
    private Timestamp reviewDate;
    private int reviewScore;
    private char reviewStatus;
		
	}
    // Getters and Setters
