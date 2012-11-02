<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/modificar_usuario.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Modificar Usuario</title>
</head>
<body>

	<div id='pagina'>

		<c:if test="${empty sessionScope.usuario || !sessionScope.usuario.administrador }">
			<c:redirect url="/"></c:redirect>
		</c:if>
		
		<div id='header'>

		</div>

		<div id='content'>

			<div id='cssmenu'>
				<ul>
					<li><a href='#'><span>Usuario <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out></span></a></li>
				   	<li class='active '><a href="administrar_usuarios"><span>Usuarios</span></a></li>
				   	<li class='active has-sub '><a href='#'><span>Publicidad</span></a>
					    <ul>
						    <li class='active '><a href='administrar_anuncios?tipo=coche'><span>Coches</span></a></li>
						    <li><a href='administrar_anuncios?tipo=moto'><span>Motos</span></a></li>
						</ul>
					</li>
					<li class='active '><a href="administrar_anuncios"><span>Anuncios</span></a></li>
					<li class='active '><a href="administrar_tarifas"><span>Tarifas</span></a></li>
					<li class='active '><a href="logout"><span>Salir</span></a></li>
				</ul>
			</div>
				
			<div id='principal'>
				<div id='vacio'></div>
				<div id='formulario'>
					
					<!-- Visualización de los mensajes de error -->
					<c:if test="${errores != null }">
						<div id='fila'>
							<div id='boton'>			
								<c:forEach items="${errores }" var="error">
									<p style="color: red"><c:out value="${error }"></c:out></p>
								</c:forEach>
							</div>	
						</div>
					</c:if>


					<div id='fila'>
						<div id='boton'>
							<b>Modificar Usuario</b>
						</div>	
					</div>	
	
					<form action="modificar_usuario" method="post" name="formulario" id="formulario">

						<div id='fila'>
							<div id='colI'>
								<label for="nombreUsuario">Nombre usuario:</label>
							</div>
							<div id='colD'>
								<input type="text" name="nombreUsuario" id="nombreUsuario" value="${requestScope.usuario.nombreUsuario }">		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="contraseña">Contrase&ntilde;a:</label>
							</div>
							<div id='colD'>
								<input type="password" name="contrasenya" id ="contraseña" value="${requestScope.usuario.contraseña }">		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="nombre">Nombre:</label>
							</div>
							<div id='colD'>
								<input type="text" name="nombre" id="nombre" value="${requestScope.usuario.nombre }" />		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="apellidos">Apellidos:</label>
							</div>
							<div id='colD'>
								<input type="text" name="apellidos" id="apellidos" value="${requestScope.usuario.apellidos }" />		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="direccion">Direccion:</label>
							</div>
							<div id='colD'>
								<input type="text" name="direccion" id="direccion" value="${requestScope.usuario.direccion }" />		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="poblacion">Poblaci&oacute;n:</label>
							</div>
							<div id='colD'>
								<input type="text" name="poblacion" id="poblacion" value='<c:out value="${requestScope.usuario.poblacion }"></c:out>'>		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="provincia">Provincia:</label>
							</div>
							<div id='colD'>
								<select name="provincia" id="provincia">
									<c:forEach items="${requestScope.listaProvincias }" var="provincia">
										<option value='<c:out value="${provincia }"> </c:out>' <c:if test="${provincia == requestScope.usuario.provincia }"><c:out value='selected="selected"'></c:out></c:if>><c:out value="${provincia }"></c:out></option>
									</c:forEach>
								</select>		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="CP">C&oacute;digo postal:</label>
							</div>
							<div id='colD'>
								<input type="text" name="CP" id="CP" value="${requestScope.usuario.CP }">	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="telefono">Tel&eacute;fono:</label>
							</div>
							<div id='colD'>
								<input type="text" name="telefono" id="telefono" value="${requestScope.usuario.telefono }" />		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="email">Email:</label>
							</div>
							<div id='colD'>
								<input type="text" name="email" id="email" value="${requestScope.usuario.email }" />		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="email">Email:</label>
							</div>
							<div id='colD'>
								<input type="text" name="email" id="email" value="${requestScope.usuario.email }" />		
							</div>	
						</div>

						<div id='filaC'>
							<div id='colI'>
								<label for="permisos">Permisos:</label>
							</div>
							<div id='colDC'>
								<input type="checkbox" name="comprador" id="permisos" value="true" <c:if test="${requestScope.usuario.comprador }"><c:out value='checked="checked"'></c:out></c:if>>Comprador <i>(permite comprar motos y/o coches)</i>		
							</div>	
						</div>

						<div id='filaC'>
							<div id='colI'>
								<label for="permisos"></label>
							</div>
							<div id='colDC'>
								<input type="checkbox" name="vendedor" id="permisos" value="true" <c:if test="${requestScope.usuario.vendedor }"><c:out value='checked="checked"'></c:out></c:if>>Vendedor <i>(permite poner nuevos anuncios de motos y/o coches)</i>		
							</div>	
						</div>
						<div id='filaC'>
							<div id='colI'>
								
							</div>
							<div id='colDC'>
								<input type="checkbox" name="publicista" value="true" <c:if test="${requestScope.usuario.publicista }"><c:out value='checked="checked"'></c:out></c:if>>Publicista <i>(permite a&ntilde;adir la publicidad de su empresa/negocio)</i>	
							</div>	
						</div>
						<div id='filaC'>
							<div id='colI'>
								
							</div>
							<div id='colDC'>
								<input type="checkbox" name="administrador" value="true" <c:if test="${requestScope.usuario.administrador }"><c:out value='checked="checked"'></c:out></c:if>>Administrador<i>(permisos para labores de administracion)</i>		
							</div>	
						</div>


						<div id='fila'>
							<div id='boton'>
								<input type="hidden" name="nombreUsuarioViejo" value="${requestScope.usuario.nombreUsuario }" />
								<input type="submit" value="Enviar">
								<a href="administrar_usuarios">Cancelar</a>
							</div>	
						</div> 
					</form>
			
				</div>
			</div>
		</div>	
		<div id='footer'>

		</div>
	</div>

</body>
</html>