package MotorSales.filtros;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class OpcionesPersonalesComprobarUsuario implements Filter {
	
	// Constructor por defecto del filtro.
    public OpcionesPersonalesComprobarUsuario() {
        // Vacío.
    }

	// Destructor por defecto del filtro.
	public void destroy() {
		// Vacío.
	}

	// Método propio del filtro. Antes de acceder a la sección de opciones personales de un usuario,
	// este filtro comprueba que se ha iniciado sesión.
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		// Se accede a la sesión.
		HttpSession sesion = ((HttpServletRequest) request).getSession();
		
		// Si no hay usuario en la sesión, se remite a la página inicial.
		if(sesion.getAttribute("usuario") == null){
			request.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
		}
		
		chain.doFilter(request, response);
	}

	// Método de inicialización del filtro.
	public void init(FilterConfig fConfig) throws ServletException {
		// Vacío.
	}

}
