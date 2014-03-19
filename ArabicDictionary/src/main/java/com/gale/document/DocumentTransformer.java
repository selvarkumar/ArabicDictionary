package com.gale.document;

import java.io.ByteArrayOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import com.gale.dictionary.ArabicDictionary;
import com.gale.dictionary.ArabicDictionaryBuilder;

public class DocumentTransformer {

	private static final String[] DEFAULT_DOCUMENTS = {"CX3403500155", "CX3403500053", "CX3403500222"};
	private static final String ARABIC_DOCUMENT_XSL = "ArabicDocument.xsl";

	public DocumentTransformer() {
	}

	public String transformDocument(String sourceDocument, ArabicDictionary arabicDictionary) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

	    try {
		    TransformerFactory tFactory = TransformerFactory.newInstance();
	        InputStream styleSheetInputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(ARABIC_DOCUMENT_XSL);
	        Transformer transformer = tFactory.newTransformer( new StreamSource( styleSheetInputStream ) );

	        InputStream dictionaryInputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(sourceDocument);	        
	        StreamSource xmlSource = new StreamSource( dictionaryInputStream );

			transformer.setParameter("arabicDictionary", arabicDictionary);
	        transformer.transform( xmlSource, new StreamResult( baos ) );

	    } catch( Exception e ) {
	        e.printStackTrace();
	    }

	    return baos.toString();
	}
	
	public static void main(String[] args) throws IOException {
		ArabicDictionaryBuilder builder = new ArabicDictionaryBuilder();
		ArabicDictionary arabicDictionary = builder.buildArabicDictionary();

		DocumentTransformer transformer = new DocumentTransformer();

		String[] sourceDocuments = args.length == 0 ? DEFAULT_DOCUMENTS : args;
		
		transformer.transformDocuments(sourceDocuments, arabicDictionary);		
	}

	private void transformDocuments(String[] sourceDocuments, ArabicDictionary arabicDictionary) throws IOException {
		for (String sourceDocument : sourceDocuments) {
			String outputDocument = transformDocument(sourceDocument + ".xml", arabicDictionary);
			FileWriter writer = new FileWriter(sourceDocument + ".html");
			writer.append(outputDocument);
			writer.close();
		}
	}

}
