package com.home;

public class Pack {

	private Card card;
	private String trump;

	public Pack(Card card, String trump) {
		this.card = card;
		this.trump = trump;
	}
	
	public boolean checkAndChange() {
		if (card.isTrumpValue(trump)) {
			//return card.setRankValue("A");
		}
		return card.setRankValue("A");
		//return false;
	}

}
