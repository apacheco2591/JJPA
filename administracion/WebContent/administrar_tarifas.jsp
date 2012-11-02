<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" media="screen" href="./style/administrar_tarifas.css">
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrar Tarifas</title>
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

					<!-- PUBLICIDAD SIN VALIDAR *****************************************************************-->
					<div id='publi'>

						<div id='fila'>
							<div id='boton'>			
								Lista de Tarifas en el Sistema
							</div>	
						</div>

						<div id='barraP'>
								
							<div id='barraTiempo'>Tiempo</div>
							<div id='barraPrecio'>Precio</div>	

						</div>

						<c:set var="num" value="${1}" />

						<c:forEach items="${requestScope.listaTarifas }" var="tarifa">
							
							<c:if test="${num%2==0}">
								<div id='publicidad0'>
									<div id='tiempo'><c:out value="${tarifa.minMeses }"></c:out> mes/es</div>
									<div id='precio'><c:out value="${tarifa.precio }"></c:out></div>
									<div id='validar'><a href="modificar_tarifa?id=<c:out value="${tarifa.id }"></c:out>">Modificar</a></div>
									<div id='validar'><a href="borrar_tarifa?id=<c:out value="${tarifa.id }"></c:out>">Dar de baja</a></div>
								</div>
							</c:if>

							<c:if test="${num%2==1}">
								<div id='publicidad1'>
									<div id='tiempo'><c:out value="${tarifa.minMeses }"></c:out> mes/es</div>
									<div id='precio'><c:out value="${tarifa.precio }"></c:out></div>
									<div id='validar'><a href="modificar_tarifa?id=<c:out value="${tarifa.id }"></c:out>">Modificar</a></div>
									<div id='validar'><a href="borrar_tarifa?id=<c:out value="${tarifa.id }"></c:out>">Dar de baja</a></div>
								</div>
							</c:if>		

							<c:set var="num" value="${num+1}" />

						</c:forEach>
		
						<a href="nueva_tarifa">Nueva tarifa</a>
		
					</div>
				</div>	
			</div>
		</div>	
	<div id='footer'>
		TIW
	</div>	
</div>
	
</body>
</html>