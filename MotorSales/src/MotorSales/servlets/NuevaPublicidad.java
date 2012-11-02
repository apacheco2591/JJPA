package MotorSales.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
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


public class NuevaPublicidad extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SecureRandom random;
       
   // Constructor por defecto del servlet.
    public NuevaPublicidad() {
        super();
        this.random = new SecureRandom();
    }

	// Método GET del servlet. Recoge las tarifas disponibles para mostrarlas en la vista asociada.
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Tarifa> listaTarifas;
		
		// Se recupera la lista de tarifas "de la base de datos".
		listaTarifas = (List<Tarifa>) this.getServletContext().getAttribute("listaTarifas");
		
		// Se inserta en la petición.
		request.setAttribute("listaTarifas", listaTarifas);
		
		// Se redirige la petición a la vista asociada.
		this.getServletContext().getRequestDispatcher("/nueva_publicidad.jsp").forward(request, response);
	}

	// Método POST del servlet. Recibe los datos de la nueva publicidad, los valida y los inserta en la base de datos.
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion = request.getSession();
		String nombreFichero = null, rutaBanner, ficheroSalida, textoAnuncio;
		FileOutputStream os = null;
		File ficheroTest;
		Usuario publicista;
		Publicidad nuevaPublicidad;
		List<Publicidad> listaPublicidad;
		int idTarifa = -1, meses;
		List<String> errores;
		

    
    	// Texto del anuncio.
    	Part p1 = request.getPart("textoAnuncio");
    	Scanner s = new Scanner(p1.getInputStream());
    	try{
    		textoAnuncio = s.nextLine();
    	} catch (Exception e){
    		textoAnuncio = null;
    	}
    	s.close();
    	
        // Acceso al fichero de subida.
        Part p2 = request.getPart("dataFile"); 
        InputStream is = p2.getInputStream();

        // Se recoge el nombre del fichero.
        Part p3 = request.getPart("nombreFichero");
        s = new Scanner(p3.getInputStream());
        try{
        	nombreFichero = s.nextLine();
        } catch (Exception e){
        	nombreFichero = null;
        }
        s.close();
    	
    	// Se recoge el identificador de la tarifa
    	Part p4 = request.getPart("idTarifa");
    	s = new Scanner(p4.getInputStream()); 
    	try{
    		idTarifa = Integer.parseInt(s.nextLine());
    	} catch (Exception e){
    		idTarifa = -1;
    	}
    	s.close();
    	
    	// Se recoge el tiempo de contratación de la publicidad.
    	Part p5 = request.getPart("meses");
    	s = new Scanner(p5.getInputStream());
    	try{
    		meses = Integer.parseInt(s.nextLine());
    	} catch (Exception e){
    		meses = -1;
    	}
    	s.close();
    	
    	// Se validan los datos obtenidos.
    	errores = validar(textoAnuncio, idTarifa, meses);
    	if(errores.size() > 0){
    		request.setAttribute("errores", errores);
    		this.doGet(request, response);
    		return;
    	}
    	
    	// Se comprueba que se haya elegido algún fichero.
    	if(nombreFichero == null || nombreFichero.equals("null")){
    		rutaBanner = null;
    	}
    	else{
    		// Ruta uri del banner.
    		rutaBanner = "./publicidad/" + nombreFichero;
    		ficheroTest = new File(this.getServletContext().getRealPath(rutaBanner));
    		if(ficheroTest.exists()){
            	nombreFichero = new BigInteger(130, random).toString(32);
            	System.out.println("Renombrando el fichero");
            }
    		System.out.println("El fichero no existia previamente");
    		
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
        publicista = (Usuario) sesion.getAttribute("usuario");
        Tarifa tarifa = ((List<Tarifa>)this.getServletContext().getAttribute("listaTarifas")).get(idTarifa - 1);
        tarifa.setMeses(meses);
        nuevaPublicidad = new Publicidad(rutaBanner, textoAnuncio, publicista, tarifa, new Date(), random.nextInt(9999999));
        listaPublicidad = (List<Publicidad>) this.getServletContext().getAttribute("listaPublicidad");
        listaPublicidad.add(nuevaPublicidad);
        this.getServletContext().removeAttribute("listaPublicidad");
        this.getServletContext().setAttribute("listaPublicidad", listaPublicidad);
        
        // Se cierran los flujos abiertos.
        if(os != null){
        	os.close();
        }
        if(s != null){
        	s.close();
        }
    
        // Se retorna a la sección de opciones personales.
        this.getServletContext().getRequestDispatcher("/opciones_personales").forward(request, response);
	}

	
	// Método para validar los datos obtenidos del formulario.
	private List<String> validar(String textoAnuncio, int idTarifa, int meses){
		
		List<String> errores = new ArrayList<String>();
		
		if(textoAnuncio == null || textoAnuncio.equals("")){
			errores.add("No se introdujo el texto del anuncio");
		}
		
		if(idTarifa < 0){
			errores.add("Identificador de taria incorrecto");
		}
		
		if(meses < 0){
			errores.add("Número de meses incorrecto");
		}
		
		return errores;
	}
}


