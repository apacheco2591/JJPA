package MotorSales.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import MotorSales.dominio.Usuario;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    // Constructor por defecto del servlet.
    public Login() {
        super();
    }

	// Método GET del servlet. No se debe acceder a este servlet por este método, por lo que se redirige
    // la petición a la página de inicio.
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
	}

	// Método POST del servlet. Corresponde con la accion "login". Recibe un nombre de usuario y una contraseña y
	// comprueba que exista el usuario y que la contraseña sea correcta. En tal caso, crea un objeto de tipo
	// "Usuario" y lo introduce en la sesión.
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nombreUsuario, contraseña, origen = null, tipo, matricula;
		Usuario usuario = null;
		List<Usuario> listaUsuarios = null;
		Iterator<Usuario> it = null;
		HttpSession sesion;
		List<String> errores = null;
		
		// Obtención de la sesión.
		sesion = request.getSession();
		
		// Obtención de los parámetros correspondientes al nombre de usuario y contraseña.
		nombreUsuario = request.getParameter("nombre");
		contraseña = request.getParameter("clave");
		
		// Acceso a la lista de usuarios registrados.
		listaUsuarios = (List<Usuario>) this.getServletContext().getAttribute("listaUsuarios");
		
		// Se recorre la lista en busca de una coincidencia.
		it = listaUsuarios.iterator();
		while(it.hasNext()){
			usuario = (Usuario) it.next();
			if(usuario.getNombreUsuario().equals(nombreUsuario) && usuario.getContraseña().equals(contraseña)){
				break;
			}
			else{
				usuario = null;
			}
		}
		
		// Se redirige la petición en función de si el login fue correcto y de si se conoce la
		// procedencia del usuario.
		if(usuario != null){
			sesion.setAttribute("usuario", usuario);
			
		}
		else{
			errores = new ArrayList<String>();
			errores.add("Nombre de usuario o contraseña incorrectos");
			request.setAttribute("errores", errores);
		}
		
		origen = request.getParameter("origen");
		if(origen == null){
			this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
		}
		else{
			tipo = request.getParameter("tipo");
			matricula = request.getParameter("matricula");
			if(tipo != null && matricula != null){
				request.setAttribute("tipo", tipo);
				request.setAttribute("matricula", matricula);
			}
			
			this.getServletContext().getRequestDispatcher("/"+origen).forward(request, response);
		}
	}

}
