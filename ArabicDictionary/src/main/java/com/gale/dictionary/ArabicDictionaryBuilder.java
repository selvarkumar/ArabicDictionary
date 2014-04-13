package com.gale.dictionary;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Map;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class ArabicDictionaryBuilder {

	private static final String ARABIC_DICTIONARY = "Islam_Glossary_SGML_RP.xml";
	private static final String ARABIC_DICTIONARY_XSL = "ArabicDictionary.xsl";

	public ArabicDictionaryBuilder() {
	}

	public ArabicDictionary buildArabicDictionary() {
        ArabicDictionary arabicDictionary = new ArabicDictionary();

	    try {
		    TransformerFactory tFactory = TransformerFactory.newInstance();
	        InputStream styleSheetInputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(ARABIC_DICTIONARY_XSL);
	        Transformer transformer = tFactory.newTransformer( new StreamSource( styleSheetInputStream ) );

	        InputStream dictionaryInputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(ARABIC_DICTIONARY);	        
	        StreamSource xmlSource = new StreamSource(dictionaryInputStream);

	        ByteArrayOutputStream baos = new ByteArrayOutputStream();
			transformer.setParameter("arabicDictionary", arabicDictionary);
	        transformer.transform( xmlSource, new StreamResult( baos ) );

	    } catch( Exception e ) {
	        e.printStackTrace();
	    }

		return arabicDictionary;
	}
	
	public static void main(String[] args) {
		ArabicDictionaryBuilder builder = new ArabicDictionaryBuilder();
		ArabicDictionary arabicDictionary = builder.buildArabicDictionary();
		Map<String, DictionaryTerm> terms = arabicDictionary.terms();
		for (Map.Entry<String, DictionaryTerm> term : terms.entrySet()) {
			System.out.print(term.getKey());
			System.out.print("---->");
			System.out.print(term.getValue());
			System.out.println();
		}
	}
}
