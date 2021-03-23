<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" indent="no"/>
    <xsl:template match="/">
        <xsl:variable name="title" select="replace(substring-after(document-uri(current()),'cicero_source/'), '\.', '_')"/>
       <xsl:result-document href="{$title}.txt">
           <xsl:apply-templates select="//body"/>
       </xsl:result-document>
    </xsl:template>
    <xsl:template match="note"/>
</xsl:stylesheet>