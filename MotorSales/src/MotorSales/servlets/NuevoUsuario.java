package MotorSales.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import MotorSales.dominio.Usuario;


/**
 * Este servlet sirve tanto para crear un nuevo usuario como para modificar
 * los datos de un usuario existente.
 */
public class NuevoUsuario extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private final String patronNombres = "([\\D\\w\\sáéíóúÁÉÍÓÚüÜ]{2,20})";
	private final String patronApellidos = "([\\D\\w\\sáéíóúÁÉÍÓÚüÜ]{2,40})";
	private final String patronEmails = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$";
	private final String patronNombreUsuarios = "^[a-z0-9_-]{3,15}$";
	private Pattern patronNombre= null;
	private Pattern patronApellido = null;
	private Pattern patronEmail = null;
	private Pattern patronNombreUsuario = null;
       
	// Constructor por defecto.
    public NuevoUsuario() {
        super();
        this.patronEmail = Pattern.compile(this.patronEmails, Pattern.CASE_INSENSITIVE);
        this.patronNombre = Pattern.compile(this.patronNombres, Pattern.CASE_INSENSITIVE);
        this.patronApellido = Pattern.compile(this.patronApellidos, Pattern.CASE_INSENSITIVE);
        this.patronNombreUsuario = Pattern.compile(this.patronNombreUsuarios, Pattern.CASE_INSENSITIVE);
    }

	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		Usuario usuario;
		List<String> listaProvincias;
		
		// Se recupera al usuario.
		sesion = request.getSession();
		usuario = (Usuario) sesion.getAttribute("usuario");
		if(usuario == null){
			usuario = (Usuario) this.getServletContext().getAttribute("usuario");
		}
		else{
			this.getServletContext().setAttribute("usuario", usuario); 
		}
		
		// Se obtiene la lista de provincias "de la base de datos".
		listaProvincias = (List<String>) this.getServletContext().getAttribute("listaProvincias");
		
		// Se inserta la lista de provincias en la petición.
		request.setAttribute("listaProvincias", listaProvincias);
		
		// Se redirige la petición a la vista asociada.
		this.getServletContext().getRequestDispatcher("/nuevo_usuario.jsp").forward(request, response);
	}

	// Método POST del servlet. Recoge los datos del nuevo usuario y, si no existe dicho usuario, 
	// los inserta en la base de datos. 
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean comprador = false, vendedor = false, publicista = false, existeUsuario = false;
		Iterator<Usuario> it = null;
		Usuario usuario, usuarioAux = null;
		HttpSession sesion = null;
		String nombreUsuario, nombreUsuarioViejo, contraseña, contraseña2, nombre, apellidos, direccion, poblacion, provincia, CP, telefono, email;
		//int telefono, CP;
		List<Usuario> listaUsuarios;
		List<String> errores;
		
		// Obtención del usuario de la sesión.
		sesion = request.getSession();
		usuario = (Usuario) this.getServletContext().getAttribute("usuario");
		
		// Obtención de los datos del formulario.
		nombreUsuario = request.getParameter("nombreUsuario");
		contraseña = request.getParameter("contrasenya");
		contraseña2 = request.getParameter("contrasenya2");
		nombre = request.getParameter("nombre");
		apellidos = request.getParameter("apellidos");
		direccion = request.getParameter("direccion");
		poblacion = request.getParameter("poblacion");
		provincia = request.getParameter("provincia");
		CP = request.getParameter("CP");
		telefono = request.getParameter("telefono");
		email = request.getParameter("email");
		
		if(request.getParameter("comprador")!=null && request.getParameter("comprador").equals("true")){
			comprador = true;
		}
		if(request.getParameter("vendedor")!=null && request.getParameter("vendedor").equals("true")){
			vendedor = true;
		}
		if(request.getParameter("publicista")!=null && request.getParameter("publicista").equals("true")){
			publicista = true;
		}
		
		// Validación de los datos obtenidos.
		errores = Validar(nombreUsuario, contraseña, contraseña2, nombre, apellidos, poblacion, CP, telefono, email, comprador, vendedor, publicista);
		if(errores.size() > 0){
			request.setAttribute("errores", errores);
			this.doGet(request, response);
			return;
		}
		
		// Si no existe usuario en la sesión se ejecuta el caso de dar de alta a un nuevo usuario.
		if(usuario == null){
			
			// Se busca "en la base de datos" si existe un usuario con el mismo nombre de usuario.
			listaUsuarios = (List<Usuario>) this.getServletContext().getAttribute("listaUsuarios");
			it = listaUsuarios.iterator();
			while(it.hasNext()){
				usuario = (Usuario) it.next();
				if(usuario.getNombreUsuario().equals(nombreUsuario)){
					existeUsuario = true;
					break;
				}
			}

			// Si no existe, se crea el nuevo usuario.
			if(!existeUsuario){
				usuario = new Usuario(nombreUsuario, contraseña, nombre, apellidos, direccion, poblacion, provincia, Integer.parseInt(CP), Integer.parseInt(telefono), email, comprador, vendedor, publicista, false);
				listaUsuarios.add(usuario);
				this.getServletContext().removeAttribute("listaUsuarios");
				this.getServletContext().setAttribute("listaUsuarios", listaUsuarios);
				
				sesion.setAttribute("usuario", usuario);
				this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
			}
			else{
				// En caso contrario se inserta un nuevo mensaje de error y se redirige a la vista apropiada.
				errores = new ArrayList<String>();
				errores.add("El nombre de usuario "+nombreUsuario+" ya existe. Escoja otro por favor");
				request.setAttribute("errores", errores);
				this.getServletContext().getRequestDispatcher("/nuevo_usuario.jsp").forward(request, response);
				return;
			}
		}
		
		// Si existe usuario en la sesión, se ejecuta el caso de modificar datos del usuario.
		else{
			// Se obtiene el nombre de usuario antiguo.
			nombreUsuarioViejo = usuario.getNombreUsuario();
			
			// Se fijan los nuevos datos.
			usuario.setApellidos(apellidos);
			usuario.setContraseña(contraseña);
			usuario.setDireccion(direccion);
			usuario.setEmail(email);
			usuario.setNombre(nombre);
			usuario.setNombreUsuario(nombreUsuario);
			usuario.setPublicista(publicista);
			usuario.setTelefono(Integer.parseInt(telefono));
			usuario.setVendedor(vendedor);
			usuario.setComprador(comprador);
			usuario.setPoblacion(poblacion);
			usuario.setProvincia(provincia);
			usuario.setCP(Integer.parseInt(CP));
			
			// Se actualizan los datos de "la base de datos".
			listaUsuarios = (List<Usuario>) this.getServletContext().getAttribute("listaUsuarios");
			it = listaUsuarios.iterator();
			while(it.hasNext()){
				usuarioAux = (Usuario) it.next();
				if(usuarioAux.getNombreUsuario().equals(nombreUsuarioViejo)){
					listaUsuarios.remove(usuarioAux);
					listaUsuarios.add(usuario);
					break;
				}
			}
			sesion.setAttribute("usuario", usuario);
			this.getServletContext().removeAttribute("usuario");
			this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
		}
		
	}

	
	// Método para validar los datos obtenidos del formulario.
	private List<String> Validar(String nombreUsuario, String contraseña, String contraseña2, String nombre, String apellidos,
			String poblacion, String CP, String telefono, String email,   
			boolean comprador, boolean vendedor, boolean publicista){
		
		Matcher matcher;
		int numCP, numTelefono;
		List<String> errores = new ArrayList<String>();
		
		matcher = this.patronNombreUsuario.matcher(nombreUsuario);
		if(!matcher.matches()){
			errores.add("Nombre de usuario incorrecto");
		}
		
		if(contraseña == null || contraseña.length() < 8){
			errores.add("Contraseña incorrecta. Debe tener al menos 8 caracteres");
		}
		
		if(contraseña2 == null || !contraseña2.equals(contraseña)){
			errores.add("Las contraseñas no coinciden");
		}
		
		matcher = this.patronNombre.matcher(nombre);
		if(!matcher.matches()){
			errores.add("Nombre incorrecto");
		}
		
		matcher = this.patronApellido.matcher(apellidos);
		if(!matcher.matches()){
			errores.add("Apellidos incorrectos");
		}
		
		matcher = this.patronApellido.matcher(poblacion);
		if(!matcher.matches()){
			errores.add("Población incorrecta");
		}
		
		if(CP.length() > 5 || CP.length() < 4){
			errores.add("CP incorrecto");
		}
		else{
			try{
				numCP = Integer.parseInt(CP);
				if(numCP < 1000 || numCP > 52999){
					errores.add("CP incorrecto");
				}
			} catch (Exception e){
				errores.add("CP incorrecto");
			}
		}
		
		if(telefono.length() != 9){
			errores.add("Teléfono incorrecto");
		}
		else{
			try{
				numTelefono = Integer.parseInt(telefono);
				if( ! ((numTelefono >= 600000000 && numTelefono <= 799999999) 
						|| (numTelefono >= 900000000 && numTelefono <= 999999999))){
					errores.add("Teléfono incorrecto");
				}
			} catch (Exception e){
				errores.add("Teléfono incorrecto");
			}
		}
		
		matcher = this.patronEmail.matcher(email);
		if(!matcher.matches()){
			errores.add("Email incorrecto");
		}
		
		if( ! (comprador || vendedor || publicista)){
			errores.add("Se debe seleccionar al menos un permiso");
		}
		
		return errores;
	}
}
