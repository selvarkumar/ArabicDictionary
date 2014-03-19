<?xml version="1.0" encoding="UTF-8"?>
<!--
File: gift2xhtml.xsl
This is a set of transforms from Gale Interchange FormaT (GIFT) to XHTML
-->
<xsl:stylesheet version="1.0"
                xmlns:gift-doc="http://www.gale.com/goldschema/gift-doc"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:essay="http://www.gale.com/goldschema/essay"
                xmlns:pres="http://www.gale.com/goldschema/pres"
                xmlns:table="http://www.gale.com/goldschema/table"
                xmlns:media="http://www.gale.com/goldschema/media"
                 xmlns:meta="http://www.gale.com/goldschema/metadata"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:list="http://www.gale.com/goldschema/list"
                xmlns:verse="http://www.gale.com/goldschema/verse"
                xmlns:vault-link="http://www.gale.com/goldschema/vault-linking"
                xmlns:dict="http://www.gale.com/goldschema/dictionary"
                xmlns:shared="http://www.gale.com/goldschema/shared"
                exclude-result-prefixes="xsl gift-doc xhtml media meta table pres essay list dict verse vault-link shared">
 
    <!-- handle to the linking call-back mechanism -->
    <xsl:param name="docBuilderRequestHandle"/>
        <xsl:param name="isFullText"/>
        <xsl:param name="isAbstract"/>
        <xsl:param name="isImage"/>
    <!-- for lit image positioning - new with Omni 2.0 -->
    <xsl:variable name="totalParaCount" select="count(/gift-doc:document/gift-doc:body/essay:div/essay:p)"/>
 
    <!-- count of all images within the body -->
    <xsl:variable name="totalImagesCount" select="count(/gift-doc:document//media:image)"/>
    <xsl:variable name="zonedImagesCount" select="count(/gift-doc:document/gift-doc:body/gift-doc:vendor-images/media:image[@type='zoned'])"/>
    <xsl:variable name="relativePositionedImagesCount" select="count(//media:image[@relative-position != ''])"/>
 
    <xsl:variable name="hasNonHostedLinks" select="count(/gift-doc:document/gift-doc:body//essay:p/vault-link:vault-link/vault-link:link-category[@term-id='21616082'])"/>
 
    <xsl:template match="gift-doc:document-text">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
 
    <xsl:template name="essay:body">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
 
    <!-- misc formatting -->
    <xsl:template name="insert_space">
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
    </xsl:template>
 
    <!-- begin fields for essay namespace -->
    <!-- TEXT GROUP -->
    <xsl:template match="essay:abbr">
        <abbr>
            <xsl:value-of select="."/>
        </abbr>
    </xsl:template>
    <xsl:template match="essay:cite">
        <cite>
            <xsl:value-of select="."/>
        </cite>
    </xsl:template>
    <xsl:template match="essay:code">
        <code>
            <xsl:value-of select="."/>
        </code>
    </xsl:template>
    <xsl:template match="essay:defn">
        <dfn>
            <xsl:value-of select="."/>
        </dfn>
    </xsl:template>
    <xsl:template match="essay:em">
        <em>
            <xsl:value-of select="."/>
        </em>
    </xsl:template>
    <xsl:template match="essay:kbd">
        <kbd>
            <xsl:value-of select="."/>
        </kbd>
    </xsl:template>
    <xsl:template match="essay:i">
        <i>
            <xsl:value-of select="."/>
        </i>
    </xsl:template>
    <xsl:template match="essay:q">
        <q>
            <xsl:value-of select="."/>
        </q>
    </xsl:template>
    <xsl:template match="essay:samp">
        <samp>
            <xsl:value-of select="."/>
        </samp>
    </xsl:template>
    <xsl:template match="essay:strong">
        <strong>
            <xsl:value-of select="."/>
        </strong>
    </xsl:template>
    <xsl:template match="essay:span">
        <span>
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    <xsl:template match="essay:var">
        <var>
            <xsl:value-of select="."/>
        </var>
    </xsl:template>
    <!-- END OF TEXT GROUP -->
    <!-- STRUCTURAL GROUP -->
    <xsl:template match="essay:address">
        <address>
            <xsl:apply-templates select="node()"/>
        </address>
    </xsl:template>
    <xsl:template match="essay:blockcode">
        <pre>
            <xsl:apply-templates select="node()"/>
        </pre>
    </xsl:template>
 
    <xsl:template match="essay:blockquote">
        <blockquote>
            <xsl:apply-templates select="node()"/>
        </blockquote>
    </xsl:template>
    <xsl:template match="essay:div[@document-segment-type = 'Sidebar']">
         <xsl:variable name="currentPosition" select="generate-id()" />
                <div>
                        <xsl:attribute name="class">
                                <xsl:text>sideBarTitle</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="id">
                                <xsl:value-of select="$currentPosition"/>
                                <xsl:text>t</xsl:text>
                        </xsl:attribute>
                        <p>
                                <xsl:call-template name="getResourceString">
                                        <xsl:with-param name="key" select="'sidebar.text'"/>
                                </xsl:call-template>
                                <xsl:call-template name="insert_space"/>
                                <xsl:choose>
                                        <xsl:when test="$displayLinks = 'true'">
                                                <a>
                                                        <xsl:attribute name="href">
                                                                <xsl:text>javascript:showIt(&apos;</xsl:text>
                                                                <xsl:value-of select="$currentPosition"/>
                                                                <xsl:text disable-output-escaping="yes">&apos;)</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="getResourceString">
                                                                <xsl:with-param name="key" select="'show.text'"/>
                                                        </xsl:call-template>
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:call-template name="getResourceString">
                                                        <xsl:with-param name="key" select="'show.text'"/>
                                                </xsl:call-template>
                                        </xsl:otherwise>
                                </xsl:choose>
                                <br/>
                                <br/>
                        </p>
                </div>
                <div>
                        <xsl:attribute name="class">
                                <xsl:text>sideBarArticle</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="id">
                                <xsl:value-of select="$currentPosition"/>
                        </xsl:attribute>
                        <p>
                                <xsl:attribute name="class">
                                        <xsl:text>rs_skip</xsl:text>
                                </xsl:attribute>
                                <xsl:call-template name="getResourceString">
                                        <xsl:with-param name="key" select="'sidebar.text'"/>
                                </xsl:call-template>
 
                                <xsl:call-template name="insert_space"/>
                                <xsl:choose>
                                        <xsl:when test="$displayLinks = 'true'">
                                                <a>
                                                        <xsl:attribute name="href">
                                                                <xsl:text disable-output-escaping="yes">javascript:hideIt(&apos;</xsl:text>
                                                                <xsl:value-of select="$currentPosition"/>
                                                                <xsl:text disable-output-escaping="yes">&apos;)</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="getResourceString">
                                                                <xsl:with-param name="key" select="'hide.text'"/>
                                                        </xsl:call-template>
                                                </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <xsl:call-template name="getResourceString">
                                                        <xsl:with-param name="key" select="'hide.text'"/>
                                                </xsl:call-template>
                                        </xsl:otherwise>
                                </xsl:choose>
                        </p>
                        <xsl:apply-templates select="node()"/>
                </div>
    </xsl:template>
 
    <xsl:template match="essay:div">
         <xsl:if test="$isAbstract = 'YES' or $isFullText = 'YES' or $isImage = 'YES'">
                        <div> 
                                <!-- apply FULLTEXT right, filter ABSTRACT term-ids     -->                    
                         <xsl:choose>
 
                                        <!-- apply ABSTRACT right, allow 'Author abstract' => 14186898 and  'Abstract' => 14186895-->
                                        <xsl:when test="($isAbstract = 'YES') and (@term-id = '14186898' or @term-id = '14186895')">
                                                <xsl:attribute name="class">
                                                        <xsl:value-of select="@document-segment-type"/>
                                                </xsl:attribute>
                                       
                                                <xsl:comment> AB </xsl:comment>
                                                <div>
                                                        <xsl:attribute name="class">
                                                                <xsl:text>ParaTypeDecorator rs_skip</xsl:text>
                                                        </xsl:attribute>
                                                        <xsl:call-template name="getResourceString">
                                                                <xsl:with-param name="key" select="'document.header.abstract'"/>
                                                        </xsl:call-template>
                                                        <xsl:call-template name="insert_space"/>
                                                </div>
                                                <xsl:apply-templates select="node()"/>
                                 </xsl:when>
 
                                        <xsl:when test="($isFullText = 'YES' and (not(@term-id) or (@term-id != '14186898' and @term-id != '14186895'))) or ($isImage = 'YES')">
                                                <xsl:attribute name="class">
                                                        <xsl:choose>
                                                                <xsl:when test="@document-segment-type = 'Body text'">
                                                                        <xsl:text>document-text</xsl:text>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                        <xsl:value-of select="@document-segment-type"/>
                                                                </xsl:otherwise>
                                                        </xsl:choose>
                                                </xsl:attribute>
                                                <xsl:comment> FT/IMG </xsl:comment>                                    
                                                <xsl:if test="($hasNonHostedLinks = 0) and (@document-segment-type = 'Body text')">
														<xsl:variable name="currentPosition" select="count(./preceding-sibling::shared:media) + count(./preceding-sibling::essay:div[@document-segment-type = 'Table of contents' or @document-segment-type = 'Body text']) + 1" />
                                                        <xsl:if test="$currentPosition = 1">
                                                                <div>
                                                                        <xsl:attribute name="class">
                                                                                <xsl:text>ParaTypeDecorator rs_skip</xsl:text>
                                                                        </xsl:attribute>
                                                                        <xsl:call-template name="getResourceString">
                                                                                <xsl:with-param name="key" select="'document.header.Fulltext'"/>
                                                                        </xsl:call-template>
                                                                        <xsl:call-template name="insert_space"/>                                                       
                                                                </div> 
                                                        </xsl:if>
                                                </xsl:if>
                                                 <xsl:apply-templates select="node()"/>
                                        </xsl:when>
                                
                         </xsl:choose>
                         <xsl:comment><xsl:value-of select="@term-id"/></xsl:comment>
                        </div>
         </xsl:if>
    </xsl:template>

    <xsl:template match="essay:p">
        <div class="SideNotePara">
                <xsl:if test="./essay:div[@document-segment-type='Sidenote']">
                        <xsl:variable name="sideNote" select="./essay:div[@document-segment-type='Sidenote']"/>
 
                                <!-- If any page break is coming before Sidenote.... Break is handled here...-->
 
                                <xsl:variable name="commentFlag" select="child::node()[1] = comment()" />
                                <xsl:choose>
                                        <xsl:when test="$commentFlag = 'true'">
                                                <br/><br/><div style="border-bottom:1px dashed #606060;color:#303030;text-align:center;" noshade="noshade" size="1"><span style="position:absolute;margin-top:-6px;background-color:white">PageBreak</span></div><br/><br/>    
                                                <div class="Sidenote">
                                                <p class="pageBreakPara">
                                                        <xsl:for-each select="child::*">
                                                                <xsl:choose>
                                                                        <xsl:when test="self::node()[@document-segment-type = 'Sidenote']">
                                                                                <xsl:value-of select="." /><br/>
                                                                        </xsl:when>                                                                    
                                                                </xsl:choose>
                                                        </xsl:for-each>
                                                </p>
                                                </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                                <div class="Sidenote">
                                                        <xsl:for-each select="child::*">
                                                                <xsl:choose>
                                                                        <xsl:when test="self::node()[@document-segment-type = 'Sidenote']">
                                                                                <!--<xsl:value-of select="." /><br/>-->
                                                                            <xsl:apply-templates select="node()"/>
                                                                        </xsl:when>                                                                    
                                                                </xsl:choose>
                                                        </xsl:for-each>
                                                </div>
                                        </xsl:otherwise>
                                </xsl:choose>
                </xsl:if>
 
                <p>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates select="node()"/>
                </p>  
		 	<xsl:if test="$zonedImagesCount != 0 or $relativePositionedImagesCount != 0">
                <xsl:variable name="paraPosition" select="count(../preceding-sibling::*/essay:p)" />
                <xsl:variable name="divPosition" select="count(../preceding-sibling::*) + 1" />
                <xsl:if test="$isImage = 'YES' and $totalImagesCount > 0">
                        <xsl:variable name="currPara" select="position() + ($divPosition * $paraPosition)" />
                        <xsl:for-each select="/gift-doc:document/gift-doc:body/gift-doc:vendor-images/media:image[@type='zoned']">
                            <xsl:if test="round((@relative-position * $totalParaCount) - .5) = $currPara">
                                      <xsl:apply-templates select="." />
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:for-each select="//media:image[@relative-position != '']">
                            <xsl:if test="round((@relative-position * $totalParaCount) - .5) = $currPara">
                                     <xsl:apply-templates select="." />
                            </xsl:if>
                        </xsl:for-each>
                </xsl:if>
		 	</xsl:if>

        </div>
    </xsl:template>
       
 
    <xsl:template match="essay:pre">
        <pre>
            <xsl:apply-templates select="node()"/>
        </pre>
    </xsl:template>
    <!-- END OF STRUCTURAL GROUP -->
    <!-- HEADING GROUP -->
    <xsl:template match="essay:h"/>
    <xsl:template match="essay:h1">
                <div id="document-header">
                        <h1>
                                <span class="citation-title">
                                        <xsl:copy-of select="@*"/>
                                        <xsl:apply-templates select="node()"/>
                                </span>
                        </h1>
                </div>
    </xsl:template>
    <xsl:template match="essay:h2">
        <h2>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </h2>
    </xsl:template>
    <xsl:template match="essay:h3">
        <h3>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </h3>
    </xsl:template>
    <xsl:template match="essay:h4">
        <h4>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </h4>
    </xsl:template>
    <xsl:template match="essay:h5">
        <h5>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </h5>
    </xsl:template>
    <xsl:template match="essay:h6">
        <h6>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </h6>
    </xsl:template>
    <!-- END OF HEADING GROUP -->
    <!-- end of fields for essay name space -->
    <!-- begin fields for pres namespace -->
    <xsl:template match="pres:a">
                <xsl:choose>
                        <xsl:when test="$displayLinks = 'true'">
                                <a>
                                        <xsl:copy-of select="@*"/>
                                        <xsl:apply-templates select="node()"/>
                                </a>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:apply-templates select="node()"/>
                        </xsl:otherwise>
                </xsl:choose>
    </xsl:template>
 
    <xsl:template match="pres:a[@id]">
        <span>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
                        <xsl:text> </xsl:text>
        </span>
    </xsl:template>
 
    <xsl:template match="pres:bold">
                <xsl:if test="node()">
                        <b>
                                <xsl:apply-templates select="node()"/>
                        </b>
                </xsl:if>
    </xsl:template>
    <xsl:template match="pres:italics">
                <xsl:if test="node()">
                        <i>
                                <xsl:apply-templates select="node()"/>
                        </i>
                </xsl:if>
    </xsl:template>
    <xsl:template match="pres:bold-italic">
                <xsl:if test="node()">
                        <b>
                                <i>
                                        <xsl:apply-templates select="node()"/>
                                </i>
                        </b>
                </xsl:if>
    </xsl:template>
    <xsl:template match="pres:small">
        <small>
            <xsl:apply-templates select="node()"/>
        </small>
    </xsl:template>
        <xsl:template match="pres:big">
        <big>
            <xsl:apply-templates select="node()"/>
        </big>
    </xsl:template>
    <xsl:template match="pres:small-caps">
        <span style="font-variant: small-caps">
            <xsl:apply-templates select="node()"/>
        </span>
    </xsl:template>
    <xsl:template match="pres:strike-over">
        <del>
            <xsl:apply-templates select="node()"/>
        </del>
    </xsl:template>
    <xsl:template match="pres:sup">
        <xsl:if test="node()">
        <sup>
            <xsl:apply-templates select="node()"/>
        </sup>
        </xsl:if>
    </xsl:template>
    <xsl:template match="pres:sub">
        <sub>
            <xsl:apply-templates select="node()"/>
        </sub>
    </xsl:template>
    <xsl:template match="pres:under_score">
        <xsl:text disable-output-escaping="yes">_</xsl:text>
    </xsl:template>
    <xsl:template match="pres:line-break">
        <br/>
    </xsl:template>
    <!-- what should this gets mapped to in XHTML??? -->
    <xsl:template match="processing-instruction('pageBreak')">
	        <xsl:choose>
	            <xsl:when test="/descendant::processing-instruction('pageBreak')[position()=1]= .">
	                <span class="pageBreak rs_skip" id="{substring-before(substring-after(., 'pageno=&quot;'), '&quot;')}">
	                    <xsl:call-template name="getResourceString">
	                        <xsl:with-param name="key" select="'page.text'"/>
	                    </xsl:call-template>
	                    <xsl:call-template name="insert_space"/>
	                    <xsl:value-of select="substring-before(substring-after(., 'pageno=&quot;'), '&quot;')"/>
	                </span>
	            </xsl:when>
	            <xsl:otherwise>
	                <span class="pageBreak rs_skip" id="{substring-before(substring-after(., 'pageno=&quot;'), '&quot;')}">
	                    <xsl:call-template name="getResourceString">
	                        <xsl:with-param name="key" select="'page.text'"/>
	                    </xsl:call-template>
	                    <xsl:call-template name="insert_space"/>
	                    <xsl:value-of select="substring-before(substring-after(., 'pageno=&quot;'), '&quot;')"/>
	                    <xsl:call-template name="insert_space"/>
	                    <!--  Fix for EREF-1306 : GVRL: "Top of article" links missing from pagebreaks throughout product -->
	                                        <xsl:if test="$displayLinks = 'true'">
	                                                |
	                                                <xsl:call-template name="insert_space"/>
	                                                <a href="#contentcontainer"  class="js-top-of-page">
	                                                        <xsl:call-template name="getResourceString">
	                                                                <xsl:with-param name="key" select="'top.of.article'"/>
	                                                        </xsl:call-template>
	                                                </a>
	                                        </xsl:if>
	                </span>
	            </xsl:otherwise>
	        </xsl:choose>
    </xsl:template>
    <xsl:template match="pres:horizontal-rule">
        <hr/>
    </xsl:template>
    <!-- begin fields for table namespace -->
    <xsl:template match="table:table">
        <table class="bodyTextTable" cellspacing="0">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </table>
    </xsl:template>
    <xsl:template match="table:caption">
        <caption>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </caption>
    </xsl:template>
    <xsl:template match="table:col">
        <col>
            <xsl:copy-of select="@*"/>
        </col>
    </xsl:template>
    <xsl:template match="table:colgroup">
        <colgroup>
            <xsl:copy-of select="@*"/>
        </colgroup>
    </xsl:template>
    <xsl:template match="table:thead">
        <thead>
            <xsl:apply-templates select="node()"/>
        </thead>
    </xsl:template>
    <xsl:template match="table:tfoot">
        <tfoot>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </tfoot>
    </xsl:template>
    <xsl:template match="table:tbody">
        <tbody>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </tbody>
    </xsl:template>
    <xsl:template match="table:tr">
        <tr>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </tr>
    </xsl:template>
    <xsl:template match="table:th">
        <th>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </th>
    </xsl:template>
    <xsl:template match="table:td">
        <td>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </td>
    </xsl:template>
    <xsl:template match="list:ul">
                <xsl:choose>
                        <xsl:when test="count(list:title) > 0 ">
                            <xsl:apply-templates mode="list"/>
                        </xsl:when>
            <xsl:when test="count(list:li) > 0">
                <ul>
                    <xsl:apply-templates select="list:li"/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                        <!-- do nothing, empty list -->
                        </xsl:otherwise>
                </xsl:choose>
    </xsl:template>
    <xsl:template match="list:ol">
        <ol>
            <xsl:apply-templates select="list:li"/>
        </ol>
    </xsl:template>
    <xsl:template match="list:li">
        <li>
            <xsl:apply-templates select="node()"/>
        </li>
    </xsl:template>
    <xsl:template match="list:li" mode="list">
                <ul>
                <li>
                        <xsl:apply-templates select="node()"/>
                        </li>
                </ul>
    </xsl:template>
    <xsl:template match="list:dl">
        <dl>
            <xsl:apply-templates select="node()"/>
        </dl>
    </xsl:template>
    <xsl:template match="list:dt">
        <dt>
            <xsl:apply-templates select="node()"/>
        </dt>
    </xsl:template>
    <xsl:template match="list:dd">
        <dd>
            <xsl:apply-templates select="node()"/>
        </dd>
    </xsl:template>
        <xsl:template match="span[@class='hitHighlite']">
                <span class="hitHighlite">
            <xsl:apply-templates />
        </span>
        </xsl:template>
 
        <xsl:template match="verse:verse">
                <div class="poem">
                        <xsl:apply-templates select="node()"/>                                                         
                </div>
    </xsl:template>
 
    <xsl:template match="verse:line">
         <xsl:if test="node()">
                        <div class="poemLine">
                                <xsl:apply-templates select="node()"/>
                                <br/>
                        </div>
                 </xsl:if>
    </xsl:template>
 
    <xsl:template match="verse:linegroup">
                <xsl:if test="node()">
                        <div class="poemLineGroup">
                                <xsl:apply-templates select="node()"/>
                        </div>
                </xsl:if>      
    </xsl:template>
 
        <xsl:template match="verse:space">
                <xsl:variable name="leadingSpace" select="@space-num"/>
                <xsl:element name="span">
                        <xsl:attribute name="style">
                                <xsl:value-of select="concat('margin-left:',$leadingSpace,'px')"/>
                        </xsl:attribute>
                        <xsl:call-template name="insert_space"/>
                </xsl:element>
        </xsl:template>
 
    <xsl:template match="gift-doc:vendor-images">
        <!-- suppress full-text images -->
    </xsl:template>
 
    <xsl:template match="dict:primary-term">
        <!-- suppress dictionary terms -->
    </xsl:template>
 
        <xsl:template match="dict:dictionary-entry">
                 <xsl:apply-templates select="dict:composed-entry" />
    </xsl:template>
       
    <xsl:template match="dict:composed-entry">
        <div class="dictionaryTerms"><xsl:apply-templates /></div>
    </xsl:template>
       
    <!-- pass-through unknown elements -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="media:video">
        <xsl:apply-templates />
    </xsl:template>
 
</xsl:stylesheet>
