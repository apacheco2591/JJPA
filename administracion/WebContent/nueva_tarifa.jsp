<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/nueva_tarifa.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nueva Tarifa</title>
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
								<b>Nueva Tarifa</b>
							</div>	
						</div>
					<form action="nueva_tarifa" method="post" name="formulario" id="formulario">
						
						<div id='fila'>
							<div id='colI'>
								<label for="minMeses">Tiempo m&iacute;nimo</label>
							</div>
							<div id='colD'>
								<select name="minMeses" id="minMeses">
									<c:forEach var="i" begin="1" end="12">
										<option value="${i }"><c:out value="${i } meses"></c:out></option>
									</c:forEach>
								</select>		
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="precio">Precio: <i>(&euro;/mes)</i></label>
							</div>
							<div id='colD'>
								<input type="text" name="precio" id ="precio" />		
							</div>	
						</div>
						
						<div id='fila'>
							<div id='boton'>
								<input type="submit" value="Enviar">
								<a href="administrar_tarifas">Cancelar</a>
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