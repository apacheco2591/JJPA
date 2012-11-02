<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="screen" href="./style/default.css">
<title>MotorSales - Ofertas de coches</title>
</head>
<body>

	<!-- Contenedor de toda la pagina -->
	<div id="pagina">
	
		<!-- Contenedor de la cabecera -->
		<div id="arriba">
		
			<!-- Logo  -->
			<div id="logo">
				<img alt="logoMotorSales" src="./img/MotorSalesImage2.png" width="100%" height="100%;"/>
			</div>
			<!-- Fin logo -->
			
			<!-- Columna de la publicidad -->
			<div id="colizq">
			
				<div id="banner">
				<c:if test="${requestScope.publicidad.banner != null }">
					<img id="imagen_banner" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
				</c:if>
				</div>
				<div id="texto_publicidad">
					<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
				</div>
			</div>
			<!-- Fin columna de la publicidad -->
			
			<!-- Columna del login -->
			<div id="colder">
				
				<div id="login">
				<c:choose>
					<c:when test="${empty sessionScope.usuario}">

						<!-- Visualización de los mensajes de error -->
						<c:if test="${errores != null }">
							<p style="color: red">
							<c:forEach items="${errores }" var="error">
								<c:out value="${error }"></c:out><br />
							</c:forEach>
							</p>
						</c:if>
						
						<form action="login" method="post">
							<div class="fila">
								<div id="logiz">
									<label for="nom">Usuario:</label>
								</div>
								<div id="logder">
									 <input type="text" name="nombre" id="nom"><br> 
								 </div>
							 </div>
							 <div class="fila">
							 	<div id="logiz">
									<label for="clave">Contrase&ntilde;a:</label> 
								</div>
								<div id="logder">
									<input type="password" name="clave" id="clave"><br />
								</div>
							</div>
							<input type="hidden" name="origen" value="motos" />
							<input class="button" type="submit" value="Iniciar sesi&oacute;n">
							<a href="nuevo_usuario">Nuevo Usuario</a>
						</form>
					
					</c:when>
					<c:otherwise>

							<p>
								Usuario: <b><c:out value="${sessionScope.usuario.nombreUsuario} "></c:out></b>
							</p>
							<%-- <a href="opciones_personales">Opciones personales</a>
							<c:if test="${sessionScope.usuario.vendedor == true }">
								<a href="nuevo_vehiculo">Nuevo Vehiculo</a>
							</c:if>
							<c:if test="${sessionScope.usuario.publicista == true }">
								<a href="nueva_publicidad">Nueva publicidad</a>
							</c:if>
							<c:if test="${sessionScope.usuario.administrador == true }">
								<a href="../administracion/">Labores de administracion</a>
							</c:if> --%>
							<a href="logout?origen=motos">Salir</a>
						
					</c:otherwise>
				</c:choose>
				</div>
				
			</div>
			<!-- Fin columna del login -->
		
		</div>
		<!-- Fin contenedor de la cabecera -->
		
		<!-- Contenedor del cuerpo de la página -->
		<div id="principal">
		
			<!-- Menú -->
			<div id="tabla">
			
				<div id="tabla2">
					<ul>
						<a href='default.jsp'><li>Inicio</li></a>
						<a href='coches'><li>Coches</li></a>
						<a href='motos'><li>Motos</li></a>
						<c:if test="${!empty sessionScope.usuario }">
							<HR width=90% align="center">
							<a href='opciones_personales'><li>Datos de usuario</li></a>
							<c:if test="${sessionScope.usuario.vendedor }">
								<a href="nuevo_vehiculo"><li>Nuevo Vehiculo</li></a>
							</c:if>
							<c:if test="${sessionScope.usuario.publicista }">
								<a href="nueva_publicidad"><li>Nueva publicidad</li></a>
							</c:if>
							<c:if test="${sessionScope.usuario.administrador == true }">
								<a href="../administracion/"><li>Labores de administracion</li></a>
							</c:if>
							<HR width=90% align="center">
							<a href="logout?origen=coches"><li>Salir</li></a>
						</c:if>
					</ul>
				</div>
			
			</div>
			<!-- Fin menú -->
			
			<!-- Contenido del cuerpo de la página -->
			<div id="centro">
				<center><h1>Anuncios de Motos</h1></center>
				<div id="tabla_ve_hiculos">
					<div class="fila_vehiculos">
						<div class="celda_vehiculos_texto">
							<b>Imagen</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Marca</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Modelo</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Precio</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>KMs</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Años</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Color</b>
						</div>
						<div class="celda_vehiculos_texto">
							<b>Descripción</b>
						</div>
						
					</div>
					
					<c:set var="i" value="${1 }"></c:set>
					<c:forEach items="${requestScope.listaVehiculos }" var="vehiculo">
						<c:if test="${i%2 == 1 }"><div class="fila_vehiculos_impar"></c:if>
						<c:if test="${i%2 == 0 }"><div class="fila_vehiculos"></c:if>
						
							<div class="celda_vehiculos">
								<c:if test="${vehiculo.foto != null }">
									<a href="./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>">
										<img src="<c:out value="${vehiculo.foto }"></c:out>" width="100%" height="100%" />
									</a>
								</c:if>
								<c:if test="${vehiculo.foto == null }">SIN<br /> FOTO</c:if>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.marca }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.modelo }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.precio }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.km }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.añosMatricula }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.color }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<c:out value="${vehiculo.matricula }"></c:out>
							</div>
							<div class="celda_vehiculos_texto">
								<a href='./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&origen=coches'>Ver detalles</a>
							</div>
						</div>
						<c:set var="i" value="${i+1 }"></c:set>
					</c:forEach>
				</div>
				
			</div>
			<!-- Fin contenido del cuerpo de la página -->
			
		</div>
		<!-- Fin del contenedor del cuerpo de la pagina -->
		
		<!-- Pie de página -->
		<div id="pies">
		
		</div>
		<!-- Fin pie de página -->
		
	</div>
	<!-- Fin contenedor de toda la pagina -->
</body>
</html>