<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" indent="no"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//body/div/div"/>
    </xsl:template>
    
    <xsl:template match="div">
        \|
        <xsl:apply-templates/>
        |/
    </xsl:template>
    <xsl:template match="ab">
        \
        <xsl:apply-templates/> 
    </xsl:template>
    <xsl:template match="lb[@type eq 'paragraph']">
        /
        \
    </xsl:template>
    <xsl:template match="note"/>
    <xsl:template match="q">
        “<xsl:apply-templates/>”
    </xsl:template>
    <xsl:template match="foreign">
        ¡<xsl:apply-templates/>!
    </xsl:template>
    <xsl:template match="hi">
        {<xsl:apply-templates/>}
    </xsl:template>
    <xsl:template match="gap">
        <xsl:text>[...]</xsl:text>
    </xsl:template>
    <xsl:template match="lg">
        [[
        <xsl:apply-templates select="l"/>
            ]]
    </xsl:template>
    <xsl:template match="l">
        [<xsl:apply-templates/>]
    </xsl:template>
    <xsl:template match="del">
        ((<xsl:apply-templates/>))
    </xsl:template>
</xsl:stylesheet>