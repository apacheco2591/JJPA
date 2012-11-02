<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" media="screen" href="./style/administrar_usuarios.css">
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrar Usuarios</title>
</head>
<body>

	<div id='pagina'>

		<c:if test="${empty sessionScope.usuario || !sessionScope.usuario.administrador }">
			<c:redirect url="./"></c:redirect>
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
				<div id='tabla'>
					
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

					<div id='barraP'>
		
						<div id='barraUsuario'>Usuario</div>
						<div id='barraNombre'>Nombre</div>	
						<div id='barraApellidos'>Apellidos</div>
						<div id='barraProvincia'>Provincia</div>
						<div id='barraCP'>CP</div>
						<div id='barraEmail'>Email</div>
						<div id='barraTelefono'>Telefono</div>
						<div id='barraPermisos'>Permisos</div>
						
					</div>

					<c:set var="num" value="${1}" />
					<c:forEach items="${requestScope.listaUsuarios }" var="usuario">

						<c:if test="${num%2==0}">
							<div id='publicidad0'>

								<div id='barraUsuario'><c:out value="${usuario.nombreUsuario }"></c:out></div>
								<div id='barraNombre'><c:out value="${usuario.nombre}"></c:out></div>
								<div id='barraApellidos'><c:out value="${usuario.apellidos }"></c:out></div>
								<div id='barraProvincia'><c:out value="${usuario.provincia }"></c:out></div>
								<div id='barraCP'><c:out value="${usuario.CP }"></c:out></div>
								<div id='barraEmail'><c:out value="${usuario.email }"></c:out></div>
								<div id='barraTelefono'><c:out value="${usuario.telefono }"></c:out></div>
								<div id='barraPermisos'>
									<div id='barraPer'>
										<c:if test="${usuario.comprador }">
											<c:out value="C"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.vendedor }">
											<c:out value="V"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.publicista }">
											<c:out value="P"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.administrador }">
											<c:out value="A"></c:out>
										</c:if>
									</div>
								</div>								

								<div id='validar'><a href="modificar_usuario?usuario=<c:out value="${usuario.nombreUsuario }"></c:out>">Modificar</a></div>

								<div id='validar'><a href="borrar_usuario?usuario=<c:out value="${usuario.nombreUsuario }"></c:out>">Dar de baja</a></div>

							</div>
						</c:if>

						<c:if test="${num%2==1}">
							<div id='publicidad1'>

								<div id='barraUsuario'><c:out value="${usuario.nombreUsuario }"></c:out></div>
								<div id='barraNombre'><c:out value="${usuario.nombre}"></c:out></div>
								<div id='barraApellidos'><c:out value="${usuario.apellidos }"></c:out></div>
								<div id='barraProvincia'><c:out value="${usuario.provincia }"></c:out></div>
								<div id='barraCP'><c:out value="${usuario.CP }"></c:out></div>
								<div id='barraEmail'><c:out value="${usuario.email }"></c:out></div>
								<div id='barraTelefono'><c:out value="${usuario.telefono }"></c:out></div>
								<div id='barraPermisos'>
									<div id='barraPer'>
										<c:if test="${usuario.comprador }">
											<c:out value="C"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.vendedor }">
											<c:out value="V"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.publicista }">
											<c:out value="P"></c:out>
										</c:if>
									</div>

									<div id='barraPer'>
										<c:if test="${usuario.administrador }">
											<c:out value="A"></c:out>
										</c:if>
									</div>
								</div>								

								<div id='validar'><a href="modificar_usuario?usuario=<c:out value="${usuario.nombreUsuario }"></c:out>">Modificar</a></div>

								<div id='validar'><a href="borrar_usuario?usuario=<c:out value="${usuario.nombreUsuario }"></c:out>">Dar de baja</a></div>

							</div>
							
						</c:if>
						<c:set var="num" value="${num+1}" />
					</c:forEach>

					<a href="nuevo_usuario">Nuevo usuario</a>
		
				</div>	
			</div>
		</div>	
	<div id='footer'>
		TIW
	</div>	
</div>	
</body>
</html>