package com.gale.dictionary;

import java.util.LinkedHashMap;
import java.util.Map;

public class ArabicDictionary {
	private Map<String, String> dictionaryTerm;

	public ArabicDictionary() {
		dictionaryTerm = new LinkedHashMap<String, String>();
	}

	public void addDictionaryTerm(String term) {
		addKeyPronunciation(term);
	}
	
	public Map<String, String> terms() {
		return dictionaryTerm;
	}

	public String termValue(String termKey) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		return dictionaryTerm.get(normalizedTermKey);
	}

	public boolean isDictionaryTerm(String termKey) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		return dictionaryTerm.containsKey(normalizedTermKey);
	}

	private void addKeyPronunciation(String term) {
		String[] parts = term.split("[()]");
		if (parts.length > 1) {
			String termKey = parts[0];
			String termValue = parts[1];
			String[] splits = termValue.split(" ");
			String termPronunciation = splits[splits.length-1];
			String normalizedTermKey = termKey.trim().toLowerCase();
			String normalizedTermPronunciation = termPronunciation.trim().toLowerCase();
			dictionaryTerm.put(normalizedTermKey, normalizedTermPronunciation);
		}
	}

}
