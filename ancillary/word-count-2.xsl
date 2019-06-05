<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:variable name="centuries" select="distinct-values(//date/@n)"/>
        <xsl:variable name="bibl" select="//bibl"/>
        <xsl:result-document href="century-genres_sans-pliny-livy.csv">
            <xsl:for-each select="1 to count($centuries)">
                <xsl:variable name="c" select="$centuries[current()]"/>
                <xsl:variable name="genres" select="distinct-values($bibl[descendant::date/@n = $centuries[current()]]//term)"/>
                <xsl:for-each select="1 to count($genres)">
                    <xsl:variable name="count"
                        select="sum($bibl[descendant::date/@n = $c][descendant::term = $genres[current()]]/descendant::measure/@quantity)"/>
                    <xsl:value-of select="concat($c,';',$genres[current()], ';', $count, '&#xA;')"/>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
