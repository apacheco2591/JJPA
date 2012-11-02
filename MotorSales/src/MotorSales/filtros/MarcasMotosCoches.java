package MotorSales.filtros;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class MarcasMotosCoches implements Filter {

	// Parámetro de configuración del filtro.
	private FilterConfig fconfig;
	
	// Getter de fconfig.
	private FilterConfig getFconfig(){
		return this.fconfig;
	}
	
    // Constructor por defecto.
    public MarcasMotosCoches() {
        // Vacío.
    }

	// Desctructor por defecto.
	public void destroy() {
		// Vacío.
	}

	// Método propio del filtro. Obtiene dos listas con las marcas de coches y motos
	// y las inserta en el contexto emulando un acceso a la base de datos.
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		List<String> marcasMotos;
		List<String> marcasCoches;
		
		// Obtención de las marcas de coches y motos.
		marcasMotos = (List<String>) this.getFconfig().getServletContext().getAttribute("marcasMotos");
		marcasCoches = (List<String>) this.getFconfig().getServletContext().getAttribute("marcasCoches");
		
		// Inserción de los datos en la petición.
		request.setAttribute("marcasMotos", marcasMotos);
		request.setAttribute("marcasCoches", marcasCoches);
		
		chain.doFilter(request, response);
	}

	// Método de inicialización del filtro.
	public void init(FilterConfig fConfig) throws ServletException {
		this.fconfig = fConfig;
	}

}
