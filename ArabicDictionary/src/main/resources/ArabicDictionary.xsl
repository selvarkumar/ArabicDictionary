<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:meta="http://www.gale.com/goldschema/metadata"
	xmlns:media="http://www.gale.com/goldschema/media"
	xmlns:essay="http://www.gale.com/goldschema/essay"
	xmlns:gift-doc="http://www.gale.com/goldschema/gift-doc"
	xmlns:pres="http://www.gale.com/goldschema/pres"
	xmlns:vault-link="http://www.gale.com/goldschema/vault-linking"
	xmlns:list="http://www.gale.com/goldschema/list"
	xmlns:shared="http://www.gale.com/goldschema/shared"
	xmlns:ext="xalan://com.gale.dictionary.ArabicDictionary"
	xmlns:articleToc="xalan://com.gale.application.dvi.model.ArticleDocument"
	xmlns:etoc="http://www.gale.com/goldschema/etoc"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="meta media essay gift-doc pres vault-link list shared ext fn articleToc">

	<xsl:param name="arabicDictionary" />

	<xsl:template match="gift-doc:body/essay:div/essay:p/pres:bold">
		<xsl:value-of disable-output-escaping="yes" select="ext:addDictionaryTerm($arabicDictionary, .)" />
	</xsl:template>

</xsl:stylesheet>