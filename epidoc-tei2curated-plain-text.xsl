<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" indent="no"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//body/div"/>
    </xsl:template>
    <xsl:template match="desc"/>
    <xsl:template match="note"/>
    <xsl:template match="gap">
       <xsl:choose>
            <xsl:when test="@unit eq 'character' and number(@quantity) lt 4">
                [<xsl:for-each select="1 to @quantity">
                   <xsl:text>.</xsl:text>
                </xsl:for-each>]
            </xsl:when>
           <xsl:when test="@unit eq 'character' and number(@quantity) gt 3">
               <xsl:value-of select="'[...' || @quantity || 'c]'"/>
           </xsl:when>
           
           <xsl:when test="@unit eq 'lines'">
               <xsl:value-of select="'[...' || @quantity || 'l]'"/>
           </xsl:when>
           <xsl:otherwise>
               [ ]
           </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>