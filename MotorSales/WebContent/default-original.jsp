<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>default.jsp</title>
</head>
<body>

	<center><h1>Default.jsp</h1></center>
	
	<!-- Inserción de la publicidad -->
	<p>
	<c:if test="${requestScope.publicidad.banner != null }">
		<img height="50px" width="150px" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
	</c:if>
	<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
	</p>

	
	<!-- Formulario de login o nombre de usuario y opciones propias -->
	<c:choose>
		<c:when test="${empty sessionScope.usuario}">
			<fieldset>
			<legend>Formulario de login</legend>
				
			<!-- Visualización de los mensajes de error -->
			<c:if test="${errores != null }">
				<c:forEach items="${errores }" var="error">
					<p style="color: red"><c:out value="${error }"></c:out></p>
				</c:forEach>
			</c:if>
			
			<form action="login" method="post">
				<label for="nom">Usuario:</label> <input type="text" name="nombre" id="nom"><br> 
				<label for="clave">Contrase&ntilde;a:</label> 
				<input type="password" name="clave" id="clave"><br />
				<input type="submit" value="Iniciar sesi&oacute;n">
				<a href="nuevo_usuario">Nuevo Usuario</a>
			</form>
			</fieldset>
		</c:when>
		<c:otherwise>
			<fieldset>
				<legend>Bienvenido</legend>
				<p>
					Usuario: <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out>
				</p>
				<a href="opciones_personales">Opciones personales</a>
				<c:if test="${sessionScope.usuario.vendedor == true }">
					<a href="nuevo_vehiculo">Nuevo Vehiculo</a>
				</c:if>
				<c:if test="${sessionScope.usuario.publicista == true }">
					<a href="nueva_publicidad">Nueva publicidad</a>
				</c:if>
				<c:if test="${sessionScope.usuario.administrador == true }">
					<a href="../administracion/">Labores de administracion</a>
				</c:if>
				<a href="logout">Salir</a>
			</fieldset>
		</c:otherwise>
	</c:choose>
	
	<!-- Enlaces a las secciones del portal -->
	<br>
	<fieldset>
		<legend>Secciones:</legend>
		<a href="./motos">Motos</a>
		<a href="./coches">Coches</a>
	</fieldset>
	
</body>
</html>