<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="./style/styles.css" rel="stylesheet" type="text/css">
<link href="./style/struct.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="screen" href="./style/nueva_publicidad.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Nueva publicidad</title>
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
			
			// Función para capturar el nombre del fichero.
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
				<div id='vacio'></div>
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
							<b>Nueva Publicidad</b>
						</div>	
					</div>

					<!-- Formulario para insertar los datos de la nueva publicidad -->
					<form action="nueva_publicidad" method="post" name="formulario" id="formulario" enctype="multipart/form-data">
						
						<div id='fila'>
							<div id='colI'>
								<label for="textoAnuncio">Texto del anuncio:</label>
							</div>
							<div id='colD'>
								<input type="text" id="textoAnuncio" name="textoAnuncio">	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="escogerFichero">Imagen del anuncio:</label>
							</div>
							<div id='colD'>
								<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br />
        						<input type="hidden" name="nombreFichero" id="nombreFichero" value="null" />	
							</div>	
						</div>

						<div id='fila'>
							<div id='colI'>
								<label for="meses">Tiempo de contrataci&oacute;n:</label>
							</div>
							<div id='colD'>
								<select name="meses" id="meses">
									<option value="1">1 Mes</option>
									<option value="2">2 Meses</option>
									<option value="3">3 Meses</option>
					        	</select>	
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
							<div id='boton'>
								<input type="submit" value="Enviar" />
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