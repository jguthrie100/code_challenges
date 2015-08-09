import java.util.List;


public class Tester {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		if(test1()) {
			System.out.println("Test 1: Passed");
		} else {
			System.out.println("Test 1: FAILED");
		}
		
		if(test2()) {
			System.out.println("Test 2: Passed");
		} else {
			System.out.println("Test 2: FAILED");
		}
		
		if(test3()) {
			System.out.println("Test 3: MANUALLY CHECK RESULTS (see that above string is ordered");
		} else {
			System.out.println("Test 3: FAILED");
		}
		
		if(test4()) {
			System.out.println("Test 4: Passed");
		} else {
			System.out.println("Test 4: FAILED");
		}
	}
	
	// New deck creates 52 cards
	private static boolean test1() {
		Deck deck = new Deck();
		
		if(deck.getDeck().size() != 52) {
			return false;
		}
		
		return true;
	}
	
	// Test shuffling deck works
	private static boolean test2() {
		Deck deck = new Deck();
		
		String unshuffledDeck = asString(deck.getDeck());
		
		deck.shuffle();
		
		// Deck should now be different
		if(asString(deck.getDeck()).equals(unshuffledDeck)) {
			System.out.println("Test 2: FAIL: Deck doesn't get shuffled");
			System.out.println("Unshuffled Deck: " + unshuffledDeck);
			System.out.println("Shuffled Deck:   " + asString(deck.getDeck()));
			return false;
		}
		
		return true;		
	}
	
	// Test that drawn cards are sorted correctly
	private static boolean test3() {
		Deck deck = new Deck();
		deck.shuffle();
		List<Card> drawList = deck.drawSorted(10);
		
		System.out.println("Test 3 results: " + asString(drawList));
		
		return true;
	}
	
	// Test upper/lower index values with exceptions)
	private static boolean test4() {
		Deck deck = new Deck();
		deck.shuffle();
		
		int testPoints = 0;
		
		try {
			deck.drawSorted(0);
		} catch (IndexOutOfBoundsException e) {
			testPoints++;
		}
		
		try {
			deck.drawSorted(53);
		} catch (IndexOutOfBoundsException e) {
			testPoints++;
		}
		
		try {
			deck.drawSorted(50);
			deck.drawSorted(2);
			testPoints++;
		} catch (IndexOutOfBoundsException e) {
			System.out.println("FAIL: Attempted to draw 52 cards, but couldn't");
		}
		
		try {
			// Already drawn 52 cards. 1 more should throw error.
			deck.drawSorted(1);
		} catch (IndexOutOfBoundsException e) {
			testPoints++;
		}
		
		if(testPoints == 4) {
			return true;
		} else {
			return false;
		}
	}
	
	public static String asString(List<Card> cards) {
		String s = "";
		for(int i=0; i<cards.size(); i++) {
			s = s + "[" + cards.get(i).getSuitName() + " " + cards.get(i).getCardName() + "] ";
		}
		
		return s;
	}

}
