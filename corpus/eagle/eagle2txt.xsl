<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.eagle-network.eu/eagle" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        <xsl:param name="repo"
            select="base-uri() => substring-after('source/') => substring-before('.xml')"
            tunnel="yes"/>
        <xsl:result-document href="metadata/metadata_{$repo}.csv">
            <xsl:apply-templates
                select="descendant::eagleObject[contains(dnetResourceIdentifier, 'transcription')][descendant::text[not(@lang eq 'grc')]][descendant::text[not(contains(., 'No text'))]][descendant::textHtml[not(contains(., 'No text'))]][string-length(descendant::transcription/text) gt 0]"
                mode="metadata"/>
        </xsl:result-document>
        <xsl:apply-templates
            select="descendant::eagleObject[contains(dnetResourceIdentifier, 'transcription')][descendant::text[not(@lang eq 'grc')]][descendant::text[not(contains(., 'No text'))]][descendant::textHtml[not(contains(., 'No text'))]][string-length(descendant::transcription/text) gt 0]"
            mode="transcription"/>
    </xsl:template>
    <xsl:template match="eagleObject" mode="transcription">
        <xsl:variable name="uri"
            select="dnetResourceIdentifier => substring-before('::transcription') => replace('::', '_')"/>
        <xsl:result-document href="{$uri}.txt">
            <xsl:apply-templates select="descendant::transcription"/>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="transcription">
        <xsl:choose>
            <xsl:when test="string-length(descendant::textEpidoc) gt 0">
                <xsl:choose>
                    <xsl:when test="descendant::textEpidoc/tei:ab[@type eq 'original']">
                        <xsl:apply-templates
                            select="descendant::textEpidoc/tei:ab[@type eq 'original']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(descendant::textEpidoc) => replace('[⟦⟧〈〉\(\)\[\]\|\?\-/]', '')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text => replace('[⟦⟧〈〉\(\)\[\]\|\?\-/]', '') => normalize-space()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ab">
        <xsl:value-of select="normalize-space(replace(., '[⟦⟧〈〉\(\)\[\]\|\?\-/]', ''))"/>
    </xsl:template>
    <xsl:template match="eagleObject" mode="metadata">
        <xsl:variable name="uri"
            select="dnetResourceIdentifier => substring-before('::transcription') => replace('::', '_')"/>

        <xsl:variable name="date" select="
                if (string-length(descendant::originDating) gt 0) then
                    normalize-space(descendant::originDating)
                else
                    string-join(descendant::originDating/@*, '-')"/>

        <xsl:value-of
            select="$uri || '&#x09;' || normalize-space(title) || '&#x09;' || $date || '&#x09;' || normalize-space(recordSourceInfo/@providerName) || '&#x09;' || recordSourceInfo/@landingPage || '&#x0A;'"/>

    </xsl:template>
    <!--    <xsl:template match="gap">
        <xsl:for-each select="1 to @extent">
            <xsl:text>.</xsl:text>
        </xsl:for-each>
    </xsl:template>-->
</xsl:stylesheet>
