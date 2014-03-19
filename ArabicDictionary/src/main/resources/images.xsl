<?xml version="1.0" encoding="UTF-8"?>
<!--
File: gift2xhtml.xsl
This is a set of transforms from Gale Interchange FormaT (GIFT) to XHTML
-->
<xsl:stylesheet version="1.0"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vrl-book="http://www.gale.com/goldschema/vrl-book"
                xmlns:n1="http://www.w3.org/1999/xhtml"
                xmlns:doc-meta="http://www.gale.com/goldschema/document-metadata"
                xmlns:essay="http://www.gale.com/goldschema/essay"
                xmlns:pres="http://www.gale.com/goldschema/pres"
                xmlns:table="http://www.gale.com/goldschema/table"
                xmlns:gift-doc="http://www.gale.com/goldschema/gift-doc"
                xmlns:common-meta="http://www.gale.com/goldschema/common-meta"
                xmlns:media="http://www.gale.com/goldschema/media"
                xmlns:pub-meta="http://www.gale.com/goldschema/pub-meta"
                xmlns:tracking-pub-meta="http://www.gale.com/goldschema/tracking-pub-meta"
                xmlns:paris-pub-meta="http://www.gale.com/goldschema/paris-pub-meta"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:vault-link="http://www.gale.com/goldschema/vault-linking"
                xmlns:callisto="com.gale.application.callisto.CallistoXSLHelper"
				xmlns:jstl="com.gale.presentation.util.JSTLHelper"
				xmlns:docidconstr="com.gale.presentation.util.DocumentIdConstructor"
                xmlns:meta="http://www.gale.com/goldschema/metadata"
                xmlns:spud="http://www.gale.com/goldschema/spud"
                xmlns:gold="http://www.gale.com/gold"
                xmlns:dict="http://www.gale.com/goldschema/dictionary"
                xmlns:list="http://www.gale.com/goldschema/list"
                xmlns:shared="http://www.gale.com/goldschema/shared"
                xmlns:verse="http://www.gale.com/goldschema/verse"
                xmlns:etoc="http://www.gale.com/goldschema/etoc"
                xmlns:index="http://www.gale.com/goldschema/index"
                xmlns:mla="http://www.gale.com/goldschema/mla"
				xmlns:docLinker="com.gale.application.zaius.docbuilder.doclinker.DocLinkerXslHelper"
                extension-element-prefixes="callisto docidconstr jstl docLinker"
                exclude-result-prefixes="xhtml vrl-book n1 spud meta doc-meta gift-doc dc paris-pub-meta vault-link tracking-pub-meta pub-meta media common-meta table pres essay gold dict list shared verse etoc index mla">
	
	<xsl:import href="com/gale/application/zaius/docbuilder/xsl/globalConstants.xsl" />
	
	<xsl:param name="isImage"/>

	<xsl:template match="media:caption/shared:media/media:image">
		<span id="captionImage">
	    	<xsl:if test="$isImage = 'YES'">
				<xsl:variable name="imageNode" select="node()" />
		        <xsl:variable name="imageName" select="vault-link:vault-link/vault-link:where/vault-link:path/text()"/>		
				<xsl:value-of select = 'docLinker:handleXalanImageNode($docBuilderRequestHandle, "defaultKey", $imageNode)' disable-output-escaping="yes"/>
			</xsl:if>		
		</span>
    </xsl:template>
    
    <xsl:template match="vault-link:vault-link" mode="non-hosted-image">
		<xsl:variable name="vaultLink" select="node()" />
		<xsl:variable name="vaultUrl">
			<xsl:value-of select = 'vault-link:where/vault-link:path' disable-output-escaping="yes"/>
		</xsl:variable>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:value-of select="$vaultUrl" />
				</xsl:attribute>
				<xsl:attribute name="class">full-text-link websiteLink</xsl:attribute>
				View Image
			</xsl:element>
			
			<div class="alternate_full_text">
				URL:<xsl:value-of select = 'docLinker:handleXalanLinkNode($docBuilderRequestHandle, "defaultKey", $vaultLink)' disable-output-escaping="yes"/>
			</div>
	</xsl:template>
	
	<xsl:template name="hosted-image" >
		<xsl:variable name="imageNode" select="node()" />	
		<xsl:value-of select = 'docLinker:handleXalanImageNode($docBuilderRequestHandle, "defaultKey", $imageNode)' disable-output-escaping="yes"/> 
		<xsl:variable name="imageName" select="vault-link:vault-link/vault-link:where/vault-link:path/text()"/>
		<xsl:if test="media:credit or media:caption">
			 <span class="caption">
				<xsl:apply-templates select="media:caption"/>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				<xsl:apply-templates select="media:credit"/>
			</span>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template match = "media:image">
		<xsl:if test="$isImage = 'YES'">
			<xsl:variable name="categoryId" select="vault-link:vault-link/vault-link:link-category/@term-id" />
			<xsl:choose>
				<xsl:when test="$categoryId =$nonHostedRetrievalCategory">
					<xsl:apply-templates mode="non-hosted-image"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name ="hosted-image"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>		
	</xsl:template>

	
	<!-- <<< apply Image rights  -->
	<xsl:template match="gift-doc:vendor-images">
		<xsl:if test="$isImage = 'YES'">
			<xsl:comment> IM </xsl:comment>
			<xsl:apply-templates select="node()" />
		</xsl:if>
	</xsl:template>
	<!-- apply Image rights >>>  -->
	
</xsl:stylesheet>
