<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Motos</title>
</head>
<body>

	<center><h1>Motos.jsp</h1></center>
	
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
				<input type="hidden" name="origen" value="motos" />
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
				<a href="logout?origen=motos">Salir</a>
			</fieldset>
		</c:otherwise>
	</c:choose>
	
	<!-- Tabla con los anuncios de motos -->
	<br>
		<c:if test="${requestScope.listaVehiculos == null } ">
			<c:out value="Lista vacia!"></c:out>
		</c:if>
	<fieldset>
	<legend>Anuncios de motos</legend>
		<table >
		<caption>Lista Motos</caption>
			<thead>
				<tr>
					<th>Imagen</th>
					<th>Marca</th>
					<th>Modelo</th>
					<th>Precio</th>
					<th>A&ntilde;os matricula</th>
					<th>Kilometros</th>
					<th>Color</th>
					<th>Matricula</th>
					<th>Descripcion</th>
				</tr>
			</thead>
			<c:forEach items="${requestScope.listaVehiculos }" var="vehiculo">
			<tr>
				<td>
					<c:if test="${vehiculo.foto != null }">
						<a href="./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>">
							<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" />
						</a>
					</c:if>
				</td>
				<td><c:out value="${vehiculo.marca }"></c:out></td>
				<td><c:out value="${vehiculo.modelo }"></c:out></td>
				<td><c:out value="${vehiculo.precio }"></c:out></td>
				<td><c:out value="${vehiculo.añosMatricula }"></c:out></td>
				<td><c:out value="${vehiculo.km }"></c:out></td>
				<td><c:out value="${vehiculo.color }"></c:out></td>
				<td><c:out value="${vehiculo.matricula }"></c:out></td>
				<td>
					<c:choose>
						<c:when test="${(fn:length(vehiculo.descripcion)) == 0 }">
							<c:set var="descripcion" value="(sin descripcion)"></c:set>
						</c:when>
						<c:when test="${(fn:length(vehiculo.descripcion)) > 27 }">
							<c:set var="descripcion" value="${fn:substring(vehiculo.descripcion, 0, 24) }..."></c:set>
						</c:when>
						<c:otherwise>
							<c:set var="descripcion" value="${vehiculo.descripcion }"></c:set>
						</c:otherwise>
					</c:choose>
					<c:out value="${descripcion }"></c:out>
				</td>
			</tr>
			</c:forEach>
		</table>
	</fieldset>
<br>

<!-- Otros enlaces -->
<a href="coches">Coches</a>
<a href="default.jsp">Inicio</a>
	
</body>
</html>