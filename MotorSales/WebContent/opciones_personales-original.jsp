<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Opciones personales</title>
</head>
<body>

	<!-- Se comprueba que el usuario esté logueado -->
	<c:if test="${empty sessionScope.usuario }">
		<c:redirect url="default.jsp"></c:redirect>
	</c:if>
	
	<center><h2>opciones_personales.jsp</h2></center>
	
	<!-- Inserción de la publicidad -->
	<p>
	<c:if test="${requestScope.publicidad.banner != null }">
		<img height="50px" width="150px" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
	</c:if>
	<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
	</p>
	

	
	<!-- Nombre de usuario y opciones propias -->
	<fieldset>
		<legend>Bienvenido</legend>
		<p>
			Usuario: <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out>
		</p>
		<a href="opciones_personales">Opciones personales</a>
		<c:if test="${sessionScope.usuario.vendedor == true }">
			<a href="nuevo_vehiculo.jsp">Nuevo Vehiculo</a>
		</c:if>
		<c:if test="${sessionScope.usuario.publicista == true }">
			<a href="nueva_publicidad">Nueva publicidad</a>
		</c:if>
		<c:if test="${sessionScope.usuario.administrador == true }">
			<a href="../administracion/">Labores de administracion</a>
		</c:if>
		<a href="logout">Salir</a>
	</fieldset>
	<br />
	<fieldset>
	<legend>Datos personales:</legend>
		<table>
			<tr>
				<td><b>Nombre:</b></td>
				<td><c:out value="${sessionScope.usuario.nombre }"></c:out></td>
			</tr>
			<tr>
				<td><b>Apellidos:</b></td>
				<td><c:out value="${sessionScope.usuario.apellidos }"></c:out></td>
			</tr>
			<tr>
				<td><b>Direcci&oacute;n:</b></td>
				<td><c:out value="${sessionScope.usuario.direccion }"></c:out></td>
			</tr>
			<tr>
				<td><b>Poblaci&oacute;n:</b></td>
				<td><c:out value="${sessionScope.usuario.poblacion }"></c:out></td>
			</tr>
			<tr>
				<td><b>Provincia:</b></td>
				<td><c:out value="${sessionScope.usuario.provincia }"></c:out></td>
			</tr>
			<tr>
				<td><b>C&oacute;digo postal:</b></td>
				<td><c:out value="${sessionScope.usuario.CP }"></c:out></td>
			</tr>
			<tr>
				<td><b>Tel&eacute;fono:</b></td>
				<td><c:out value="${sessionScope.usuario.telefono }"></c:out></td>
			</tr>
			<tr>
				<td><b>Email:</b></td>
				<td><c:out value="${sessionScope.usuario.email }"></c:out></td>
			</tr>
			<c:if test="${sessionScope.usuario.comprador }">
				<tr>
					<td><b>Comprador:</b></td>
					<td>S&iacute;</td>
				</tr>
			</c:if>
			<c:if test="${sessionScope.usuario.vendedor }">
				<tr>
					<td><b>Vendedor:</b></td>
					<td>S&iacute;</td>
				</tr>
			</c:if>
			<c:if test="${sessionScope.usuario.publicista }">
				<tr>
					<td><b>Publicista:</b></td>
					<td>S&iacute;</td>
				</tr>
			</c:if>
		</table>
		
		<a href="nuevo_usuario">Modificar datos personales</a> 
	
	</fieldset>
	
	<!-- Si el usuario tiene permisos de vendedor, se muestran sus anuncios de vehículos -->
	<c:if test="${sessionScope.usuario.vendedor && (!empty requestScope.listaVehiculosUsuario)}">
		<br />
		<fieldset>
		<legend>Anuncios de veh&iacute;culos</legend>
		
		<c:if test="${!empty requestScope.erroresVehiculos }">
			<c:forEach items="${requestScope.erroresVehiculos }" var="error">
				<p style="color: red"><c:out value="${error }"></c:out></p>
			</c:forEach>
		</c:if>
		
		<table >
		<caption>Lista vehiculos anunciados</caption>
		<thead>
			<tr>
				<th>Imagen</th>
				<th>Tipo</th>
				<th>Marca</th>
				<th>Modelo</th>
				<th>Precio</th>
				<th>A&ntilde;os matricula</th>
				<th>Kilometros</th>
				<th>Color</th>
				<th>Matricula</th>
				<th>Descripcion</th>
				<th>Detalles</th>
			</tr>
		</thead>
		
		<c:forEach items="${requestScope.listaVehiculosUsuario }" var="vehiculo">
		<tr>
			<td>
				<c:if test="${vehiculo.foto != null }">
					<a href='./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&origen="opciones_personales"'>
						<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" />
					</a>
				</c:if>
			</td>
			<td><c:out value="${vehiculo.tipo }"></c:out></td>
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
			<td><a href='./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&origen="opciones_personales"'>Ver detalles</a></td>
			<td><a href='modificar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Modificar anuncio</a>
			<td><a href='borrar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Borrar</a>
			
		</tr>
		</c:forEach>
		</table>
		</fieldset>
	</c:if>
	

	<!-- Si el usuario tiene permisos de publicista, se muestra toda su publicidad -->
	<c:if test="${sessionScope.usuario.publicista && (!empty requestScope.listaPublicidadUsuario)}">
		<br />
		<fieldset>
		<legend>Anuncios de publicidad</legend>
		
		<c:if test="${!empty requestScope.erroresPublicidad }">
			<c:forEach items="${requestScope.erroresPublicidad }" var="error">
				<p style="color: red"><c:out value="${error }"></c:out></p>
			</c:forEach>
		</c:if>
		
		<table>
		<caption>Lista de publicidad</caption>
		<thead>
			<tr>
				<th>Banner</th>
				<th>Texto</th>
				<th>Fecha inicio</th>
				<th>Fecha fin</th>
				<th>Mensualidad</th>
			</tr>
		</thead>
		<c:forEach items="${requestScope.listaPublicidadUsuario }" var="publicidad">
			<tr>
				<td>
					<c:if test="${publicidad.banner != null }">
						<img src="<c:out value="${publicidad.banner }"></c:out>" width="50px" height="50px" />
					</c:if>
				</td>
				<td><c:out value="${publicidad.textoAnuncio }"></c:out></td>
				<td><c:out value="${publicidad.fechaInsercionFormateada }"></c:out></td>
				<td><c:out value="${publicidad.fechaFinFormateada }"></c:out></td>
				<td><c:out value="${publicidad.tarifa.precio }"></c:out>&euro;/mes</td>
				<td><a href='modificar_publicidad?id=<c:out value="${publicidad.id }"></c:out>'>Modificar anuncio</a>
				<td><a href='borrar_publicidad?id=<c:out value="${publicidad.id }"></c:out>'>Borrar</a>
			</tr>
		</c:forEach>
		</table>
		</fieldset>
	</c:if>
	
	<br />
	
	<!-- Otros enlaces -->
	<a href="motos">Motos</a>
	<a href="coches">Coches</a>
	<a href="default.jsp">Inicio</a>
</body>
</html>