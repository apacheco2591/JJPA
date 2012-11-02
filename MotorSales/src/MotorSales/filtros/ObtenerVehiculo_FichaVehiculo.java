package MotorSales.filtros;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import MotorSales.dominio.Usuario;
import MotorSales.dominio.Vehiculo;


public class ObtenerVehiculo_FichaVehiculo implements Filter {

    // Constructor por defecto.
    public ObtenerVehiculo_FichaVehiculo() {
        // Vacío.
    }

	// Desctructor por defecto de la clase.
	public void destroy() {
		// Vacío.
	}

	// Método propio del filtro. Extrae el tipo de vehículo y su matrícula de la StringQuery y
	// emula un acceso a la base de datos obteniendo el vehículo en cuestión.
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		String tipo, matricula;
		List<Vehiculo> listaVehiculos;
		Iterator<Vehiculo> it;
		Vehiculo vehiculo = null;
		Usuario vendedor = null;

		
		// Extracción de los parámetros de la StringQuery.
		tipo = request.getParameter("tipo");
		matricula = request.getParameter("matricula");
		
		// Verificación de los parámetros.
		if((tipo == null) || (matricula == null) || (!tipo.equals("moto") && !tipo.equals("coche"))){
			request.getRequestDispatcher("./default.jsp").forward(request, response);
		}
		
		// Obtención de la lista de vehículos pertinente.
		if(tipo.equals("moto")){
			listaVehiculos = (List<Vehiculo>) request.getServletContext().getAttribute("listaMotos");
		}
		else{
			listaVehiculos = (List<Vehiculo>) request.getServletContext().getAttribute("listaCoches");
		}
		
		// Obtención del vehículo de la lista.
		it = listaVehiculos.iterator();
		while(it.hasNext()){
			vehiculo = it.next();
			if(vehiculo.getMatricula().equals(matricula)){
				request.setAttribute("vehiculo", vehiculo);
				vendedor = vehiculo.getUsuario();
				request.setAttribute("vendedor", vendedor);
				break;
			}
		}
		
		chain.doFilter(request, response);
	}

	// Método de inicialización del filtro.
	public void init(FilterConfig fConfig) throws ServletException {
		// Vacío.
	}

}
