package com.gale.dictionary;

import java.util.LinkedHashMap;
import java.util.Map;

public class ArabicDictionary {
	private Map<String, DictionaryTerm> dictionaryTerms;
	
	public ArabicDictionary() {
		dictionaryTerms = new LinkedHashMap<String, DictionaryTerm>();
	}

	public Map<String, DictionaryTerm> terms() {
		return dictionaryTerms;
	}

	public DictionaryTerm termValue(String termKey) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		return dictionaryTerms.get(normalizedTermKey);
	}

	public String htmlToolTip(String termKey) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		return dictionaryTerms.get(normalizedTermKey).htmlToolTip();
	}

	public boolean isDictionaryTerm(String termKey) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		return dictionaryTerms.containsKey(normalizedTermKey);
	}

	public void addTermDef2Dictionary(String termKey, String pronunciationKey, String meaning) {
		String normalizedTermKey = termKey.trim().toLowerCase();
		DictionaryTerm dictionaryTerm = new DictionaryTerm(termKey.trim(), pronunciationKey.trim(), meaning.trim());	
		dictionaryTerms.put(normalizedTermKey, dictionaryTerm);
   }

}
