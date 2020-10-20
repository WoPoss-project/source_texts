<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.eagle-network.eu/eagle"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml"/>
    <xsl:template match="/">
        <xsl:result-document href="metadata.csv">
            <xsl:text>ID&#x09;Title&#x09;Date&#x09;Source
</xsl:text>
            <xsl:apply-templates select="descendant::eagleObject" mode="metadata"/>
        </xsl:result-document>
        <xsl:result-document href="vindolanda.txt">
            <xsl:apply-templates select="descendant::eagleObject" mode="transcription"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="eagleObject" mode="transcription">
        <xsl:apply-templates select="descendant::title"/>
        <xsl:apply-templates select="descendant::textEpidoc"/>
    </xsl:template>
    
    <xsl:template match="eagleObject" mode="metadata">        
        <xsl:variable name="date" select="if(string-length(descendant::originDating) gt 0) then descendant::originDating else string-join(descendant::originDating/@*)"/>
        
        <xsl:value-of select="dnetResourceIdentifier || '&#x09;' || title || '&#x09;' || $date || '&#x09;' || recordSourceInfo/@landingPage || '&#x0A;'"/>
        
    </xsl:template>
    <xsl:template match="gap">
        <xsl:for-each select="1 to @extent">
            <xsl:text>.</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>