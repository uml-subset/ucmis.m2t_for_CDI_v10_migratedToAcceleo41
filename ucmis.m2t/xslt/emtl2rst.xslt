<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:java="http://www.java.com/" xmlns:xmi="http://www.omg.org/XMI" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mtl="http://www.eclipse.org/acceleo/mtl/3.0">
	<xsl:output method="text"/>
	<xsl:variable name="HEADER_UNDERLINE1" select=" '############################################################' "/>
	<xsl:variable name="HEADER_UNDERLINE3" select=" '------------------------------------------------------------' "/>
	<xsl:variable name="PROJECT_DIR">
		<xsl:analyze-string select="static-base-uri()" regex="(.*)/xslt/emtl2rst\.xslt">
			<xsl:matching-substring>
				<xsl:value-of select="regex-group(1)"/>
			</xsl:matching-substring>
		</xsl:analyze-string>
	</xsl:variable>
	<xsl:variable name="EMTL_DIR" select=" 'bin/ucmis/m2t/' "/>
	<!--
	main -->
	<xsl:template match="/">
		<xsl:apply-templates select="/xmi:XMI/mtl:Module"/>
	</xsl:template>
	<!--
	module -->
	<xsl:template match="mtl:Module">
		<xsl:variable name="path">
			<xsl:value-of select="@name"/>
			<xsl:text>.rst</xsl:text>
		</xsl:variable>
		<xsl:result-document href="{$path}" method="text" encoding="UTF-8">
			<xsl:variable name="header">
				<xsl:text>Module </xsl:text>
				<xsl:value-of select="@name"/>
			</xsl:variable>
			<xsl:text>.. Created on the basis of the file </xsl:text>
			<xsl:value-of select="base-uri()"/>
			<xsl:text> on </xsl:text>
			<xsl:value-of select="current-date()"/>
			<xsl:text>.

.. _</xsl:text>
			<xsl:value-of select="@nsURI"/>
			<xsl:text>:

</xsl:text>
			<xsl:value-of select="$header"/>
			<xsl:text>
</xsl:text>
			<xsl:value-of select="substring( $HEADER_UNDERLINE1, 1, string-length($header) )"/>
			<xsl:text>

**Namespace URI:** </xsl:text>
			<xsl:value-of select="@nsURI"/>
			<xsl:text>

</xsl:text>
			<xsl:choose>
				<xsl:when test="documentation/body/@value">
					<xsl:value-of select="normalize-space( documentation/body/@value )"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>*no documentation available*</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="imports">
				<xsl:text>
			
Imported modules:

</xsl:text>
				<xsl:apply-templates select="imports"/>
			</xsl:if>
			<xsl:if test="ownedModuleElement[@xsi:type='mtl:Query'][not(starts-with(@name, 'X'))]">
				<xsl:text>
Queries
=======

</xsl:text>
				<xsl:apply-templates select="ownedModuleElement[@xsi:type='mtl:Query'][not(starts-with(@name, 'X'))]" mode="content">
					<xsl:sort select="@name"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="ownedModuleElement[@xsi:type='mtl:Template'][not(starts-with(@name, 'X'))]">
				<xsl:text>
Templates
=========

</xsl:text>
				<xsl:apply-templates select="ownedModuleElement[@xsi:type='mtl:Template'][not(starts-with(@name, 'X'))]" mode="content">
					<xsl:sort select="@name"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:text>

</xsl:text>
		</xsl:result-document>
		<xsl:apply-templates select="ownedModuleElement[@xsi:type='mtl:Query' or @xsi:type='mtl:Template'][not(starts-with(@name, 'X'))]" mode="file"/>
		<!--
		<xsl:apply-templates select="ownedModuleElement[@xsi:type='mtl:Query'][@name='rst_addClassReferencesToDocumentation']" mode="content"/>
		<xsl:apply-templates select="ownedModuleElement[@xsi:type='mtl:Template'][@name='rst_subClasses']" mode="content"/>
		-->
	</xsl:template>
	<!--
	query or template - toc entry -->
	<xsl:template match="ownedModuleElement" mode="tocEntry">
		<xsl:text>   </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>.rst
</xsl:text>
	</xsl:template>
	<!--
	query or template - file -->
	<xsl:template match="ownedModuleElement" mode="file">
		<xsl:variable name="name" select="@name"/>
		<!--		<xsl:variable name="base-file" select="tokenize(base-uri(),'/')[last()]"/>
		<xsl:variable name="base-uri-dir" select="substring-before(base-uri(), $base-file)"/>
		<xsl:variable name="relative-dir" select="substring-after($base-uri-dir, $basedir)"/>
		<xsl:variable name="target-dir" select="concat($destdir, $relative-dir )"/>
		<xsl:variable name="reldir1" select="substring-after(base-uri(), $emtl_dir)"/>
		<xsl:variable name="reldir2">
			<xsl:analyze-string select="$reldir1" regex="(.*[/])">
				<xsl:matching-substring>
					<xsl:message>
						<xsl:text>
Xreldir2: </xsl:text>
						<xsl:value-of select="regex-group(1)"/>
					</xsl:message>
					<xsl:value-of select="regex-group(1)"/>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</xsl:variable>
		<xsl:variable name="index-file" select="concat($reldir2, '/', 'index.rst' )"/>
		-->
		<!--		<xsl:variable name="index-file" select="concat($target-dir, '/', 'index.rst' )"/>
-->
		<!--
		<xsl:message>
			<xsl:text>
base-uri(): </xsl:text>
			<xsl:value-of select="base-uri()"/>
			<xsl:text>
base-file: </xsl:text>
			<xsl:value-of select="$base-file"/>
			<xsl:text>
basedir: </xsl:text>
			<xsl:value-of select="$basedir"/>
			<xsl:text>
reldir1: </xsl:text>
			<xsl:value-of select="$reldir1"/>
			<xsl:text>
reldir2: </xsl:text>
			<xsl:value-of select="$reldir2"/>
			<xsl:text>
b: </xsl:text>
			<xsl:value-of select="$b"/>
			<xsl:text>
b2: </xsl:text>
			<xsl:value-of select="$b2"/>
		</xsl:message>
-->
		<!-- if index file doesn't exist -->
		<!--		<xsl:if test="string-length( uri-collection(concat($target-dir, '?select=index.rst') )[position()=1] ) = 0">
			<xsl:result-document href="{$index-file}" method="text" encoding="UTF-8">
				<xsl:text>.. Created on the basis of </xsl:text>
				<xsl:value-of select="base-uri()"/>
				<xsl:text> on </xsl:text>
				<xsl:value-of select="current-date()"/>
				<xsl:text>.

</xsl:text>
				<xsl:text>.. toctree::
   :glob:
   
   *</xsl:text>
			</xsl:result-document>
		</xsl:if>
-->
		<!-- if first item of polymorphism -->
		<xsl:if test="$name != preceding-sibling::ownedModuleElement[1]/@name">
			<!--			<xsl:variable name="path">
				<xsl:value-of select="$name"/>
				<xsl:text>.rst</xsl:text>
			</xsl:variable>
			<xsl:result-document href="{$path}" method="text" encoding="UTF-8">
				<xsl:text>.. Created on the basis of </xsl:text>
				<xsl:value-of select="base-uri()"/>
				<xsl:text> on </xsl:text>
				<xsl:value-of select="current-date()"/>
				<xsl:text>.

.. _</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>:

</xsl:text>
				<xsl:apply-templates select="../ownedModuleElement[@name=$name]" mode="content"/>
			</xsl:result-document>
-->
		</xsl:if>
	</xsl:template>
	<!--
	query or template - content -->
	<xsl:template match="ownedModuleElement" mode="content">
		<xsl:variable name="type" select="substring-after(@xsi:type, 'mtl:')"/>
		<xsl:variable name="header">
			<xsl:value-of select="$type"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<xsl:text>
.. _</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>:

</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>
</xsl:text>
		<xsl:value-of select="substring( $HEADER_UNDERLINE3, 1, string-length(@name) )"/>
		<xsl:text>

**</xsl:text>
		<xsl:value-of select="$type"/>
		<xsl:text> in module** </xsl:text>
		<xsl:variable name="bin-dir" select="concat( $PROJECT_DIR, '/bin/')"/>
		<xsl:variable name="module-name" select="substring-before( substring-after( base-uri(), $bin-dir ), '.emtl' )"/>
		<xsl:value-of select="replace( $module-name, '/', '::' )"/>
		<xsl:text>
		
</xsl:text>
		<xsl:choose>
			<xsl:when test="documentation/body/@value">
				<xsl:value-of select="normalize-space( substring-before( documentation/body/@value, '@param' ) )"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>*no documentation available*</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>

:Visibility: </xsl:text>
		<xsl:value-of select="@visibility"/>
		<xsl:text>

.. topic:: Parameters
</xsl:text>
		<xsl:apply-templates select="parameter" mode="rst"/>
		<xsl:if test="type">
			<xsl:apply-templates select="type"/>
		</xsl:if>
		<xsl:if test=".//body[@xsi:type='mtl:TemplateInvocation']">
			<!-- TODO: mtl:QueryInvocation -->
			<xsl:text>

.. topic:: Depends on
</xsl:text>
			<xsl:apply-templates select=".//body[@xsi:type='mtl:TemplateInvocation']"/>
		</xsl:if>
		<xsl:text>

</xsl:text>
		<xsl:call-template name="source"/>
		<xsl:text>

</xsl:text>
	</xsl:template>
	<!--
	-->
	<xsl:template match="parameter" mode="rst">
		<xsl:variable name="name" select="@name"/>
		<xsl:variable name="type" select="@eType | eType/@href"/>
		<xsl:text>
   </xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text> : </xsl:text>
		<xsl:value-of select="tokenize($type,'/')[last()]"/>
		<xsl:text>
      </xsl:text>
		<xsl:choose>
			<xsl:when test="../documentation/parametersDocumentation[@name=$name]/body/@value">
				<xsl:value-of select="normalize-space( ../documentation/parametersDocumentation[@name=$name]/body/@value )"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>*no documentation available*</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	-->
	<xsl:template match="type">
		<xsl:variable name="type" select="@href"/>
		<xsl:text>

.. topic:: Return value

   *</xsl:text>
		<xsl:value-of select="tokenize($type,'/')[last()]"/>
		<xsl:text>*

</xsl:text>
	</xsl:template>
	<!--
	Depends on -->
	<xsl:template match="body[@xsi:type='mtl:TemplateInvocation']">
		<xsl:text>
   | :ref:`</xsl:text>
		<xsl:value-of select="tokenize(@definition,'/')[last()]"/>
		<xsl:text>`</xsl:text>
	</xsl:template>
	<!--
	Include source code -->
	<xsl:template name="source">
		<xsl:variable name="mtl-file" select="concat( substring-before( base-uri(), '.emtl' ), '.mtl' )"/>
		<xsl:variable name="mtl-code" select="unparsed-text( $mtl-file )"/>
		<!-- approach necessary because of template/query polymorphism -->
		<xsl:variable name="regex">
			<xsl:text>(\[</xsl:text>
			<xsl:value-of select="substring-after(@xsi:type, 'mtl:')"/>
			<xsl:text>\s+</xsl:text>
			<xsl:value-of select="@visibility"/>
			<xsl:text>\s+</xsl:text>
			<xsl:value-of select="@name"/>
			<xsl:text>\s*\(\s*</xsl:text>
			<xsl:apply-templates select="parameter" mode="module-element-parameter"/>
			<xsl:text>\s*\)</xsl:text>
			<xsl:text>(.|\n|\r)+?</xsl:text>
			<xsl:text>\[/</xsl:text>
			<xsl:if test="@xsi:type='mtl:Template'">
				<xsl:text>template</xsl:text>
			</xsl:if>
			<xsl:text>\])</xsl:text>
		</xsl:variable>
		<xsl:text>.. dropdown:: Acceleo Source Code (.mtl)

   .. code-block::
      :linenos:

      </xsl:text>
		<xsl:analyze-string select="$mtl-code" regex="{$regex}" flags="i">
			<xsl:matching-substring>
				<xsl:value-of select="replace( regex-group(1), '&#xA;', '&#xA;      ') "/>
			</xsl:matching-substring>
		</xsl:analyze-string>
	</xsl:template>
	<!--
	module element parameters for regex -->
	<xsl:template match="parameter" mode="module-element-parameter">
		<xsl:variable name="type" select="@eType | eType/@href"/>
		<xsl:if test="position()>1">
			<xsl:text>\s*,\s*</xsl:text>
		</xsl:if>
		<xsl:value-of select="@name"/>
		<xsl:text>\s*:\s*</xsl:text>
		<xsl:value-of select="tokenize($type,'/')[last()]"/>
	</xsl:template>
	<!--
	 -->
	<xsl:template match="imports">
		<xsl:variable name="nsURI" select="replace( substring-before( substring-after(@href, 'platform:/resource/'), '.emtl#/0' ), '/', '::' )"/>
		<xsl:text>-  :ref:`</xsl:text>
		<xsl:value-of select="replace( $nsURI, 'ucmis.m2t::bin::', '' )"/>
		<xsl:text>`
</xsl:text>
	</xsl:template>
</xsl:stylesheet>