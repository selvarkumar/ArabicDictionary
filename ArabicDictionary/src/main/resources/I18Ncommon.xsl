<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xmlutil="com.gale.util.xsl.I18nXMLUtil" extension-element-prefixes="xmlutil">

<xsl:variable name="defaultLang"/>

<!-- NOTE: values passed to getNodeList() must be passed as xslt variables -->

<xsl:variable name="thelangvalue">
	<xsl:value-of select="$langvalue"/>
</xsl:variable>

<xsl:variable name="theresource">
	<xsl:value-of select="$resource"/>
</xsl:variable>

<xsl:variable name="i8nitems" select="xmlutil:getNodeList($theresource, $thelangvalue)"/>
<!-- returns a node-set of str items which are keyed strings -->

	<xsl:template name="getResourceString">
		<xsl:param name="key" />
		<xsl:value-of select="$i8nitems/str[@name=$key]" />
	</xsl:template>


	<!-- handles i18n strings with embedded items that need to be replaced -->
	<!-- items to be replaced are referenced with {0}, {1}, {2} -->
	<xsl:template name="transformOneItemString">
		<xsl:param name="baseString"/>
		<xsl:param name="item0"/>
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$baseString"/>
			<xsl:with-param name="searchTerm" select="'{0}'"/>
			<xsl:with-param name="replace" select="$item0"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="transformTwoItemString">
		<xsl:param name="baseString"/>
		<xsl:param name="item0"/>
		<xsl:param name="item1"/>
		<xsl:variable name="firstPass">
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$baseString"/>
			<xsl:with-param name="searchTerm" select="'{0}'"/>
			<xsl:with-param name="replace" select="$item0"/>
		</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$firstPass"/>
			<xsl:with-param name="searchTerm" select="'{1}'"/>
			<xsl:with-param name="replace" select="$item1"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="transformThreeItemString">
		<xsl:param name="baseString"/>
		<xsl:param name="item0"/>
		<xsl:param name="item1"/>
		<xsl:param name="item2"/>
		<xsl:variable name="firstPass">
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$baseString"/>
			<xsl:with-param name="searchTerm" select="'{0}'"/>
			<xsl:with-param name="replace" select="$item0"/>
		</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="secondPass">
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$firstPass"/>
			<xsl:with-param name="searchTerm" select="'{1}'"/>
			<xsl:with-param name="replace" select="$item1"/>
		</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="stringReplace">
			<xsl:with-param name="string" select="$secondPass"/>
			<xsl:with-param name="searchTerm" select="'{2}'"/>
			<xsl:with-param name="replace" select="$item2"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stringReplace">
		<xsl:param name="string"/>
		<xsl:param name="searchTerm"/>
		<xsl:param name="replace"/>
		<xsl:choose>
			<xsl:when test="contains($string, $searchTerm)">
				<xsl:variable name="remainder">
				<xsl:call-template name="stringReplace">
					<xsl:with-param name="string" select="substring-after($string, $searchTerm)"/>
					<xsl:with-param name="searchTerm" select="$searchTerm"/>
					<xsl:with-param name="replace" select="$replace"/>
				</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat(substring-before($string, $searchTerm), $replace, $remainder)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
