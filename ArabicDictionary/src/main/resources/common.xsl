<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: common.xsl,v 1.21 2009-03-31 15:47:05 rsenthil Exp $ -->
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
                
	<xsl:param name="DOWNLOAD_HTML" select="docLinker:getValue($docBuilderRequestHandle,'DOWNLOAD_HTML')"/>	
    <xsl:param name="retrieveURL" select="docLinker:getValue($docBuilderRequestHandle,'retrieveURL')"/>
    <xsl:param name="externalLinksURL" select="docLinker:getValue($docBuilderRequestHandle,'externalLinksURL')"/>
    <xsl:param name="disclaimer" select="docLinker:getValue($docBuilderRequestHandle,'disclaimer')"/>
   <xsl:param name="recentUpdate" select="docLinker:getValue($docBuilderRequestHandle,'recentUpdate')"/>
	<xsl:param name="authorLifeSpan" select="docLinker:getValue($docBuilderRequestHandle,'authorLifeSpan')"/>
	<xsl:param name="printOrDownload" select="docLinker:getValue($docBuilderRequestHandle,'printOrDownload')"/>
	<xsl:param name="EMAIL_TYPE" select="docLinker:getValue($docBuilderRequestHandle,'EMAIL_TYPE')"/>
	<xsl:param name="CITATION" select="docLinker:getValue($docBuilderRequestHandle,'CITATION')"/>
	<xsl:param name="COPYRIGHT_STMT" select="docLinker:getValue($docBuilderRequestHandle,'COPYRIGHT_STMT')"/>
    <xsl:param name="originalWorkRef"/>
	<xsl:param name="langvalue" select="docLinker:getValue($docBuilderRequestHandle,'langvalue')"/>
    <xsl:param name="resource" select="'com.gale.application.zaius.docbuilder.resources.messages-docbuilder'"/>
	<xsl:param name="MLACopyrightInfo" select="docLinker:getValue($docBuilderRequestHandle,'MLACopyrightInfo')"/>
	<xsl:param name="displayLinks" select="docLinker:getValue($docBuilderRequestHandle,'displayLinks')"/>	
	<xsl:param name="docNumber" select="docLinker:getValue($docBuilderRequestHandle,'docNumber')"/>
	<xsl:param name="sourceCitation" select="docLinker:getValue($docBuilderRequestHandle,'MLA_Citation')"/>
	<xsl:param name="citationFormat" select="docLinker:getValue($docBuilderRequestHandle,'citation_format')"/>
    <xsl:param name="pdfPageURL" select="docLinker:getValue($docBuilderRequestHandle,'pdfPageURL')"/>		
	<xsl:param name="callistoContentSet" select="docLinker:getValue($docBuilderRequestHandle,'callistoContentSet')"/>	
	<xsl:param name="displayLinks" select="docLinker:getValue($docBuilderRequestHandle,'displayLinks')"/>
	<xsl:param name="isBobIndexPresent" select="docLinker:getValue($docBuilderRequestHandle,'isBobIndexPresent')"/>
	<xsl:param name="usergroupname" select="docLinker:getValue($docBuilderRequestHandle,'userGroupName')"/>
	<xsl:param name="prodId" select="docLinker:getValue($docBuilderRequestHandle,'prodId')"/>
	<xsl:param name="shouldDisplayBobIndex" select="docLinker:getValue($docBuilderRequestHandle,'shouldDisplayBobIndex')"/>
	 <xsl:param name="fullTextDisclaimer" select="docLinker:getValue($docBuilderRequestHandle,'fullTextDisclaimer')"/>
	<xsl:param name="isFullText"/>

	<xsl:variable name="thisDocId">
	    <xsl:value-of select="substring-after($docNumber, 'GALE|')"/>
	</xsl:variable>
               
	<!--grouping related docs-->
	<xsl:template name="displayRelatedInformation">
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkSeeAslo'"/>
		</xsl:call-template>
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkRelDoc'"/>
		</xsl:call-template>
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkBio'"/>
		</xsl:call-template>
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkExp'"/>
		</xsl:call-template>
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkSel'"/>
		</xsl:call-template>	
		<xsl:call-template name="displayLinksForWorks">
			<xsl:with-param name="displayOrder" select="'linkSelFrom'"/>
		</xsl:call-template>		
	</xsl:template>	
	
	<xsl:template name="displayLinksForWorks">
		<xsl:param name="displayOrder"/>
		<xsl:if test="$displayOrder = 'linkSeeAslo' ">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009865']/text() = 'See also')">
				<div class="workDocdata">
					<span class="workRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.seeAlso'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009865' and ./text() = 'See also' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>
				</div>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$displayOrder = 'linkRelDoc' ">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009864']/text() = 'Related document')">
				<div class="workDocdata">
					<span class="bioRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.relatedDocument'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009864' and ./text() = 'Related document' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>		
				</div>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$displayOrder = 'linkBio' ">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009863']/text() = 'Biography')">
				<div class="workDocdata">
					<span class="workRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.biography'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19009863' and ./text() = 'Biography' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>
				</div>
			</xsl:if>
		</xsl:if>		
		<xsl:if test="$displayOrder = 'linkExp'">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19945145']/text() = 'Explanation')">
				<div class="workDocdata">
					<span class="workRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.explanationOf'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19945145' and ./text() = 'Explanation' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>
				</div>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$displayOrder = 'linkSel' ">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19625269']/text() = 'Selection')">
				<div class="workDocdata">
					<span class="workRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.selection'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19625269' and ./text() = 'Selection' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>
				</div>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$displayOrder = 'linkSelFrom' ">
			<xsl:if test="(/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-type/text() = 'external') and (/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19625270']/text() = 'Selection from')">
				<div class="workDocdata">
					<span class="workRubric">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'works.title.selectionFrom'"/>
						</xsl:call-template>
					</span>
					<span class="workDefinition">
						<ul>
							<xsl:apply-templates select="/gift-doc:document/gift-doc:body/essay:div/vault-link:vault-link/vault-link:link-category[@term-id='19625270' and ./text() = 'Selection from' ]/parent::vault-link:vault-link" mode="relInfo" />
						</ul>
					</span>
				</div>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="vault-link:vault-link" mode="relInfo">
		<xsl:variable name="linkNode" select="node()" />
		<li>
		<xsl:value-of select = 'docLinker:handleXalanLinkNode($docBuilderRequestHandle, "defaultKey", $linkNode)' disable-output-escaping="yes"/>
		</li>		
	</xsl:template>
	
	<xsl:template match="vault-link:vault-link" mode="Toc">
		<xsl:variable name="linkNode" select="node()" />
		<xsl:value-of select = 'docLinker:handleXalanLinkNode($docBuilderRequestHandle, "defaultKey", $linkNode)' disable-output-escaping="yes"/>
		<xsl:if test="ancestor[1]/text() != ''">
			<br/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="vault-link:vault-link">
		<xsl:variable name="parent">
			<xsl:value-of select="name(current()/parent::node())"/>
		</xsl:variable>
		<xsl:variable name="linkNode" select="node()" />
		<xsl:variable name="vaultUrl">
			<xsl:value-of select = 'vault-link:where/vault-link:path' disable-output-escaping="yes"/>
		</xsl:variable>
		<xsl:variable name="categoryId" select="vault-link:link-category/@term-id" />
		<xsl:choose>
			<xsl:when test="$categoryId =$nonHostedRetrievalCategory and $parent = 'essay:p'">
				<xsl:element name="a">
					<xsl:attribute name="href">
						<xsl:value-of select="$vaultUrl" />
					</xsl:attribute>
					<xsl:attribute name="class">full-text-link websiteLink</xsl:attribute>
					View Article
				</xsl:element>
				
				<div class="alternate_full_text">
					URL:<xsl:value-of select = 'docLinker:handleXalanLinkNode($docBuilderRequestHandle, "defaultKey", $linkNode)' disable-output-escaping="yes"/>
				</div>
			
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select = 'docLinker:handleXalanLinkNode($docBuilderRequestHandle, "defaultKey", $linkNode)' disable-output-escaping="yes"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
    <xsl:template match="media:caption">
		<br/>
			<xsl:apply-templates/>
		<br/>
    </xsl:template>

    <xsl:template match="media:credit">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="dict:primary-term">
        <!-- suppress dictionary terms -->
    </xsl:template>
    
    <xsl:template name="displayNonHostedDisclaimer">
	    <xsl:if test="$hasNonHostedLinks > 0">			
			<div class="message">
				<p class="disclaimer">
					<span class="heading">
						<xsl:call-template name="getResourceString">
							<xsl:with-param name="key" select="'disclaimer.prefix'"/>
						</xsl:call-template>
					</span>
					&#160;
					<xsl:call-template name="getResourceString">
						<xsl:with-param name="key" select="'disclaimer.non-hosted-retrieval'"/>
					</xsl:call-template>
				</p>
			</div>
	    </xsl:if>		
    </xsl:template>

</xsl:stylesheet>