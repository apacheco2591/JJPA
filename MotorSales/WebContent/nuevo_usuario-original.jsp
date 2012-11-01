<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nuevo Usuario</title>
</head>
<body>

	<center><h1>Coches.jsp</h1></center>
	
	<!-- Inserción de la publicidad -->
	<p>
	<c:if test="${requestScope.publicidad.banner != null }">
		<img height="50px" width="150px" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
	</c:if>
	<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
	</p>
	
	<!-- Visualización de los mensajes de error -->
	<c:if test="${errores != null }">
		<c:forEach items="${errores }" var="error">
			<p style="color: red"><c:out value="${error }"></c:out></p>
		</c:forEach>
	</c:if>
	
	<!-- Se comprueba si el usuario está logueado en el sistema -->
	<c:choose>
		<c:when test="${!empty sessionScope.usuario}">
			<form action="nuevo_usuario" method="post" name="formulario" id="formulario">
			<fieldset>
				<legend>Formulario para modificar datos</legend>
				<label for="nombreUsuario">Nombre usuario:</label>
				<input type="text" name="nombreUsuario" id="nombreUsuario" value='<c:out value="${sessionScope.usuario.nombreUsuario }"></c:out>'><br>
				<label for="contraseña">Contrase&ntilde;a:</label>
				<input type="password" name="contrasenya" id ="contraseña" value='<c:out value="${sessionScope.usuario.contraseña }"></c:out>'><br>
				<label for="nombre">Nombre:</label>
				<input type="text" name="nombre" id="nombre" value='<c:out value="${sessionScope.usuario.nombre }"></c:out>'/><br />
				<label for="apellidos">Apellidos:</label>
				<input type="text" name="apellidos" id="apellidos" value='<c:out value="${sessionScope.usuario.apellidos }"></c:out>'/><br />
				<label for="direccion">Direccion:</label>
				<input type="text" name="direccion" id="direccion" value='<c:out value="${sessionScope.usuario.direccion }"></c:out>'/><br />
				<label for="poblacion">Poblaci&oacute;n:</label>
				<input type="text" name="poblacion" id="poblacion" value='<c:out value="${sessionScope.usuario.poblacion }"></c:out>'><br /> 
				<label for="provincia">Provincia:</label>
				<select name="provincia" id="provincia">
					<c:forEach items="${requestScope.listaProvincias }" var="provincia">
						<option value='<c:out value="${provincia }"> </c:out>' <c:if test="${provincia == sessionScope.usuario.provincia }"><c:out value='selected="selected"'></c:out></c:if>><c:out value="${provincia }"></c:out></option>
					</c:forEach>
				</select><br />
				<label for="CP">C&oacute;digo postal:</label>
				<input type="text" name="CP" id="CP" value="${sessionScope.usuario.CP }"><br />
				<label for="telefono">Tel&eacute;fono:</label>
				<input type="text" name="telefono" id="telefono" value='<c:out value="${sessionScope.usuario.telefono }"></c:out>' /><br />
				<label for="email">Email:</label>
				<input type="text" name="email" id="email" value='<c:out value="${sessionScope.usuario.email }"></c:out>' /><br />
				<label for="permisos"><b>Permisos: </b></label><br />
				<input type="checkbox" name="comprador" id="permisos" <c:if test="${sessionScope.usuario.comprador }"><c:out value='checked="checked"'></c:out></c:if> />
					Comprador <i>(permite realizar compras de coches y motos)</i><br />
				<input type="checkbox" name="vendedor" value="true" <c:if test="${sessionScope.usuario.vendedor }"><c:out value='checked="checked"'></c:out></c:if> />
					Vendedor <i>(permite poner nuevos anuncios de motos y/o coches)</i><br>
				<input type="checkbox" name="publicista" value="true" <c:if test="${sessionScope.usuario.publicista }"><c:out value='checked="checked"'></c:out></c:if> />
					Publicista <i>(permite a&ntilde;adir la publicidad de su empresa/negocio)</i><br /><br />
				<input type="submit" value="Enviar">
				<a href="default.jsp">Cancelar</a>
			</fieldset>
			</form>
		</c:when>
		
		
		<c:otherwise>
			<form action="nuevo_usuario" method="post" name="formulario" id="formulario">
			<fieldset>
				<legend>Formulario de nuevo usuario</legend>
				<label for="nombreUsuario">Nombre usuario:</label>
				<input type="text" name="nombreUsuario" id="nombreUsuario"><br>
				<label for="contraseña">Contrase&ntilde;a:</label>
				<input type="password" name="contrasenya" id ="contraseña"><br>
				<label for="nombre">Nombre:</label>
				<input type="text" name="nombre" id="nombre" /><br />
				<label for="apellidos">Apellidos:</label>
				<input type="text" name="apellidos" id="apellidos" /><br />
				<label for="direccion">Direccion:</label>
				<input type="text" name="direccion" id="direccion" /><br />
				<label for="poblacion">Poblaci&oacute;n:</label>
				<input type="text" name="poblacion" id="poblacion" ><br /> 
				<label for="provincia">Provincia:</label>
				<select name="provincia" id="provincia">
					<c:forEach items="${requestScope.listaProvincias }" var="provincia">
						<option value='<c:out value="${provincia }"></c:out>'><c:out value="${provincia }"></c:out></option>
					</c:forEach>
				</select><br />
				<label for="CP">C&oacute;digo postal:</label>
				<input type="text" name="CP" id="CP"><br />
				<label for="telefono">Tel&eacute;fono:</label>
				<input type="text" name="telefono" id="telefono"><br />
				<label for="email">Email:</label>
				<input type="text" name="email" id="email" /><br />
				<label for="permisos"><b>Permisos: </b></label><br />
				<input type="checkbox" name="comprador" id="permisos" value="true"><i>(permite realizar el proceso de compra de coches y motos)</i>
				<input type="checkbox" name="vendedor" value="true">Vendedor <i>(permite poner nuevos anuncios de motos y/o coches)</i><br>
				<input type="checkbox" name="publicista" value="true">Publicista <i>(permite a&ntilde;adir la publicidad de su empresa/negocio)</i><br /><br />
				<input type="submit" value="Enviar">
				<a href="default.jsp">Cancelar</a>
			</fieldset>
			</form>
		</c:otherwise>
	</c:choose>
	<br>
</body>
</html>