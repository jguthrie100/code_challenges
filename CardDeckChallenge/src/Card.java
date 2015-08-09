
public class Card {
	
	private int suit;
	private int cardNum;
	
	public Card(int suit, int cardNum) {
		setSuit(suit);
		setCardNum(cardNum);
	}

	public int getSuit() {
		return suit;
	}
	
	public int getCardNum() {
		return cardNum;
	}
	
	public String getSuitName() {
		switch(suit) {
		case 1:	return "Hearts";
		case 2:	return "Diamonds";
		case 3: return "Clubs";
		case 4: return "Spades";
		}
		
		return "";
	}
	
	public String getCardName() {
		switch(cardNum) {
		case 11: return "Jack";
		case 12: return "Queen";
		case 13: return "King";
		case 14: return "Ace";
		}
		
		return "" + cardNum;
	}
	
	/*
	 * Set suit. Must be between 1-4
	 * 1 = Hearts
	 * 2 = Diamonds
	 * 3 = Clubs
	 * 4 = Spades
	 */
	public void setSuit(int suit)
			throws IndexOutOfBoundsException {
		if(suit < 1 || suit > 4) {
			throw new IndexOutOfBoundsException("Suit: " + suit + ". Must be between 1-4");
		}
		this.suit = suit;
	}
	
	/*
	 * Set card num. Must be between 2-14
	 * Jack = 11
	 * Queen = 12
	 * King = 13
	 * Ace = 14
	 */
	public void setCardNum(int cardNum)
			throws IndexOutOfBoundsException {
		if(cardNum < 2 || cardNum > 14) {
			throw new IndexOutOfBoundsException("cardNum: " + cardNum + ". Must be between 2-14");
		}
		this.cardNum = cardNum;
	}
}
