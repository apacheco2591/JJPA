package MotorSales.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MotorSales.dominio.Vehiculo;


public class Coches extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    // Constructor por defecto del servlet.
    public Coches() {
        super();
    }

	// Método GET del servlet. Emula un acceso a la base de datos para obtener la lista de coches.
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Vehiculo> listaVehiculos;
		
		// Obtención de la lista de coches.
		listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaCoches");
		
		// Inserción de la lista en el contexto.
		request.setAttribute("listaVehiculos", listaVehiculos);
		
		// Redirección a la página de vista asociada.
		this.getServletContext().getRequestDispatcher("/coches.jsp").forward(request, response);
	}

	// Método POST del servlet. Igual que el GET. En principio no debería usarse. 
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Vehiculo> listaVehiculos;
		
		// Obtención de la lista de coches.
		listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaCoches");
		
		// Inserción de la lista en el contexto.
		request.setAttribute("listaVehiculos", listaVehiculos);
		
		// Redirección a la página de vista asociada.
		this.getServletContext().getRequestDispatcher("/coches.jsp").forward(request, response);
	}

}
