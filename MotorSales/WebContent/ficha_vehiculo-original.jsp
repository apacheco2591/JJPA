<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ficha del vehiculo</title>
</head>
<body>

	<c:if test="${requestScope.tipo != null && requestScope.matricula != null }">
		<c:redirect url='ficha_vehiculo.jsp?tipo=${requestScope.tipo }&matricula=${requestScope.matricula }'></c:redirect>
	</c:if>
	
	<center><h2>Ficha del veh&iacute;culo</h2></center>
	
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
			
			<%-- <c:set var="url" value='ficha_vehiculo.jsp?tipo=${requestScope.vehiculo.tipo }&matricula=${vehiculo.matricula }'></c:set> --%>
			
			<form action="login" method="post">
				<label for="nom">Usuario:</label> <input type="text" name="nombre" id="nom"><br> 
				<label for="clave">Contrase&ntilde;a:</label> 
				<input type="password" name="clave" id="clave"><br />
				<input type="submit" value="Iniciar sesi&oacute;n">
				<input type="hidden" name="origen" value="ficha_vehiculo.jsp">
				<input type="hidden" name="tipo" value="${requestScope.vehiculo.tipo }">
				<input type="hidden" name="matricula" value="${requestScope.vehiculo.matricula }">
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
	
	<!-- Comprobación de que se ha recibido los datos del vehículo -->
	<c:if test="${!empty requestScope.vehiculo }">
	
	<!-- Vista de los datos del vehículo -->
	<fieldset>
	<legend>Datos del veh&iacute;culo</legend>
		<p>
			<b>Marca:&nbsp;</b><c:out value="${vehiculo.marca }"></c:out>
		</p>
		<p>
			<b>Modelo:&nbsp;</b><c:out value="${vehiculo.modelo }"></c:out>
		</p>
		<p>
			<b>Precio:&nbsp;</b><c:out value="${vehiculo.precio }"></c:out>
		</p>
		<p>
			<b>A&ntilde;os matr&iacute;cula:&nbsp;</b><c:out value="${vehiculo.añosMatricula }"></c:out>
		</p>
		<p>
			<b>K&iacute;lometros:&nbsp;</b><c:out value="${vehiculo.km }"></c:out>
		</p>
		<p>
			<b>Color:&nbsp;</b><c:out value="${vehiculo.color }"></c:out>
		</p>
		<p>
			<b>Matr&iacute;cula:&nbsp;</b><c:out value="${vehiculo.matricula }"></c:out>
		</p>
		<p>
			<b>Descripci&oacute;n:&nbsp;</b><c:out value="${vehiculo.descripcion }"></c:out>
		</p>
		<c:if test="${vehiculo.foto != null }">
			<img src="<c:out value="${vehiculo.foto }"></c:out>" />
		</c:if>
		
		
		<%-- <fieldset>
		<legend>Vendedor</legend>
		<c:choose>
		<c:when test="${!empty sessionScope.usuario }">
			
			<c:choose>
			<c:when test="${sessionScope.usuario.nombreUsuario != vehiculo.usuario.nombreUsuario }">
				<table>
				<caption>Datos del vendedor</caption>
				<tr>
					<td><b>Nombre:</b></td>
					<td><c:out value="${requestScope.vendedor.nombre }"></c:out></td>
				</tr>
				<tr>
					<td><b>Apellidos:</b></td>
					<td><c:out value="${requestScope.vendedor.apellidos }"></c:out></td>
				</tr>
				<tr>
					<td><b>Direcci&oacute;n</b></td>
					<td><c:out value="${requestScope.vendedor.direccion }"></c:out></td>
				</tr>
				<tr>
					<td><b>Tel&eacute;fono:</b></td>
					<td><c:out value="${requestScope.vendedor.telefono }"></c:out></td>
				</tr>
				<tr>
					<td><b>Email:</b></td>
					<td><c:out value="${requestScope.vendedor.email }"></c:out></td>
				</tr>
				</table>
				
			</c:when>
			
			<c:otherwise>
				<p>Ud. es el vendedor de este veh&iacute;culo<br />
					<a href="opciones_personales">Ir a opciones personales</a>
				</p>
				<fieldset>
				<legend>Detalles de la contrataci&oacute;n del anuncio</legend>
					<table>
						<tr>
							<th>Precio</th>
							<th>Fecha inicio</th>
							<th>Fecha fin</th>
						</tr>
						<tr>
							<td><c:out value="${vehiculo.tarifa.precio }"></c:out> &euro;/mes</td>
							<td><c:out value="${vehiculo.fechaInsercionFormateada }"></c:out></td>
							<td><c:out value="${vehiculo.fechaFinFormateada }"></c:out></td>
							
						</tr>
					</table>
				</fieldset>
			</c:otherwise>
			
			</c:choose>
		
		</c:when>

		<c:otherwise>
			<p>
				Para ver los datos del vendedor, reg&iacute;strese como usuario
				<a href="nuevo_usuario">aqu&iacute;</a>
			</p>
		</c:otherwise>
		</c:choose> 
		</fieldset>
	</fieldset> --%>
	<br /><br />
	<a href="<c:out value="${vehiculo.tipo }"></c:out>s"><c:out value="${vehiculo.tipo }"></c:out>s</a>
	</c:if>
	
	<!-- Enlace a la página de inicio -->
	<a href="default.jsp">Inicio</a>
	
</body>
</html>