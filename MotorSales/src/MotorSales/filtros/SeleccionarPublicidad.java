package MotorSales.filtros;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import MotorSales.dominio.Publicidad;


public class SeleccionarPublicidad implements Filter {

	private FilterConfig fConfig;
	private Random generadorAleatorios;
	
    // Constructor por defecto.
    public SeleccionarPublicidad() {
        // Vacío.
    }

	// Destructor por defecto de la clase.
	public void destroy() {
		// TODO Auto-generated method stub
	}

	// Método propio del filtro. Antes de cargar cualquier página, este filtro selecciona la publicidad
	// a mostrar en la misma.
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		int numAnuncios, numAleatorio;
		List<Publicidad> listaPublicidad;
		
		// Obtención de la lista de posibles publicidades.
		listaPublicidad = (List<Publicidad>) this.fConfig.getServletContext().getAttribute("listaPublicidad");
		
		// Selección aleatoria de una publicidad.
		numAnuncios = listaPublicidad.size();
		if(numAnuncios > 0){
			numAleatorio = this.generadorAleatorios.nextInt(numAnuncios);
			request.setAttribute("publicidad", listaPublicidad.get(numAleatorio));
		}
		
		chain.doFilter(request, response);
	}

	// Método de inicialización del filtro.
	public void init(FilterConfig fConfig) throws ServletException {
		this.fConfig = fConfig;
		this.generadorAleatorios = new Random();
	}

}
