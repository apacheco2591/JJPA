<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" media="screen" href="./style/administrar_publicidad.css">
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrar Publicidad</title>
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
				
				<div id='tabla'>
					
					<!-- Visualización de los mensajes de error -->
					<c:if test="${errores != null }">
						<div id='fila'>
							<div id='boton'>			
								<c:forEach items="${erroresValidacion }" var="error">
									<p style="color: red"><c:out value="${error }"></c:out></p>
								</c:forEach>
							</div>	
						</div>
					</c:if>

					<!-- PUBLICIDAD SIN VALIDAR *****************************************************************-->
					<div id='publi'>
						<div id='vacio'></div>
						<div id='fila'>
							<div id='boton'>			
								Lista de Publicidad sin validar (pendiente)
							</div>	
						</div>
						
						<div id='barraP'>
								
							<div id='barraFoto'>Imagen</div>
							<div id='barraPublicista'>Publcista</div>	
							<div id='barraTarifa'>Tarifa</div>
							<div id='barraFecha'>Fecha Insercion</div>

						</div>

						<c:set var="num" value="${1}" />
						<c:forEach items="${requestScope.listaPublicidadSinValidar }" var="publicidad">

							<c:if test="${num%2==0}">
								<div id='publicidad0'>
									
									<c:if test="${publicidad.banner != null }">
										<div id='foto'>
											<img width="150px" height="50px" alt="publi" src="<c:out value="${publicidad.banner }"></c:out>" />
										</div>
									</c:if>
									<c:if test="${publicidad.banner == null }">
										<div id='foto'>
											SIN FOTO
										</div>
									</c:if>

									<div id='barraPublicista'><c:out value="${publicidad.publicista.nombreUsuario }"></c:out></div>
									<div id='barraTarifa'><c:out value="${publicidad.tarifa.precio }"></c:out></div>
									<div id='barraFecha'><c:out value="${publicidad.fechaInsercionFormateada }"></c:out></div>

									<div id='validar'><a href="validar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Validar</a></div>
									<div id='validar'><a href="descartar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Descartar</a></div>

								</div>
							</c:if>

							<c:if test="${num%2==1}">
								<div id='publicidad1'>
									
									<c:if test="${publicidad.banner != null }">
										<div id='foto'>
											<img width="150px" height="50px" alt="publi" src="<c:out value="${publicidad.banner }"></c:out>" />
										</div>
									</c:if>
									<c:if test="${publicidad.banner == null }">
										<div id='foto'>
											SIN FOTO
										</div>
									</c:if>

									<div id='publicista'><c:out value="${publicidad.publicista.nombreUsuario }"></c:out></div>
									<div id='tarifa'><c:out value="${publicidad.tarifa.precio }"></c:out></div>
									<div id='fechaI'><c:out value="${publicidad.fechaInsercionFormateada }"></c:out></div>

									<div id='validar'><a href="validar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Validar</a></div>
									<div id='validar'><a href="descartar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Descartar</a></div>

								</div>
							</c:if>
							<c:set var="num" value="${num+1}" />
						</c:forEach>

						<c:if test="${empty requestScope.listaPublicidadSinValidar }">
							<p>No hay publiciad en esta categor&iacute;a</p>
						</c:if>

					</div>

					<!-- PUBLICIDAD SIN VALIDAR *****************************************************************-->
					<div id='publi'>
						<div id='vacio'></div>
						<div id='fila'>
							<div id='boton'>			
								Lista de Publicidad validada (OK)
							</div>	
						</div>

						<!-- Visualización de los mensajes de error -->
						<c:if test="${erroresBorrado != null }">
							<div id='fila'>
								<div id='boton'>			
									<c:forEach items="${erroresBorrado }" var="error">
										<p style="color: red"><c:out value="${error }"></c:out></p>
									</c:forEach>
								</div>	
							</div>
						</c:if>

						<div id='barraP'>
								
							<div id='barraFoto'>Imagen</div>
							<div id='barraPublicista'>Publcista</div>	
							<div id='barraTarifa'>Tarifa</div>
							<div id='barraFecha'>Fecha Insercion</div>

						</div>

						<c:set var="num" value="${1}" />
						<c:forEach items="${requestScope.listaPublicidad }" var="publicidad">
							<c:if test="${num%2==0}">
								<div id='publicidad0'>
									
									<c:if test="${publicidad.banner != null }">
										<div id='foto'>
											<img width="150px" height="50px" alt="publi" src="<c:out value="${publicidad.banner }"></c:out>" />
										</div>
									</c:if>
									<c:if test="${publicidad.banner == null }">
										<div id='foto'>
											SIN FOTO
										</div>
									</c:if>

									<div id='publicista'><c:out value="${publicidad.publicista.nombreUsuario }"></c:out></div>
									<div id='tarifa'><c:out value="${publicidad.tarifa.precio }"></c:out></div>
									<div id='fechaI'><c:out value="${publicidad.fechaInsercionFormateada }"></c:out></div>


									<div id='validar'><a href="borrar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Borrar</a></div>

								</div>
							</c:if>
							
							<c:if test="${num%2==1}">

								<div id='publicidad1'>
									
									<c:if test="${publicidad.banner != null }">
										<div id='foto'>
											<img width="150px" height="50px" alt="publi" src="<c:out value="${publicidad.banner }"></c:out>" />
										</div>
									</c:if>
									<c:if test="${publicidad.banner == null }">
										<div id='foto'>
											SIN FOTO
										</div>
									</c:if>

									<div id='publicista'><c:out value="${publicidad.publicista.nombreUsuario }"></c:out></div>
									<div id='tarifa'><c:out value="${publicidad.tarifa.precio }"></c:out></div>
									<div id='fechaI'><c:out value="${publicidad.fechaInsercionFormateada }"></c:out></div>


									<div id='validar'><a href="borrar_publicidad?id=<c:out value="${publicidad.id }"></c:out>">Borrar</a></div>

								</div>

							</c:if>
							<c:set var="num" value="${num+1}" />
						</c:forEach>

						<c:if test="${empty requestScope.listaPublicidad }">
							<p>No hay publiciad en esta categor&iacute;a</p>
						</c:if>

						<a href="nueva_publicidad">Nueva publicidad</a>
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