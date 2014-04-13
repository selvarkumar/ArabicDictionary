package com.gale.dictionary;

public class DictionaryTerm {
	private static final String LINE_SEPARATOR = "\n";
	private String term;
	private String pronunciationKey;
	private String meaning;

	public DictionaryTerm(String term, String pronunciationKey, String meaning) {
		this.term = term;
		this.pronunciationKey = pronunciationKey;
		this.meaning = meaning;
	}

	public String getTerm() {
		return term;
	}

	public String getPronunciationKey() {
		return pronunciationKey;
	}

	public String getMeaning() {
		return meaning;
	}

	@Override
	public String toString() {
		return "DictionaryTerm [term=" + term + ", pronunciationKey="
				+ pronunciationKey + ", meaning=" + meaning + "]";
	}

	public String alternateHtmlToolTip() {
		return "Term                    " + term + LINE_SEPARATOR +
	           "Pronunciation Key       " + pronunciationKey + LINE_SEPARATOR +
			   "Meaning                 " + meaning + LINE_SEPARATOR;		
	}

	public String htmlToolTip() {
		return term + "    " + pronunciationKey + LINE_SEPARATOR + "     " +
	           meaning + LINE_SEPARATOR;		
	}

}
