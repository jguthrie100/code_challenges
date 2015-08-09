import java.util.ArrayList;
import java.util.List;


public class Deck {

	private static ArrayList<Card> deck;
	
	public Deck() {
		deck = new ArrayList<Card>();
		
		// Add cards to deck
		for(int i=1; i<=52; i++) {
			if(i <= 13) {
				// 13 hearts, starting from 2 of hearts
				deck.add(new Card(1, i+1));
				
			} else if(i <= 26) {
				// 13 diamonds, starting from 2 of diamonds
				deck.add(new Card(2, i-12));
				
			} else if(i <= 39) {
				// 13 clubs, starting from 2 of clubs
				deck.add(new Card(3, i-25));
				
			} else {
				// 13 spades, starting from 2 of spades
				deck.add(new Card(4, i-38));
			}
		}
	}
	
	public void shuffle() {
		// Grab random cards from Arraylist and copy to new ArrayList
		// Then copy new arraylist back over old arraylist
		
		ArrayList<Card> deck2 = new ArrayList<Card>();
		int randomNum;
		
		// Loop through arraylist, going from arraylist size down to 0
		for(int i=deck.size()-1; i>=0; i--) {
			
			// Get a random num within range of remaining arraylist size
			randomNum = (int) (Math.floor(Math.random()*i));
			
			// Add card to new deck/Remove from current deck
			deck2.add(deck.get(randomNum));
			deck.remove(randomNum);
		}
		
		// Copy shuffled deck back to original arraylist
		deck.clear();
		deck.addAll(deck2);
	}
	
	public List<Card> draw(int howMany)
			throws IndexOutOfBoundsException {
		
		if(howMany > deck.size()) {
			throw (new IndexOutOfBoundsException("Attempting to draw out more cards than there are cards left in deck. Cards requested: " + howMany + ", Cards left in deck: " + deck.size()));
		}
		if(howMany <= 0) {
			throw new IndexOutOfBoundsException("Must attempt to draw 1 or more cards. Attempted drawn cards: " + howMany);
		}
		
		List<Card> returnList = new ArrayList<Card>();
		
		for(int i=howMany-1; i>=0; i--) {
			returnList.add(deck.get(i));
			deck.remove(i);
		}
		
		return returnList;
	}
	
	public List<Card> drawSorted(int howMany)
			throws IndexOutOfBoundsException, RuntimeException {
		
		List<Card> cardsToSort = new ArrayList<Card>();   // Holds drawn cards
		List<Card> returnList = new ArrayList<Card>(); // Holds combined suit arraylists
		Card currentCard;
		int cardPos;

		// Draw howMany cards
		cardsToSort = draw(howMany);
		
		// Add the first card to the return list
		returnList.add(cardsToSort.get(0));
		cardsToSort.remove(0);
		
		// Loop through the list of drawn cards (and pick the card to be sorted)
		while(cardsToSort.size() > 0) {
			
			// pick current card (and remove from drawList)
			currentCard = cardsToSort.get(0);
			cardsToSort.remove(0);
			
			// Find out what position current card should go in and then place it there
			cardPos = cardPositionInList(currentCard, returnList, 0);
			returnList.add(cardPos, currentCard);
		}
		
		return returnList;
	}
	
	/*
	 * Specifies the position that the card should be placed in so the list is in order
	 */
	private int cardPositionInList(Card currentCard, List<Card> cardList, int startFrom)
			throws IndexOutOfBoundsException, RuntimeException {
		
		// Throw exception if an attempt is made to compare card to a non-existent index in array
		if(startFrom >= cardList.size() || startFrom < 0) {
			throw(new IndexOutOfBoundsException("Attempted to compare card using invalid index value [startFrom: " + startFrom + ", size of cardList: " + cardList.size() + "]"));
		}
		
		// Check if current card is higher than the relevant card in the list
		int compareCardResult = compareCards(currentCard, cardList.get(startFrom));
		
		if(compareCardResult == 1) {
			// current card is higher - card should be placed in current position (ahead of other card)
			return startFrom;
		} else if(compareCardResult == 0) {  // current card is lower
			
			// If we recurse to the end of the list, then don't try to recurse again, just return the size of the list (i.e. current card will be placed at index that is after the last card)
			if(startFrom == cardList.size()-1) {
				return startFrom+1;
			}
			// current card is lower - recursively check where it should go
			return cardPositionInList(currentCard, cardList, startFrom+1);
		
		} else { // compareCardResult must equal -1
			// 2 cards the same - something went wrong
			throw(new RuntimeException("Two cards compared and found to be equal. All cards should be unique"));
		}
	}
	
	/*
	 * Compares two cards
	 * Returns 1 if card 1 is highest (ordered by suit)
	 * Returns 0 if card 2 is highest (ordered by suit)
	 * Returns -1 if they are both the same
	 */
	private int compareCards(Card card1, Card card2) {
		
		// Check for card1 being biggest
		if(card1.getSuit() > card2.getSuit()) {
			return 1;
		} else if(card1.getSuit() < card2.getSuit()) {
			return 0;
		
		} else { // suits must be equal by this stage - check for highest card num
			if(card1.getCardNum() > card2.getCardNum()) {
				return 1;
			} else if(card1.getCardNum() < card2.getCardNum()) {
				return 0;
				
			} else { // suits & card nums must be equal by this stage i.e. cards are the same
				return -1;
			}
		}
	}
	
	public List<Card> getDeck() {
		return deck;
	}
}
