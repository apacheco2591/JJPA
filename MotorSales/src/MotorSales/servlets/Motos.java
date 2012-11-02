package MotorSales.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MotorSales.dominio.Vehiculo;


public class Motos extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    // Constructor por defecto del servlet.
    public Motos() {
        super();
    }

	// Método GET del servlet. Emula un acceso a la base de datos obteniendo la lista de las motos.
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Vehiculo> listaVehiculos;
		
		// Obtención de la lista de motos.
		listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaMotos");
		
		// Inserción de la lista en la petición.
		request.setAttribute("listaVehiculos", listaVehiculos);
		
		// Redirección a la vista asociada.
		this.getServletContext().getRequestDispatcher("/motos.jsp").forward(request, response);
	}

	// Método POST del servlet. Igual que el GET.
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		List<Vehiculo> listaVehiculos;
		
		// Obtención de la lista de motos.
		listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaMotos");
		
		// Inserción de la lista en la petición.
		request.setAttribute("listaVehiculos", listaVehiculos);
		
		// Redirección a la vista asociada.
		this.getServletContext().getRequestDispatcher("/motos.jsp").forward(request, response);
	}
}
