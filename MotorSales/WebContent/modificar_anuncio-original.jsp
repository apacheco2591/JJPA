<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>modificar_vehiculo.jsp</title>
</head>
<body>

	<center><h1>modificar_vehiculo.jsp</h1></center>
	
	<!-- Inserción de la publicidad -->
	<p>
	<c:if test="${requestScope.publicidad.banner != null }">
		<img height="50px" width="150px" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
	</c:if>
	<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
	</p>
	
	<!-- Se comprueba que el usuario esté logueado y tenga permisos de vendedor -->
	<c:choose>
		<c:when test="${empty sessionScope.usuario || sessionScope.usuario.vendedor == false}">
			<!-- Se redirige a la pagina principal si el usuario no esta logeado 
				 o si no tiene el rol de vendedor -->
			<c:redirect url="./"></c:redirect>
		</c:when>
		<c:otherwise>
			<fieldset>
				<legend>Bienvenido</legend>
				<p>
					Usuario: <c:out value="${sessionScope.usuario.nombreUsuario} "></c:out>
				</p>
				<a href="opciones_personales">Opciones personales</a>
				<c:if test="${sessionScope.usuario.vendedor == true }">
					<a href="nuevo_vehiculo.jsp">Nuevo Vehiculo</a>
				</c:if>
				<c:if test="${sessionScope.usuario.publicista == true }">
					<a href="nueva_publicidad">Nueva publicidad</a>
				</c:if>
				<c:if test="${sessionScope.usuario.administrador == true }">
					<a href="../administracion/">Labores de administracion</a>
				</c:if>
				<a href="logout">Salir</a>
			</fieldset>
		</c:otherwise>
	
	</c:choose>
	
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
	
	<br>
	
	<!-- Formulario para recoger los datos del nuevo vehículo -->
	<fieldset>
	<legend>Formulario para modificar un anuncio</legend>
	
		<!-- Visualización de los mensajes de error -->
		<c:if test="${errores != null }">
			<p style="color: red">
			<c:forEach items="${errores }" var="error">
				<c:out value="${error }"></c:out><br />
			</c:forEach>
			</p>
		</c:if>
	
		<form action="modificar_anuncio" method="post" name="formulario" id="formulario" enctype="multipart/form-data">
			<label for="tipo">Tipo de vehiculo:</label><br>
			
			<c:choose>
				<c:when test='${requestScope.vehiculo.tipo == "coche" }'>
					<input type="radio" name="tipo" value="moto" onclick="cargarMarcasMotos()">Moto<br>
					<input type="radio" name="tipo" value="coche" checked="checked" onclick="cargarMarcasCoches()">Coche<br>	
				</c:when>
				<c:otherwise>
					<input type="radio" name="tipo" value="moto" checked="checked" onclick="cargarMarcasMotos()">Moto<br>
					<input type="radio" name="tipo" value="coche"  onclick="cargarMarcasCoches()">Coche<br>
				</c:otherwise>
			</c:choose> 
			<label for="marca">Marca:</label>
			<%-- <select name="marca" id="marca">
				<c:forEach items="${marcasCoches }" var="marca">
					<option value="${marca }"><c:out value="${marca }"></c:out></option>
				</c:forEach>
			</select><br> --%>
			<c:choose>
				<c:when test='${requestScope.vehiculo.tipo == "coche" }'>
					<select name="marca" id="marca">
						<c:forEach items="${marcasCoches }" var="marca">
							<c:choose>
							<c:when test="${marca == requestScope.vehiculo.marca }">
								<option value="${marca }" selected="selected"><c:out value="${marca }"></c:out></option>
							</c:when>
							<c:otherwise>
								<option value="${marca }"><c:out value="${marca }"></c:out></option>
							</c:otherwise>
							</c:choose>
						</c:forEach>
					</select><br>
				</c:when>
				<c:otherwise>
					<select name="marca" id="marca">
						<c:forEach items="${marcasMotos }" var="marca">
							<c:choose>
							<c:when test="${marca == requestScope.vehiculo.marca }">
								<option value="${marca }" selected="selected"><c:out value="${marca }"></c:out></option>
							</c:when>
							<c:otherwise>
								<option value="${marca }"><c:out value="${marca }"></c:out></option>
							</c:otherwise>
							</c:choose>
						</c:forEach>
					</select><br>
				</c:otherwise>
			</c:choose>
			<label for="modelo">Modelo:</label>
			<input type="text" name="modelo" id="modelo" value="${requestScope.vehiculo.modelo }"><br>
			<label for="matricula">Matricula:</label>
			<input type="text" name="matricula" id="matricula" value="${requestScope.vehiculo.matricula }"><br>
			<label for="color">Color:</label>
			<input type="text" name="color" id="color" value="${requestScope.vehiculo.color }"><br>
			<label for="anyosMatricula">A&ntilde;os matricula:</label>
			<input type="text" name="anyosMatricula" id="anyosMatricula" value="${requestScope.vehiculo.añosMatricula }"><br>
			<label for="km">Kilometros:</label>
			<input type="text" name="km" id="km" value="${requestScope.vehiculo.km }"><br>
			<label for="precio">Precio:</label>
			<input type="text" name="precio" id="precio" value="${requestScope.vehiculo.precio }"><br>
			<label for="descripcion">Descripcion:</label>
			<input type="text" name="descripcion" id="descripcion" value="${requestScope.vehiculo.descripcion }"><br>
			<!-- <label for="escogerFichero">Imagen del veh&iacute;culo:</label>
			<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br /> -->
			
			<fieldset>
			<legend>Foto del anuncio</legend>
				<c:choose>
				<c:when test="${vehiculo.foto != null }">
					<a href="./ficha_vehiculo.jsp?tipo=<c:out value="${vehiculo.tipo }"></c:out>&matricula=<c:out value="${vehiculo.matricula }"></c:out>">
						<img src="<c:out value="${vehiculo.foto }"></c:out>" width="50px" height="50px" />
					</a><br />
				</c:when>
				
				<c:otherwise>
					<p><i>El anuncio no tiene foto</i></p>
				</c:otherwise>
				</c:choose>
				<label for="escogerFichero">Cambiar foto del veh&iacute;culo:</label>
				<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br />
			</fieldset>
			
			<input type="hidden" name="nombreFichero" id="nombreFichero" value="null" />
			
			<fieldset>
			<legend>Tarifa y validez del anuncio</legend>
				<table>
					<tr>
		        		<th>Fecha inicio</th>
		        		<th>Fecha fin</th>
		        		<th>Mensualidad</th>
	        		</tr>
	        		<tr>
	        			<td><c:out value="${requestScope.vehiculo.fechaInsercionFormateada }"></c:out>
	        			<td><c:out value="${requestScope.vehiculo.fechaFinFormateada }"></c:out>
	        			<td><c:out value="${requestScope.vehiculo.tarifa.precio }"></c:out></td>
	        		</tr>
	        	</table>
	        	<p>
	        		La tarifa de un anuncio no se puede modificar.
	        	</p>
			</fieldset>
			 
			<input type="hidden" name="origen" value="nuevo_vehiculo">
			<input type="submit" value="Enviar">
		</form>
	</fieldset>
</body>
</html>