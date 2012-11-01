<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/nuevo_anuncio.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>nuevo_anuncio.jsp</title>
</head>
<body>

<div id='pagina'>

		<c:if test="${empty sessionScope.usuario || !sessionScope.usuario.administrador }">
			<c:redirect url="/"></c:redirect>
		</c:if>
		
		<div id='header'>

		</div>

		<!-- Funciones JavaScript -->
		<script type="text/javascript">
	
			// Funcion para cargar la lista de marcas de motos.
			function cargarMarcasMotos(){
				var listaMarcas = document.getElementById("marca");
				listaMarcas.options.length = 0;
				<c:forEach items="${marcasMotos }" var="marca">
					listaMarcas.options[listaMarcas.options.length] = new Option("<c:out value="${marca }"></c:out>","<c:out value="${marca }"></c:out>");
				</c:forEach>
			}
				
			// Funcion para cargar la lista de marcas de coches.
			function cargarMarcasCoches(){
				var listaMarcas = document.getElementById("marca");
				listaMarcas.options.length = 0;
				<c:forEach items="${marcasCoches }" var="marca">
					listaMarcas.options[listaMarcas.options.length] = new Option("<c:out value="${marca }"></c:out>","<c:out value="${marca }"></c:out>");
				</c:forEach>
			}
				
			// Funcion para capturar el nombre del fichero.
			function capturarNombreFichero(object){
				var nombreFichero = object.value;
				var ultimoIndice = nombreFichero.lastIndexOf("\\");
				if(ultimoIndice >= 0){
					nombreFichero = nombreFichero.substring(ultimoIndice + 1);
				}
				if(nombreFichero == ""){
					document.getElementById("nombreFichero").value = "null";
				}
				else{
					document.getElementById("nombreFichero").value = nombreFichero;
				}
				//alert(document.getElementById("nombreFichero").value);
			}
		</script>

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
				
				<div id='formulario'>
					
					<!-- Visualización de los mensajes de error -->
					<c:if test="${errores != null }">
						<div id='fila'>
							<p style="color: red">
								<div id='boton'>			
									<c:forEach items="${errores }" var="error">
										<c:out value="${error }"></c:out>
									</c:forEach>
								</div>
							</p>	
						</div>
					</c:if>

					<div id='fila'>
						<div id='boton'>
							<b>Nuevo Anuncio</b>
						</div>	
					</div>
	
					<form action="nuevo_anuncio" method="post" name="formulario" id="formulario" enctype="multipart/form-data">

						<div id='fila'>
							<div id='colI'>
								<label for="tipo">Tipo de vehiculo:</label>
							</div>
							<div id='colD'>
								<input type="radio" name="tipo" value="moto" onclick="cargarMarcasMotos()">Moto		
							</div>	
						</div>
						<div id='fila'>
							<div id='colI'>
								
							</div>
							<div id='colD'>
								<input type="radio" name="tipo" value="coche" checked="checked" onclick="cargarMarcasCoches()">Coche	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="marca">Marca:</label>
							</div>
							<div id='colD'>
								<select name="marca" id="marca">
									<c:forEach items="${marcasCoches }" var="marca">
										<option value="${marca }"><c:out value="${marca }"></c:out></option>
									</c:forEach>
								</select>	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="modelo">Modelo:</label>
							</div>
							<div id='colD'>
								<input type="text" name="modelo" id="modelo">	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="matricula">Matricula:</label>
							</div>
							<div id='colD'>
								<input type="text" name="matricula" id="matricula">	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="color">Color:</label>
							</div>
							<div id='colD'>
								<input type="text" name="color" id="color">	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="anyosMatricula">A&ntilde;os matricula:</label>
							</div>
							<div id='colD'>
								<input type="text" name="anyosMatricula" id="anyosMatricula">
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="km">Kilometros:</label>
							</div>
							<div id='colD'>
								<input type="text" name="km" id="km">
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="precio">Precio:</label>
							</div>
							<div id='colD'>
								<input type="text" name="precio" id="precio">
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="descripcion">Descripcion:</label>
							</div>
							<div id='colD'>
								<input type="text" name="descripcion" id="descripcion">
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="escogerFichero">Imagen del veh&iacute;culo:</label>
							</div>
							<div id='colD'>
								<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br />
								<input type="hidden" name="nombreFichero" id="nombreFichero" value="null" />
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="idTarifa">Tarifa:</label>
							</div>
							<div id='colD'>
								<select name="idTarifa" id="idTarifa">
									<c:forEach items="${listaTarifas }" var="tarifa">
										<option value="${tarifa.id }"><c:out value="${tarifa.precio }"></c:out> &euro;/mes - M&iacute;nimo: <c:out value="${tarifa.minMeses }"></c:out> meses</option>
									</c:forEach>
								</select>
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="meses">Meses:</label>
							</div>
							<div id='colD'>
								<select name="meses" id="meses">
									<c:forEach var="i" begin="1" end="12">
										<option value="${i }"><c:out value="${i } meses"></c:out></option>
									</c:forEach>
								</select>
							</div>	
						</div>
						
						<div id='fila'>
							<div id='boton'>
								<input type="hidden" name="origen" value="nuevo_vehiculo">
								<input type="submit" value="Enviar">
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