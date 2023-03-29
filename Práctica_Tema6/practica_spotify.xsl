<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" omit-xml-declaration="yes" />

<xsl:template match="/">
		<html>
            <xsl:attribute name="lang">es</xsl:attribute> <!-- Usamos xsl:attribute para implementar un atributo que nos especifique en que idioma está nuestro xsl -->
			<head>
                <xsl:apply-templates select="spotify" />
                <style type="text/css"> <!-- Le agregamos estilo a nuestra página para que sea más atractiva visualmente -->
                    body {
                        background-color: #D3D1D3;
                        font-family: Arial, sans-serif;
                        font-size: 16px;
                    }
                    th{
                        background-color: #7294EE;
                    }
                    td{
                        background-color: white;
                    }
                    .color{
                        color: #757575;
                    }
                    #ganador {
                        color: #7294EE;
                        text-align: center;
                        text-transform: uppercase;
                    }
                    footer {
                        text-align: right;
                        background-color: #C29AE7;
                        color: #FFFFFF;
                    }
                    .pfooter{
                        font-size: 14px;
                    }
                </style>
            </head>
            <body>
                <h1><xsl:value-of select="spotify/titulo"/></h1>
                <table style="width:100%;" border="1"> <!-- Generamos una tabla para almacenar los datos sobre las 6 canciones -->
                    <tr>
                        <th>Nº reproducciones</th>
                        <th>Canción</th>
                        <th>Duración</th>
                        <th>Álbum</th>
                        <th>Fecha lanzamiento álbum</th>
                        <th>Artista</th>
                    </tr>
                    <xsl:apply-templates select="spotify/lista_de_reproduccion/cancion">
                        <xsl:sort select="translate(numreproducciones, '.', '')" data-type="number" order="descending"/> <!-- Nos va a ordenar el número de reproducciones de manera descendente y para que nos detecte el número, cambiaremos el separador del . por nada -->
                    </xsl:apply-templates>
                </table>
                <h2 class="color"><xsl:value-of select="spotify/caratula_album/top"/></h2>
                <p>La canción más escuchada pertenece al álbum...</p>
                <xsl:for-each select="spotify/caratula_album/album"> 
                    <xsl:if test="artista ='Chris Brown'"> <!-- Contiene una plantilla que se aplicará solo si se cumple esta condición -->
                        <h2 id="ganador"><xsl:value-of select="disco"/></h2>
                        <p>Algunas canciones más de ese álbum son:</p>
                        <ul id="lista">
                            <xsl:for-each select="track">
                                <li><xsl:value-of select="."/></li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                </xsl:for-each>
                
                <h2 class="color"><xsl:value-of select="spotify/caratula_album/sub"/></h2>
                <p>¡No podemos dejar atrás a nuestro segundo y tercer puesto!</p>
                <xsl:apply-templates select="spotify/caratula_album/album"/> <!-- Implementamos choose:when -->
    
                <footer>
                    <p class="pfooter"><xsl:text>¡</xsl:text>Muchas gracias por vuestra atención<xsl:text>!</xsl:text></p><p class="pfooter">Trabajo realizado por Claudia Palazón Gómez</p> <!-- Añadimos los signos de exclamación con la etiqueta xsl:text -->
                </footer>
            </body>
		</html>
</xsl:template>

<!-- Todos los templates que aplicaremos en nuestra estructura HTML -->
<xsl:template match="spotify">
    <title><xsl:value-of select="@nombre"/></title>
</xsl:template>

<xsl:template match="cancion">
	<tr>
        <td><xsl:value-of select="numreproducciones"/></td>
		<td><xsl:value-of select="nombre"/></td>
		<td><xsl:value-of select="duracion"/></td>
		<td><xsl:value-of select="album"/></td>
		<td><xsl:value-of select="fecha_album"/></td>
		<td><xsl:value-of select="artista"/></td>
	</tr>
</xsl:template>

<xsl:template match="spotify/caratula_album/album">
<ul>
    <xsl:choose>
          <xsl:when test="id=2">
            <xsl:apply-templates select="track"/>
          </xsl:when>
          <xsl:when test="id=3">
            <xsl:apply-templates select="genero"/>
          </xsl:when>
          <xsl:otherwise>
            <p>Mostramos el tracklist del segundo artista y el género musical del tercero:</p>
          </xsl:otherwise>
    </xsl:choose>
</ul>
</xsl:template>

<xsl:template match="track">
    <li><xsl:value-of select="."/></li>
</xsl:template>

<xsl:template match="genero">
    <li><xsl:value-of select="."/></li>
</xsl:template>

</xsl:stylesheet>