<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/administrar_anuncios.css">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrar Anuncios</title>
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
				   <li><a href='#'><span>Usuario: <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out></span></a></li>
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
					<div id='vacio'></div>
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

					<!-- SIN VELIDAR **********************************************************************-->
					<div id='vehi'>
						
						<div id='fila'>
							<div id='boton'>			
								Lista de anuncios de <c:out value="${requestScope.tipo }"></c:out> sin validar
							</div>	
						</div>

						<div id='barraV'>
								
							<div id='barraFoto'>Imagen</div>
							<div id='barraMarca'>Marca</div>	
							<div id='barraModelo'>Modelo</div>
							<div id='barraPrecio'>Precio</div>
							<div id='barraKM'>KM</div>
							<div id='barraColor'>Color</div>

						</div>

						<c:set var="num" value="${1}" />
						<c:forEach items="${requestScope.listaVehiculosSinValidar }" var="vehiculo">

							<c:if test="${num%2==0}">
							
								<div id='coches0'>
									
									<c:if test="${vehiculo.foto != null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&validado="false"'>
											<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" /></a>
										</div>
									</c:if>
									<c:if test="${vehiculo.foto == null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&validado="false"'>SIN FOTO</a>
										</div>
									</c:if>

									<div id='marca'><c:out value="${vehiculo.marca }"></c:out></div>
									<div id='modelo'><c:out value="${vehiculo.modelo }"></c:out></div>
									<div id='precio'><c:out value="${vehiculo.precio }"></c:out></div>
									<div id='KM'><c:out value="${vehiculo.km }"></c:out></div>
									<div id='color'><c:out value="${vehiculo.color }"></c:out></div>
									<div id='validar'><a href='validar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Validar</a></div>
									<div id='validar'><a href='borrar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&validado="false"'>Borrar</a></div>

								</div>
							</c:if>	

							<c:if test="${num%2==1}">
							
								<div id='coches1'>
									
									<c:if test="${vehiculo.foto != null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&validado="false"'>
											<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" /></a>
										</div>
									</c:if>
									<c:if test="${vehiculo.foto == null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>&validado="false"'>SIN FOTO</a>
										</div>
									</c:if>

									<div id='marca'><c:out value="${vehiculo.marca }"></c:out></div>
									<div id='modelo'><c:out value="${vehiculo.modelo }"></c:out></div>
									<div id='precio'><c:out value="${vehiculo.precio }"></c:out></div>
									<div id='KM'><c:out value="${vehiculo.km }"></c:out></div>
									<div id='color'><c:out value="${vehiculo.color }"></c:out></div>
									<div id='validar'><a href='validar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Validar</a></div>
									<div id='validar'><a href='borrar_anuncio?tipo=vehiculo.tipo }"&matricula=${vehiculo.matricula }"&validado="false"'>Borrar</a></div>

								</div>
							</c:if>	
							<c:set var="num" value="${num+1}" />
						</c:forEach>
						
						<c:if test="${empty requestScope.listaVehiculosSinValidar }">
							<p>No hay anuncios en esta categor&iacute;a</p>
						</c:if>

						<a href="nuevo_anuncio">Nuevo anuncio</a>

					</div>

					<!-- CON VALIDAR **********************************************************************-->
					<div id='vehi'>
						
						<div id='fila'>
							<div id='boton'>			
								Lista de anuncios de <c:out value="${requestScope.tipo }"></c:out> validados
							</div>	
						</div>

						<div id='barraV'>
			
							
							<div id='barraFoto'>Imagen</div>
							<div id='barraMarca'>Marca</div>	
							<div id='barraModelo'>Modelo</div>
							<div id='barraPrecio'>Precio</div>
							<div id='barraKM'>KM</div>
							<div id='barraColor'>Color</div>

						</div>

						<c:set var="num" value="${1}" />
						<c:forEach items="${requestScope.listaVehiculos  }" var="vehiculo">

							<c:if test="${num%2==0}">

								<div id='coches0'>
									
									<c:if test="${vehiculo.foto != null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>
											<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" /></a>
										</div>
									</c:if>
									<c:if test="${vehiculo.foto == null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>SIN FOTO</a>
										</div>
									</c:if>

									<div id='marca'><c:out value="${vehiculo.marca }"></c:out></div>
									<div id='modelo'><c:out value="${vehiculo.modelo }"></c:out></div>
									<div id='precio'><c:out value="${vehiculo.precio }"></c:out></div>
									<div id='KM'><c:out value="${vehiculo.km }"></c:out></div>
									<div id='color'><c:out value="${vehiculo.color }"></c:out></div>
									<div id='validar'><a href='borrar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Borrar</a></div>

								</div>	

							</c:if>

							<c:if test="${num%2==1}">

								<div id='coches1'>
									
									<c:if test="${vehiculo.foto != null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>
											<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" /></a>
										</div>
									</c:if>
									<c:if test="${vehiculo.foto == null }">
										<div id='foto'>
											<a href='./ficha_vehiculo?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>SIN FOTO</a>
										</div>
									</c:if>

									<div id='marca'><c:out value="${vehiculo.marca }"></c:out></div>
									<div id='modelo'><c:out value="${vehiculo.modelo }"></c:out></div>
									<div id='precio'><c:out value="${vehiculo.precio }"></c:out></div>
									<div id='KM'><c:out value="${vehiculo.km }"></c:out></div>
									<div id='color'><c:out value="${vehiculo.color }"></c:out></div>
									<div id='validar'><a href='borrar_anuncio?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>'>Borrar</a></div>

								</div>	

							</c:if>
							<c:set var="num" value="${num+1}" />
						</c:forEach>
						
						<c:if test="${empty requestScope.listaVehiculos }">
							<p>No hay anuncios en esta categor&iacute;a</p>
						</c:if>

						<a href="nuevo_anuncio">Nuevo anuncio</a>

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