package com.home;

public class Card {

	private String suite;
	private String rank;

	public Card(String suite, String rank) {
		this.suite = suite;
		this.rank = rank;		
	}

	String getSuiteValue() {
		return suite;
	}
	
	String getRankValue() {
		return rank;
	}
	
	public boolean setRankValue(String rank) {
		this.rank = rank;
		return true;
	}
	
	boolean isTrumpValue(String suite) {
		return false;
	}

}
