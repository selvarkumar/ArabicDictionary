package com.home;

import static org.junit.Assert.*;
import static org.mockito.Mockito.when;
import junit.framework.Assert;

import org.junit.Test;
import org.mockito.Mockito;

// SUT -- System Under Test
public class PackTest {

	@Test
	public void changesRankOfTrumpToA() throws Exception {
		// Given
		Card mockCard = Mockito.mock(Card.class);
		Pack pack = new Pack(mockCard, "Spade");		

		when(mockCard.isTrumpValue("Spade")).thenReturn(true);
		when(mockCard.setRankValue("A")).thenReturn(true);
        
		// When
		boolean changed = pack.checkAndChange();

		// Then
		Assert.assertTrue(changed);
	}

	@Test
	public void noRankChangesForANonTrumpCard() throws Exception {
		// Given
		Card mockCard = Mockito.mock(Card.class);
		Pack pack = new Pack(mockCard, "Spade");		

		when(mockCard.isTrumpValue("Spade")).thenReturn(false);
		when(mockCard.setRankValue("A")).thenReturn(true);

		// When
		boolean changed = pack.checkAndChange();

		// Then
		Assert.assertFalse(changed);
	}

}
