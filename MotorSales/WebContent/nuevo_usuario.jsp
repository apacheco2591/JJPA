<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" type="text/css" media="screen" href="./style/registro_1.css"> -->
<link rel="stylesheet" type="text/css" media="screen" href="./style/default.css">
<title>MotorSales</title>
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

						
						
						<form action="login" method="post">
							<div class="fila">
								<div id="logiz">
									<label for="nom">Usuario:</label>
								</div>
								<div id="logder">
									 <input type="text" name="nombre" id="nom"> 
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
			
				<!-- Usuarios para modificar -->
			<c:choose>	
				
				<c:when test="${!empty sessionScope.usuario}">
				<div id='tabla_formulario_publicidad'>
				<center><h1>Modificar datos</h1></center>
				<!-- Visualización de los mensajes de error -->
				<c:if test="${errores != null }">
					<center><p style="color: red">
					<c:forEach items="${errores }" var="error">
						<c:out value="${error }"></c:out><br />
					</c:forEach>
					</p></center>
				</c:if>
				
				<form action="nuevo_usuario" method="post">
					
					<!-- FILA BOTON-->
					<div class="fila_formulario_publicidad">
					
					</div>
						<!-- FILA APELLIDOS -->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Nombre:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="nombre" id="nombre" size = "30" maxlength ="100" value="<c:out value='${sessionScope.usuario.nombre }'></c:out>"/>
							</div>
							
						</div>

						<!-- FILA CORREO-->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Apellidos:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="apellidos" id="apellidos" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.apellidos }"></c:out>'/>			
							</div>
						</div>

						<!-- FILA DIRECCION-->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Dirección:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="direccion" id="direccion" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.direccion }"></c:out>'/>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Población:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="poblacion" id="poblacion" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.poblacion }"></c:out>'>
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Provincia:
							</div>
							<div class="col_der_publicidad">
								<select name="provincia" id="provincia">
									<c:forEach items="${requestScope.listaProvincias }" var="provincia">
										<option value='<c:out value="${provincia }"> </c:out>' <c:if test="${provincia == sessionScope.usuario.provincia }"><c:out value='selected="selected"'></c:out></c:if>><c:out value="${provincia }"></c:out></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								CP:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="CP" id="CP" value="${sessionScope.usuario.CP }">
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Teléfono:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="telefono" id="telefono" size = "30" maxlength ="100" value="${sessionScope.usuario.telefono }"/>		
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								eMail:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="email" id="email" value='<c:out value="${sessionScope.usuario.email }"></c:out>' />
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Contraseña:
							</div>
							<div class="col_der_publicidad">
								<input type="password" name="contrasenya" id ="contraseña" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.contraseña }"></c:out>'>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Repetir contraseña :
							</div>
							<div class="col_der_publicidad">
								<input type="password" name="contrasenya2" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.contraseña }"></c:out>'/>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Nombre Usuario:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="nombreUsuario" id="nombreUsuario" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.nombreUsuario }"></c:out>'>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Permisos:
							</div>
							<div class="col_der_publicidad">
								<input type="checkbox" name="comprador" id="permisos" value="true" <c:if test="${sessionScope.usuario.comprador }"><c:out value='checked="checked"'></c:out></c:if> /> Comprador <i>(Permite realizar el proceso de compra de coches y motos)</i></br>
								<input type="checkbox" name="vendedor" value="true" <c:if test="${sessionScope.usuario.vendedor }"><c:out value='checked="checked"'></c:out></c:if> /> Vendedor <i>(Permite poner nuevos anuncios de motos y/o coches)</i></br>
								<input type="checkbox" name="publicista" value="true" <c:if test="${sessionScope.usuario.publicista }"><c:out value='checked="checked"'></c:out></c:if> /> Publicista <i>(Permite a&ntilde;adir la publicidad de su empresa/negocio)</i></br>	
							</div>
						</div>
							
						<!-- FILA BOTON-->
						<div class="fila_formulario_publicidad">
					
						</div>
						<div class="fila_formulario_publicidad">
							<div id='boton'>
								<input type="submit" value="Enviar">
							</div>	
						</div>	

					</form>
				</div>
				</c:when>
				<c:otherwise>
				
		
			
		<!-- Usuarios nuevo -->
		<center><h1>Nuevo usuario</h1></center>
		<div id="tabla_formulario_publicidad">
		
			<!-- Visualización de los mensajes de error -->
			<c:if test="${errores != null }">
				<p style="color: red">
				<c:forEach items="${errores }" var="error">
					<c:out value="${error }"></c:out><br />
				</c:forEach>
				</p>
			</c:if>
		
				<form action="nuevo_usuario" method="post">
					
					<!-- FILA BOTON-->
					<div class="fila_formulario_publicidad">
					
					</div>
						<!-- FILA APELLIDOS -->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Nombre:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="nombre" id="nombre" size = "30" maxlength ="100"/>			
							</div>
							
						</div>

						<!-- FILA CORREO-->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Apellidos:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="apellidos" id="apellidos" size = "30" maxlength ="100"/>			
							</div>
						</div>

						<!-- FILA DIRECCION-->
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Dirección:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="direccion" id="direccion" size = "30" maxlength ="100"/>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Población:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="poblacion" id="poblacion" size = "30" maxlength ="100">
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Provincia:
							</div>
							<div class="col_der_publicidad">
								<select name="provincia" id="provincia">
									<c:forEach items="${requestScope.listaProvincias }" var="provincia">
										<option value='<c:out value="${provincia }"></c:out>'><c:out value="${provincia }"></c:out></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								CP:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="CP" id="CP">
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Teléfono:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="telefono" id="telefono" size = "30" maxlength ="100" value='<c:out value="${sessionScope.usuario.telefono }"></c:out>' />		
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								eMail:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="email" id="email" size = "30" maxlength ="100"/>
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Contraseña:
							</div>
							<div class="col_der_publicidad">
								<input type="password" name="contrasenya" id ="contraseña" size = "30" maxlength ="100">			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Repetir contraseña :
							</div>
							<div class="col_der_publicidad">
								<input type="password" name="contrasenya2" id="nombreUsuario" size = "30" maxlength ="100">			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Nombre de Usuario:
							</div>
							<div class="col_der_publicidad">
								<input type="text" name="nombreUsuario" size = "30" maxlength ="100"/>			
							</div>
						</div>
						<div class="fila_formulario_publicidad">
							<div class= "col_izq_publicidad">
								Permisos:
							</div>
							<div class="col_der_publicidad">
								<input type="checkbox" name="comprador" id="permisos" value="true"> Comprador <i>(Permite realizar el proceso de compra de coches y motos)</i></br>
								<input type="checkbox" name="vendedor" value="true"> Vendedor <i>(Permite poner nuevos anuncios de motos y/o coches)</i></br>
								<input type="checkbox" name="publicista" value="true"> Publicista <i>(Permite a&ntilde;adir la publicidad de su empresa/negocio)</i></br>	
							</div>
						</div>
						<!-- FILA BOTON-->
						<div class="fila_formulario_publicidad">
					
						</div>
						<div class="fila_formulario_publicidad">
					
						</div>
						<div class="fila_formulario_publicidad">
					
						</div>
						<div class="fila_formulario_publicidad">
							<div id='boton' width='30%' >
								<!-- <div width='300px'></div>
								<div  float='left'>   -->
									<input type="submit" value="Enviar">
								<!--</div>-->
								
							</div>	
						</div>
						

					</form>
				</div>
			</c:otherwise>
			</c:choose>
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