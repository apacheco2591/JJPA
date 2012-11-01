<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/default.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
	<div id='pagina'>
		<div id='header'>
			
		</div>
		
		<div id='content'>
			<c:choose>
				<c:when test="${!empty sessionScope.usuario || sessionScope.usuario.administrador ==true}">
				
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

					</div>	
				
				</c:when>
				<c:otherwise>
					<div id='cssmenu'>
						<ul>
						   <li><a href='#'><span>Usuario: <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out></span></a></li>
						   <li class='active '><a href="administrar_usuarios"><span>Usuarios</span></a></li>
						   <li class='active '><a href="administrar_publicidad"><span>Publicidad</span></a></li>
						   <li class='active '><a href="administrar_anuncios"><span>Anuncios</span></a></li>
						   <li class='active '><a href="administrar_tarifas"><span>Tarifas</span></a></li>
						   <li class='active '><a href="logout"><span>Salir</span></a></li>
						</ul>
					</div>
						
					<div id='principal'>
						<div id='vacio'></div>
						
						<c:if test="${errores != null }">
							<div id='error'>
								<c:forEach items="${errores }" var="error">
									<p style="color: red"><c:out value="${error }"></c:out></p>
								</c:forEach>
							</div>
						</c:if>
							
						<div id='login'>
							<form action="login" method="post">
								
								<div id='fila'>
									<div id='boton'>
										Todos los campos son obligatorios
									</div>	
								</div> 

								<!-- FILA USUARIO -->
								<div id='fila'>
									<div id='colI'>
										<label for="nom">Usuario:</label>
									</div>
									<div id='colD'>
										<input type="text" name="nombre" id="nom"><br>			
									</div>	
								</div>

								<!-- FILA PASS -->
								<div id='fila'>
									<div id='colI'>
										<label for="clave">Contrase&ntilde;a:</label>
									</div>
									<div id='colD'>
										<input type="password" name="clave" id="clave"><br>			
									</div>	
								</div>

								<!-- FILA BOTON-->
								<div id='fila'>
									<div id='boton'>
										<input type="submit" value="Iniciar sesi&oacute;n">
									</div>	
								</div> 

							</form>
						</div>
					</div>
				</c:otherwise>					
			</c:choose>
		</div>

		<div id='footer'>

		</div>
	</div>
</body>