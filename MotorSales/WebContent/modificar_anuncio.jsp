<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="screen" href="./style/default.css">
<title>MotorSales</title>

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

</head>
<body>

	<!-- Contenedor de toda la pagina -->
	<div id="pagina">
	
		<!-- Contenedor de la cabecera -->
		<div id="arriba">
		
			<!-- Logo  -->
			<div id="logo">
				<img alt="logoMotorSales" src="./img/MotorSalesImage2.png" width="100%" height="100%;"/>
			</div>
			<!-- Fin logo -->
			
			<!-- Columna de la publicidad -->
			<div id="colizq">
			
				<div id="banner">
				<c:if test="${requestScope.publicidad.banner != null }">
					<img id="imagen_banner" alt="publi" src="<c:out value="${requestScope.publicidad.banner }"></c:out>">
				</c:if>
				</div>
				<div id="texto_publicidad">
					<c:out value="${requestScope.publicidad.textoAnuncio }"></c:out>
				</div>
			</div>
			<!-- Fin columna de la publicidad -->
			
			<!-- Columna del login -->
			<div id="colder">
				
				<div id="login">
				<c:choose>
					<c:when test="${empty sessionScope.usuario}">

						<!-- Visualización de los mensajes de error -->
						<c:if test="${errores != null }">
							<p style="color: red">
							<c:forEach items="${errores }" var="error">
								<c:out value="${error }"></c:out><br />
							</c:forEach>
							</p>
						</c:if>
						
						<form action="login" method="post">
							<div class="fila">
								<div id="logiz">
									<label for="nom">Usuario:</label>
								</div>
								<div id="logder">
									 <input type="text" name="nombre" id="nom"><br> 
								 </div>
							 </div>
							 <div class="fila">
							 	<div id="logiz">
									<label for="clave">Contrase&ntilde;a:</label> 
								</div>
								<div id="logder">
									<input type="password" name="clave" id="clave"><br />
								</div>
							</div>
							<input class="button" type="submit" value="Iniciar sesi&oacute;n">
							<a href="nuevo_usuario">Nuevo Usuario</a>
						</form>
					
					</c:when>
					<c:otherwise>

							<p>
								Usuario: <b><c:out value="${sessionScope.usuario.nombreUsuario} "></c:out></b>
							</p>
							<%-- <a href="opciones_personales">Opciones personales</a>
							<c:if test="${sessionScope.usuario.vendedor == true }">
								<a href="nuevo_vehiculo">Nuevo Vehiculo</a>
							</c:if>
							<c:if test="${sessionScope.usuario.publicista == true }">
								<a href="nueva_publicidad">Nueva publicidad</a>
							</c:if>
							<c:if test="${sessionScope.usuario.administrador == true }">
								<a href="../administracion/">Labores de administracion</a>
							</c:if> --%>
							<a href="logout">Salir</a>
						
					</c:otherwise>
				</c:choose>
				</div>
				
			</div>
			<!-- Fin columna del login -->
		
		</div>
		<!-- Fin contenedor de la cabecera -->
		
		<!-- Contenedor del cuerpo de la página -->
		<div id="principal">
		
			<!-- Menú -->
			<div id="tabla">
			
				<div id="tabla2">
					<ul>
						<a href='default.jsp'><li>Inicio</li></a>
						<a href='coches'><li>Coches</li></a>
						<a href='motos'><li>Motos</li></a>
						<c:if test="${!empty sessionScope.usuario }">
							<HR width=90% align="center">
							<a href='opciones_personales'><li>Datos de usuario</li></a>
							<c:if test="${sessionScope.usuario.vendedor }">
								<a href="nuevo_vehiculo"><li>Nuevo Vehiculo</li></a>
							</c:if>
							<c:if test="${sessionScope.usuario.publicista }">
								<a href="nueva_publicidad"><li>Nueva publicidad</li></a>
							</c:if>
							<c:if test="${sessionScope.usuario.administrador == true }">
								<a href="../administracion/"><li>Labores de administracion</li></a>
							</c:if>
							<HR width=90% align="center">
							<a href="logout?origen=coches"><li>Salir</li></a>
						</c:if>
					</ul>
				</div>
			
			</div>
			<!-- Fin menú -->
			
			<!-- Contenido del cuerpo de la página -->
			<div id="centro">
			
				<center><h1>Modificar anuncio</h1></center>
				
				<c:if test="${errores != null }">
					<p style="color: red">
					<c:forEach items="${errores }" var="error">
						<c:out value="${error }"></c:out><br />
					</c:forEach>
					</p>
				</c:if>
			
				<div id="tabla_formulario_publicidad">
				<form action="modificar_anuncio" method="post" name="formulario"  enctype="multipart/form-data">
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Tipo de vehiculo:</div>
						<div class="col_der_publicidad">
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
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Marca:</div>
						<div class="col_der_publicidad">
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
						</div>
					</div>
					<div class="fila_formulario_publicidad">
					
						<div class="col_izq_publicidad">Modelo:</div>
						<div class="col_der_publicidad">
						<input type="text" name="modelo" id="modelo" value="${requestScope.vehiculo.modelo }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Matricula:</div>
						<div class="col_der_publicidad">
						<input type="text" name="matricula" id="matricula" value="${requestScope.vehiculo.matricula }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Color:</div>
						<div class="col_der_publicidad">
						<input type="text" name="color" id="color" value="${requestScope.vehiculo.color }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">A&ntilde;os matricula:</div>
						<div class="col_der_publicidad">
						<input type="text" name="anyosMatricula" id="anyosMatricula" value="${requestScope.vehiculo.añosMatricula }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Kilometros:</div>
						<div class="col_der_publicidad">
						<input type="text" name="km" id="km" value="${requestScope.vehiculo.km }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Precio:</div>
						<div class="col_der_publicidad">
						<input type="text" name="precio" id="precio" value="${requestScope.vehiculo.precio }"><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Descripcion:</div>
						<div class="col_der_publicidad">
						<textarea name="descripcion" id="descripcion" ><c:out value="${requestScope.vehiculo.descripcion }"></c:out></textarea><br>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Imagen actual:</div>
						<div class="col_der_publicidad">
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
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Cambiar la imagen:</div>
						<div class="col_der_publicidad">
						<input type="file" name="dataFile" id="escogerFichero" onchange="capturarNombreFichero(this)"/><br />
						<input type="hidden" name="nombreFichero" id="nombreFichero" value="null" />
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Tarifa:</div>
						<div class="col_der_publicidad">
			        		<c:out value="${requestScope.vehiculo.tarifa.precio }"></c:out>&euro;/mes
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">Validez:</div>
						<div class="col_der_publicidad">
							Desde: 
							<c:out value="${requestScope.vehiculo.fechaInsercionFormateada }"></c:out>
							 hasta: 
							<c:out value="${requestScope.vehiculo.fechaFinFormateada }"></c:out>
						</div>
					</div>
					<div class="fila_formulario_publicidad">
						<div class="col_izq_publicidad">&nbsp;</div>
						<div class="col_der_publicidad">
						<input type="hidden" name="origen" value="nuevo_vehiculo">
						<input type="submit" value="Enviar" class="button">
						</div>
					</div>
				</form>
				</div>
				
			</div>
			<!-- Fin contenido del cuerpo de la página -->
			
		</div>
		<!-- Fin del contenedor del cuerpo de la pagina -->
		
		<!-- Pie de página -->
		<div id="pies">
		
		</div>
		<!-- Fin pie de página -->
		
	</div>
	<!-- Fin contenedor de toda la pagina -->
</body>
</html>