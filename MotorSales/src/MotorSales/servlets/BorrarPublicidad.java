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


public class BorrarPublicidad extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BorrarPublicidad() {
        super();
    }


	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		Usuario usuario;
		Publicidad publicidad = null;
		List<Publicidad> listaPublicidad;
		Iterator<Publicidad> it;
		List<String> errores;
		String idRecibido;
		int id;
		
		// Se comprueba que el usuario esté logueado y que tiene permisos de publicista.
		sesion = request.getSession();
		usuario = (Usuario) sesion.getAttribute("usuario");
		if(usuario == null || !usuario.isPublicista()){
			request.getRequestDispatcher("/default.jsp").forward(request, response);
			return;
		}
		
		// Obtención del identificador de la publicidad.
		idRecibido = request.getParameter("id");
		
		// En caso de no haber obtenido el identificador de la publicidad, se inserta un mensaje de error
		// y se redirecciona a la vista apropiada.
		if(idRecibido == null){
			errores = new ArrayList<String>();
			errores.add("No se recibió el identificador de la publicidad");
			request.setAttribute("erroresPublicidad", errores);
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}
		
		// Conversión del tipo de dato.
		try{
			id = Integer.parseInt(idRecibido);
		} catch (Exception e){
			errores = new ArrayList<String>();
			errores.add("Identificador de la publicidad incorrecto");
			request.setAttribute("erroresPublicidad", errores);
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}
		
		// Obtención de la publicidad "de la base de datos".
		listaPublicidad = (List<Publicidad>) this.getServletContext().getAttribute("listaPublicidad");
		it = listaPublicidad.iterator();
		while(it.hasNext()){
			publicidad = it.next();
			if(publicidad.getId() == id){
				break;
			}
			publicidad = null;
		}
		
		// Se comprueba que "la base de datos" devolvió el resultado esperado.
		if(publicidad == null){
			errores = new ArrayList<String>();
			errores.add("No se encontró la publicidad especificada");
			request.setAttribute("erroresPublicidad", errores);
		}
		else{
			// Se borra la publicidad.
			listaPublicidad.remove(publicidad);
		}
		
		// Se pasa la petición a la vista asociada.
		request.getRequestDispatcher("/opciones_personales").forward(request, response);
	}


//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//	}

}
