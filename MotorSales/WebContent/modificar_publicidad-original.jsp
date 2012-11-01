<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Modificar publicidad</title>
</head>
<body>

	<h2>modificar_publicidad.jsp</h2>
	
	<!-- Inserción de publicidad -->
	<p>
	<c:if test="${requestScope.publicidad.banner != null }">
		<img height="50px" width="150px" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
	</c:if>
	<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
	</p>
	
	<!-- Comprobación de que el usuario está logueado y tiene permisos de publicista -->
	<c:choose>
		<c:when test="${empty sessionScope.usuario || sessionScope.usuario.publicista == false}">
			<!-- Se redirige a la pagina principal si el usuario no esta logeado 
				 o si no tiene el rol de publicista -->
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
	
	<!-- Formulario para insertar los datos de la nueva publicidad -->
	<form action="modificar_publicidad" method="post" name="formulario" id="formulario" enctype="multipart/form-data">
		<fieldset>
		
			<!-- Visualización de los mensajes de error -->
			<c:if test="${errores != null }">
				<p style="color: red">
				<c:forEach items="${requestScope.errores }" var="error">
					<c:out value="${error }"></c:out><br />
				</c:forEach>
				</p>
			</c:if>
		
			<legend>Formulario para modificar publicidad</legend>
			<label for="textoAnuncio">Texto del anuncio:</label>
			<input type="text" id="textoAnuncio" name="textoAnuncio" value="${requestScope.publicidad.textoAnuncio }"><br />
			<!-- <label for="escogerFichero">Imagen del anuncio:</label>
			<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br /> -->
			
			<fieldset>
			<legend>Imagen del anuncio</legend>
				<c:choose>
				<c:when test="${requestScope.publicidad.banner != null }">
					<img src="<c:out value="${requestScope.publicidad.banner }"></c:out>" width="50px" height="50px" /><br />
				</c:when>
				
				<c:otherwise>
					<p><i>El anuncio no tiene imagen</i></p>
				</c:otherwise>
				</c:choose>
				<label for="escogerFichero">Cambiar foto de la publicidad</label>
				<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br />
			</fieldset>
			
        	<input type="hidden" name="nombreFichero" id="nombreFichero" value="null" /><br />
        	<fieldset>
			<legend>Tarifa y validez del anuncio</legend>
				<table>
					<tr>
		        		<th>Fecha inicio</th>
		        		<th>Fecha fin</th>
		        		<th>Mensualidad</th>
	        		</tr>
	        		<tr>
	        			<td><c:out value="${requestScope.publicidad.fechaInsercionFormateada }"></c:out>
	        			<td><c:out value="${requestScope.publicidad.fechaFinFormateada }"></c:out>
	        			<td><c:out value="${requestScope.publicidad.tarifa.precio }"></c:out></td>
	        		</tr>
	        	</table>
	        	<p>
	        		La tarifa de un anuncio no se puede modificar.
	        	</p>
			</fieldset>
			<br />
			<input type="submit" value="Aceptar">
					
		</fieldset>
	</form>
	
</body>
</html>