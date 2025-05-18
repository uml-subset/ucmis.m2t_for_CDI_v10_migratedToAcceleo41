<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StandardProfile="http://www.omg.org/spec/UML/20131001/StandardProfile" xmlns:uml="http://www.eclipse.org/uml2/5.0.0/UML" xmlns:xmi="http://www.omg.org/spec/XMI/20131001">
	<!-- - - - - - - - - - - -->
	<xsl:template match="/">
		<xsl:apply-templates select="/xmi:XMI/uml:Model[@xmi:id='UCMISExample']//packagedElement[@xmi:type='uml:Class' or @xmi:type='uml:DataType' or @xmi:type='uml:Enumeration' or @xmi:type='uml:PrimitiveType']"/>
	</xsl:template>
	<!-- - - - - - - - - - - -->
	<xsl:template match="packagedElement[@xmi:type='uml:Class' or @xmi:type='uml:DataType' or @xmi:type='uml:Enumeration' or @xmi:type='uml:PrimitiveType']">
		<xsl:variable name="ClassifierName" select="name"/>
		<xsl:result-document href="{$ClassifierName}.xmi" method="xml" encoding="UTF-8" indent="yes">
			<xsl:copy-of select="."/>
		</xsl:result-document>
	</xsl:template>
	<!-- - - - - - - - - - - -->
</xsl:stylesheet>