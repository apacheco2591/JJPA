<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/ficha_vehiculo.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ficha del vehiculo</title>
</head>
<body>
	
	<div id='pagina'>
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

				<!-- Comprobación de que se ha recibido los datos del vehículo -->
				<c:if test="${!empty requestScope.vehiculo }">
	
					<!-- Vista de los datos del vehículo -->
					<c:if test="${vehiculo.foto != null }">
						<div id='foto'>
							<img src="<c:out value="${vehiculo.foto }"></c:out>" />
						</div>					
					</c:if>
					<c:if test="${vehiculo.foto == null }">
						<div id='foto'>
							<h1><center>SIN FOTO</center></h1>
						</div>					
					</c:if>

					<div id='login'>

						<div id='fila'>
							<div id='boton'>
								<b>Ficha del Vehiculo</b>
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									Marca:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.marca }"></c:out>		
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									Modelo:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.modelo }"></c:out>		
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									Precio:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.precio }"></c:out>	
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									A&ntilde;os matr&iacute;cula:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.añosMatricula }"></c:out>		
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									K&iacute;lometros:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.km }"></c:out>		
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									Color:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.color }"></c:out>		
							</div>	
						</div>


						<div id='fila'>
								<div id='colI'>
									Matr&iacute;cula:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.matricula }"></c:out>		
							</div>	
						</div>

						<div id='fila'>
								<div id='colI'>
									Descripci&oacute;n:
								</div>
							<div id='colD'>
								<c:out value="${vehiculo.descripcion }"></c:out>		
							</div>	
						</div>
					</div>

					<div id='vendedor'>
						
						<div id='filaV'>
							<div id='boton'>
								<b>Ficha del Vendedor</b>
							</div>	
						</div>

						<div id='filaV'>
								<div id='colIV'>
									Nombre:
								</div>
							<div id='colDV'>
								<c:out value="${requestScope.vendedor.nombre }"></c:out>		
							</div>	
						</div>

						<div id='filaV'>
								<div id='colIV'>
									Apellidos:
								</div>
							<div id='colDV'>
								<c:out value="${requestScope.vendedor.apellidos }"></c:out>		
							</div>	
						</div>

						<div id='filaV'>
								<div id='colIV'>
									Tel&oacute;fono:
								</div>
							<div id='colDV'>
								<c:out value="${requestScope.vendedor.telefono }"></c:out>		
							</div>	
						</div>

						<div id='filaV'>
								<div id='colIV'>
									Email:
								</div>
							<div id='colDV'>
								<c:out value="${requestScope.vendedor.email }"></c:out>		
							</div>	
						</div>

					</div>

					<div id='contratacion'>

						<div id='filaC'>
							<div id='boton'>
								<b>Ficha de Contratacion</b>
							</div>	
						</div>

						<div id='filaC'>
								<div id='colIC'>
									Precio:
								</div>
							<div id='colDC'>
								<c:out value="${vehiculo.tarifa.precio }"></c:out>		
							</div>	
						</div>

						<div id='filaC'>
								<div id='colIC'>
									Fecha Inicio:
								</div>
							<div id='colDC'>
								<c:out value="${vehiculo.fechaInsercionFormateada }"></c:out>		
							</div>	
						</div>

						<div id='filaC'>
								<div id='colIC'>
									Fecha Final:
								</div>
							<div id='colDC'>
								<c:out value="${vehiculo.fechaFinFormateada }"></c:out>		
							</div>	
						</div>

					</div>

				</c:if>


			</div>
		</div>		
		<div id='footer'>

		</div>
	</div>
	
	<!-- Enlace a la página de inicio -->
	<!-- <a href="default.jsp">Inicio</a> -->
	
</body>
</html>