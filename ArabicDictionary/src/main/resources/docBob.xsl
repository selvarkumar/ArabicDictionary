<?xml version="1.0" encoding="UTF-8"?>
<!--
File: docBob.xsl
This creates the BOB index
-->
<xsl:stylesheet version="1.0"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:common-meta="http://www.gale.com/goldschema/common-meta"
                xmlns:doc-meta="http://www.gale.com/goldschema/document-metadata"
                xmlns:essay="http://www.gale.com/goldschema/essay"
                xmlns:media="http://www.gale.com/goldschema/media"
                xmlns:pres="http://www.gale.com/goldschema/pres"
                xmlns:pcv="http://prismstandard.org/namespaces/1.2/pcv"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:idx="http://www.gale.com/goldschema/indexing"
                xmlns:vault-link="http://www.gale.com/goldschema/vault-linking"
                xmlns:pub-meta="http://www.gale.com/goldschema/pub-meta"
                xmlns:paris-pub-meta="http://www.gale.com/goldschema/paris-pub-meta"
                xmlns:tracking-pub-meta="http://www.gale.com/goldschema/tracking-pub-meta"
                xmlns:index="http://www.gale.com/goldschema/index"
                xmlns:etoc="http://www.gale.com/goldschema/etoc"
                xmlns:table="http://www.gale.com/goldschema/table"
                xmlns:gift-doc="http://www.gale.com/goldschema/gift-doc"
                xmlns:list="http://www.gale.com/goldschema/list"
                xmlns:meta="http://www.gale.com/goldschema/metadata"
				xmlns:docLinker="com.gale.application.zaius.docbuilder.doclinker.DocLinkerXslHelper"	
                extension-element-prefixes="docLinker"
                exclude-result-prefixes="xhtml common-meta doc-meta essay media pres pcv dc idx vault-link pub-meta paris-pub-meta tracking-pub-meta index etoc  table  meta gift-doc list">
    <xsl:output method="xml" indent="no" media-type="text/html" omit-xml-declaration="yes"/>

    <xsl:variable name="thisDocId">
        <xsl:value-of select="substring-after($docNumber, 'GALE|')"/>
    </xsl:variable>

    <xsl:template match="meta:document-back-of-book-index-terms">
		<xsl:if test="$shouldDisplayBobIndex = 'true' and $EMAIL_TYPE = ''">
			<div id="relatedDocumentIndex">
				<h3>
					<xsl:text></xsl:text>
					<xsl:call-template name="getResourceString">
						<xsl:with-param name="key" select="'document.viewarticles'"/>
					</xsl:call-template>
				</h3>
				<p>
					<xsl:call-template name="getResourceString">
						<xsl:with-param name="key" select="'document.pagelocators'"/>
					</xsl:call-template>
				</p>
				<ul id="relatedDocumentIndex-main">
					<xsl:apply-templates select="meta:bob-index-term-chunk"/>
				</ul>
			</div>
		</xsl:if>
    </xsl:template>

    <xsl:template match="meta:bob-index-term-chunk">
		<li class="term">
			<span>
				<xsl:value-of select="meta:bob-index-term"/>
			</span>
			<xsl:if test="meta:bob-index-term-metadata">
				<ul class="ref">
					<xsl:apply-templates select="meta:bob-index-term-metadata"/>
				</ul>
			</xsl:if>
			<xsl:if test="meta:bob-index-term-chunk">
				<ul>
					<xsl:apply-templates select="meta:bob-index-term-chunk"/>
				</ul>
			</xsl:if>
		</li>
    </xsl:template>

    <xsl:template match="meta:bob-index-term-metadata">
			<li>
				<xsl:if test="position() = 1">
					<xsl:attribute name="class">first</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="title">
					<xsl:value-of select="meta:title-display"/>
				</xsl:attribute>
				<xsl:variable name="path" select="vault-link:vault-link/vault-link:where/vault-link:path"/>
				<xsl:choose>
					<xsl:when test="$thisDocId = $path">
						<xsl:apply-templates select="vault-link:vault-link/vault-link:display-link"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="vault-link:vault-link"/>
					</xsl:otherwise>
				</xsl:choose>
			</li>
    </xsl:template>
	
</xsl:stylesheet>