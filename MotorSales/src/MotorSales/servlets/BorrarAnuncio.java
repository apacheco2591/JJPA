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
import MotorSales.dominio.Vehiculo;


public class BorrarAnuncio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BorrarAnuncio() {
        super();
    }


	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		Usuario usuario;
		Vehiculo vehiculo = null;
		List<Vehiculo> listaVehiculos;
		Iterator<Vehiculo> it;
		String tipo, matricula;
		List<String> errores;
		
		// Se comprueba que el usuario esté logueado y tenga permisos de vendedor.
		sesion = request.getSession();
		usuario = (Usuario) sesion.getAttribute("usuario");
		if(usuario == null || !usuario.isVendedor()){
			request.getRequestDispatcher("/default.jsp").forward(request, response);
			return;
		}
		
		// Obtención del tipo de vehículo y su matrícula.
		tipo = request.getParameter("tipo");
		matricula = request.getParameter("matricula");
		
		// En caso de faltar algún parámetro de los anteriores, se inserta un mensaje de error
		// y se redirige a la vista apropiada.
		if(tipo == null || matricula == null){
			errores = new ArrayList<String>();
			errores.add("No se recibieron todos los parámetros necesarios");
			request.setAttribute("erroresVehiculos", errores);
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}
		
		// Obtención del anuncio "de la base de datos".
		if(tipo.equals("coche")){
			listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaCoches");
		}
		else{
			listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaMotos");
		}
		it = listaVehiculos.iterator();
		while(it.hasNext()){
			vehiculo = it.next();
			if(vehiculo.getMatricula().equals(matricula)){
				break;
			}
			vehiculo = null;
		}
		
		// Se comprueba que "la base de datos" devolvió el resultado esperado.
		if(vehiculo == null){
			errores = new ArrayList<String>();
			errores.add("No se encontró el vehículo especificado");
			request.setAttribute("erroresVehiculos", errores);
		}
		else{
			// Se elimina el anuncio.
			listaVehiculos.remove(vehiculo);
		}
		
		// Se pasa la petición a la vista asociada.
		request.getRequestDispatcher("/opciones_personales").forward(request, response);
	} 


//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//	}

}
