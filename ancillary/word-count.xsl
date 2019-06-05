<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text"/>
    <xsl:template match="/">        
        <xsl:variable name="genres" select="distinct-values(//term)"/>
        <xsl:variable name="centuries" select="distinct-values(//date/@n)"/>
        <xsl:variable name="bibl" select="//bibl"/>
        <xsl:result-document href="genre-sans-livy-pliny.csv">
            <xsl:for-each select="1 to count($genres)">
                <xsl:variable name="count" select="sum($bibl[descendant::term = $genres[current()]]/descendant::measure/@quantity)"/>
                <xsl:value-of select="concat($genres[current()], ';', $count, '&#xA;')"/>
            </xsl:for-each>
        </xsl:result-document>
        <xsl:result-document href="century-sans-livy-pliny.csv">
            <xsl:for-each select="1 to count($centuries)">
                <xsl:variable name="count" select="sum($bibl[descendant::date/@n = $centuries[current()]]/descendant::measure/@quantity)"/>
                <xsl:value-of select="concat($centuries[current()], ';', $count, '&#xA;')"/>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>