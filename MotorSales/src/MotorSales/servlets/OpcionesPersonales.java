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

import MotorSales.dominio.Publicidad;
import MotorSales.dominio.Usuario;
import MotorSales.dominio.Vehiculo;


public class OpcionesPersonales extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	// Constructor por defecto del servlet.
    public OpcionesPersonales() {
        super();
    }

	// Método GET del servlet. Carga las listas de publicidad y anuncios propios del usuario.
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Vehiculo vehiculo = null;
		Publicidad publicidad = null;
		List<Vehiculo> listaVehiculos = null;
		List<Vehiculo> listaVehiculosUsuario = null;
		List<Publicidad> listaPublicidad = null;
		List<Publicidad> listaPublicidadUsuario = null;
		HttpSession sesion;
		Usuario usuario;
		
		// Se recupera la sesión y el usuario.
		sesion = request.getSession();
		usuario = (Usuario) sesion.getAttribute("usuario");
		
		// Si el usuario es vendedor se genera una lista con todos los anuncios de vehículos
		// que le sean propios.
		if(usuario.isVendedor()){
			listaVehiculosUsuario = new ArrayList<Vehiculo>();
			listaVehiculos = new ArrayList<Vehiculo>();
			
			List<Vehiculo> listaMotos = (List<Vehiculo>) this.getServletContext().getAttribute("listaMotos");
			Iterator<Vehiculo> it = listaMotos.iterator();
			while(it.hasNext()){
				listaVehiculos.add(it.next());
			}
			
			List<Vehiculo> listaCoches = (List<Vehiculo>) this.getServletContext().getAttribute("listaCoches");
			it = listaCoches.iterator();
			while(it.hasNext()){
				listaVehiculos.add(it.next());
			}
			
			it = listaVehiculos.iterator();
			while(it.hasNext()){
				vehiculo = it.next();
				if(vehiculo.getUsuario().getNombreUsuario().equals(usuario.getNombreUsuario())){
					listaVehiculosUsuario.add(vehiculo);
				}
			}
			request.setAttribute("listaVehiculosUsuario", listaVehiculosUsuario);
		}
		
		// Si el usuario es publicista, se genera una lista con toda la publicidad que le es propia.
		if(usuario.isPublicista()){
			listaPublicidad = (List<Publicidad>) this.getServletContext().getAttribute("listaPublicidad");
			listaPublicidadUsuario = new ArrayList<Publicidad>();
			Iterator<Publicidad> it = listaPublicidad.iterator();
			while(it.hasNext()){
				publicidad = it.next();
				if(publicidad.getPublicista().getNombreUsuario().equals(usuario.getNombreUsuario())){
					listaPublicidadUsuario.add(publicidad);
				}
			}
			request.setAttribute("listaPublicidadUsuario", listaPublicidadUsuario);
		}
		
		// Se redirige la petición a la vista pertinente.
		request.getRequestDispatcher("/opciones_personales.jsp").forward(request, response);
	}

	// Método POST del servlet. Sencillamente remite al método GET.
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
