package MotorSales.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import MotorSales.dominio.Publicidad;
import MotorSales.dominio.Tarifa;
import MotorSales.dominio.Usuario;


public class ModificarPublicidad extends HttpServlet {
	
	private static final long serialVersionUID = 1L;  
	private SecureRandom random;
	
	
    public ModificarPublicidad() {
        super();
        this.random = new SecureRandom();
    }


	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		Usuario usuario;
		Publicidad publicidad = null;
		List<Publicidad> listaPublicidad;
		Iterator<Publicidad> it;
		List<String> errores;
		String idPublicidad;
		int id;
		
		// Recuperación de la lista de errores arrastrados desde el método 'doPost' o creación
		// de una nueva lista.
		errores = (List<String>) request.getAttribute("errores");
		if(errores == null){
			errores = new ArrayList<String>();
		}

		// Obtención del usuario asociado a la sesión.
		sesion = request.getSession();
		usuario = (Usuario) sesion.getAttribute("usuario");
		if(usuario == null || !usuario.isPublicista()){
			request.getRequestDispatcher("/default.jsp").forward(request, response);
			return;
		}
		
		// Obtención del identificador de la publicidad.
		idPublicidad = request.getParameter("id");
		if(idPublicidad == null){
			errores.add("No se recibió el identificador de la publicidad");
			request.setAttribute("erroresPublicidad", errores);
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}
		
		try{
			id = Integer.parseInt(idPublicidad);
		} catch (Exception e){
			errores.add("Identificador de publicidad incorrecto");
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
			errores.add("No se encontró la publicidad especificada");
			request.setAttribute("erroresPublicidad", errores);
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}
		else{
			// Inserción de la publicidad en la petición.
			request.setAttribute("publicidad", publicidad);
			sesion.setAttribute("publicidad", publicidad);
		}
		
		// Se pasa la petición a la vista asociada.
		request.getRequestDispatcher("/modificar_publicidad.jsp").forward(request, response);
	}


	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		String nombreFichero = null, rutaBanner, ficheroSalida;
		FileOutputStream os = null;
		File ficheroTest;
		Usuario publicista;
		Publicidad nuevaPublicidad, viejaPublicidad;
		List<Publicidad> listaPublicidad;
		Tarifa tarifa;
		List<String> errores;
		String textoAnuncio = null;
		
		// Se comprueba que el usuario esté logueado y tenga permisos de publicista.
		sesion = request.getSession();
		publicista = (Usuario) sesion.getAttribute("usuario");
		if(publicista == null || !publicista.isPublicista()){
			request.getRequestDispatcher("/default.jsp").forward(request, response);
			return;
		}
		
		// Obtención de la publicidad (estado previo).
		viejaPublicidad = (Publicidad) sesion.getAttribute("publicidad");
		if(viejaPublicidad == null){
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
			return;
		}

	    
    	// Texto del anuncio.
    	Part p1 = request.getPart("textoAnuncio");
    	Scanner s = new Scanner(p1.getInputStream());
    	try{
    		textoAnuncio = s.nextLine(); 
    		
    		System.out.println(textoAnuncio);
    		
    	} catch (Exception e){
    		errores = new ArrayList<String>();
    		errores.add("No se introdujo texto para la publicidad");
    		request.setAttribute("errores", errores);
    		request.setAttribute("id", viejaPublicidad.getId());
    		this.doGet(request, response);
    		s.close();
    		return;
    	}
    	s.close();
    	
        // Acceso al fichero de subida.
        Part p2 = request.getPart("dataFile"); 
        InputStream is = p2.getInputStream();

        // Se recoge el nombre del fichero.
        Part p3 = request.getPart("nombreFichero");
        s = new Scanner(p3.getInputStream());
    	nombreFichero = s.nextLine();
    	s.close();

    	
    	// Se comprueba que se ha elegido un fichero.
    	if(nombreFichero.equals("null")){
    		rutaBanner = viejaPublicidad.getBanner();
    	}
    	else{
    		// Se borra el antiguo banner.
    		ficheroTest = new File(this.getServletContext().getRealPath(viejaPublicidad.getBanner().substring(1)));
    		if(ficheroTest.exists()){
    			ficheroTest.delete();
    		}
    		ficheroTest = null; 
    		
    		// Ruta uri del banner.
    		rutaBanner = "./publicidad/" + nombreFichero;
    		ficheroTest = new File(this.getServletContext().getRealPath(rutaBanner));
    		if(ficheroTest.exists()){
            	nombreFichero = new BigInteger(130, random).toString(32);
            }
    		
    		 // Obtención del fichero salida en el servidor.
            ficheroSalida = this.getServletContext().getRealPath(rutaBanner);
            
            // Escritura del fichero.
            int ch = is.read();
            if(ch < 0){
            	nombreFichero = null;
            }
            else{
            	os = new FileOutputStream (ficheroSalida); 
            	while (ch != -1) {
                    os.write(ch);
                    ch = is.read();
               }
            }
    	}

        // Se añade la nueva publicidad a la base de datos.
        tarifa = viejaPublicidad.getTarifa();
        nuevaPublicidad = new Publicidad(rutaBanner, textoAnuncio, publicista, tarifa, new Date(), random.nextInt(9999999));
        listaPublicidad = (List<Publicidad>) this.getServletContext().getAttribute("listaPublicidad");
        listaPublicidad.remove(viejaPublicidad);
        listaPublicidad.add(nuevaPublicidad);
        
        // Cierre de los flujos abiertos.
        if(os != null){
        	os.close();
        }
        if(s != null){
        	s.close();
        }
        
        // Se retorna a la sección de opciones personales.
        request.getRequestDispatcher("/opciones_personales").forward(request, response);
	}

}


