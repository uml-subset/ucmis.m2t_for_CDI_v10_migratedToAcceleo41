<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes"/>
	<!--
Entry point -->
	<xsl:template match="/">
		<xsl:apply-templates select="@* | node()"/>
	</xsl:template>
	<!--
identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!--
remove suffix 'XsdType' in name of type -->
	<xsl:template match="@base | @name | @type">
		<xsl:attribute name="{local-name()}">
			<xsl:choose>
				<xsl:when test="ends-with( ., 'XsdType' )">
					<xsl:value-of select="substring-before( ., 'XsdType' )"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>