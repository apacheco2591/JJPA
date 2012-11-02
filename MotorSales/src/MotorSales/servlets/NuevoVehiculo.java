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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import MotorSales.dominio.Tarifa;
import MotorSales.dominio.Usuario;
import MotorSales.dominio.Vehiculo;


public class NuevoVehiculo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String patronMatriculas = "(\\d{4}-[\\D\\w]{3}|[\\D\\w]{1,2}-\\d{4}-[\\D\\w]{1,2})";
	private Pattern patronMatricula= null;
	private SecureRandom random;
       
	// Constructor del servlet.
    public NuevoVehiculo() {
        super();
        this.patronMatricula = Pattern.compile(patronMatriculas);
        this.random = new SecureRandom();
    }

	// Método GET del servlet. No se debería acceder a este servlet mediante este método, por lo que se
    // redirige al usuario a la página de inicio.
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Tarifa> listaTarifas;
		
		// Obtención de la lista de tarifas "de la base de datos".
		listaTarifas = (List<Tarifa>) this.getServletContext().getAttribute("listaTarifas");
		
		// Inserción de la lista de tarifas en la petición.
		request.setAttribute("listaTarifas", listaTarifas);
		
		// Se pasa la petición a la vista asociada.
		request.getRequestDispatcher("/nuevo_vehiculo.jsp").forward(request, response);
	}

	// Método POST del servlet. Recibe los datos del nuevo vehículo, los valida y los inserta
	// en la base de datos.
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession sesion;
		Usuario vendedor;
		FileOutputStream os = null;
		List<Vehiculo> listaVehiculos = null;
		List<String> errores = null;
		String nombreFichero, rutaFoto, tipo, añosMatricula, color, descripcion, km, marca, modelo, matricula, precio, idTarifa, meses;
		Part p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13;
		Scanner scanner;
		File ficheroTest;
		InputStream is;
		Vehiculo vehiculo;
		Tarifa tarifa = null;
		List<Tarifa> listaTarifas;
		Iterator<Tarifa> it;
		int id;
		
		// Se recupera la sesión y el usuario.
		sesion  = request.getSession();
		vendedor = (Usuario) sesion.getAttribute("usuario");
		
		// Se comprueba que tenga permisos de vendedor.
		if(vendedor == null || !vendedor.isVendedor()){
			this.getServletContext().getRequestDispatcher("./default.jsp").forward(request, response);
			return;
		}
		
		// Obtención de los parámetros del formulario.
		p1 = request.getPart("tipo");
		scanner = new Scanner(p1.getInputStream());
		tipo = scanner.nextLine();
		scanner.close();
		
		p2 = request.getPart("anyosMatricula");
		scanner = new Scanner(p2.getInputStream());
		try{
			añosMatricula = scanner.nextLine();
		}catch (Exception e) {
			añosMatricula = null;
		}
		scanner.close();
		
		p3 = request.getPart("color");
		scanner = new Scanner(p3.getInputStream());
		try{
			color = scanner.nextLine();
		}catch (Exception e) {
			color = null;
		}
		scanner.close();
		
		p4 = request.getPart("descripcion");
		scanner = new Scanner(p4.getInputStream());
		try{
			descripcion = scanner.nextLine();
		}catch (Exception e) {
			descripcion = "";
		}
		scanner.close();
		
		p5 = request.getPart("km");
		scanner = new Scanner(p5.getInputStream());
		try{
			km = scanner.nextLine();
		}catch (Exception e) {
			km = null;
		}
		scanner.close();
		
		p6 = request.getPart("marca");
		scanner = new Scanner(p6.getInputStream());
		marca = scanner.nextLine();
		scanner.close();
		
		p7 = request.getPart("modelo");
		scanner = new Scanner(p7.getInputStream());
		try{
			modelo = scanner.nextLine();
		} catch (Exception e){
			modelo = null;
		}
		scanner.close();
		
		p8 = request.getPart("precio");
		scanner = new Scanner(p8.getInputStream());
		try{
			precio = scanner.nextLine();
		} catch (Exception e){
			precio = null;
		}
		scanner.close();
		
		p9 = request.getPart("matricula");
		scanner = new Scanner(p9.getInputStream());
		try{
			matricula = scanner.nextLine();
		} catch (Exception e){
			matricula = null;
		}
		scanner.close();
		
		p10 = request.getPart("nombreFichero");
		scanner = new Scanner(p10.getInputStream());
		nombreFichero = scanner.nextLine();
		scanner.close();
		
		p12 = request.getPart("idTarifa");
		scanner = new Scanner(p12.getInputStream());
		idTarifa = scanner.nextLine();
		scanner.close();
		
		p13 = request.getPart("meses");
		scanner = new Scanner(p13.getInputStream());
		meses = scanner.nextLine();
		
		
		// Flujo para leer el fichero de la imagen.
		p11 = request.getPart("dataFile");
		is = p11.getInputStream();
		
		// Validación de los datos.
		errores = this.validar(tipo, marca, modelo, matricula, añosMatricula, precio, km, color, descripcion, idTarifa, meses);
		
		// Obtención de la tarifa escogida.
		id = Integer.parseInt(idTarifa);
		listaTarifas = (List<Tarifa>) this.getServletContext().getAttribute("listaTarifas");
		it = listaTarifas.iterator();
		while(it.hasNext()){
			tarifa = it.next();
			if(tarifa.getId() == id){
				break;
			}
			tarifa = null;
		}
		
		if(tarifa == null){
			errores.add("Tarifa no encontrada");
		}
		else{
			tarifa.setMeses(Integer.parseInt(meses));
		}
		
		// Si hay errores, se redirige de nuevo a la vista asociada.
		if(errores.size() > 0){
			request.setAttribute("errores", errores);
			this.getServletContext().getRequestDispatcher("/nuevo_vehiculo.jsp").forward(request, response);
		}
		
		// Si no hay errores:
		else{
			
			// Se comprueba que se seleccionase un fichero.
			if(nombreFichero.equals("null")){
				rutaFoto = null;
			}
			else{
				// Ruta uri de la foto.
				rutaFoto = "./anuncios/" + nombreFichero;
				
				// Se comprueba que el fichero no exista en el servidor.
        		ficheroTest = new File(this.getServletContext().getRealPath(rutaFoto));
        		if(ficheroTest.exists()){
                	
        			// Si existe, se renombra el fichero.
        			nombreFichero = new BigInteger(130, random).toString(32);
                }
        		
        		// Obtención del nombre del fichero salida en el servidor.
                String ficheroSalida = this.getServletContext().getRealPath(rutaFoto);
                
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
			
			// Creación de un nuevo objeto Vehiculo con los datos recibidos.
			vehiculo = new Vehiculo(tipo, marca, modelo, matricula, Integer.parseInt(añosMatricula), 
					Float.parseFloat(precio), Integer.parseInt(km), color, descripcion, rutaFoto, 
					vendedor, tarifa, new Date());
			
			// Inserción del vehiculo en "la base de datos".
			if(tipo.equals("moto")){
				listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaMotos");
				listaVehiculos.add(vehiculo);
				this.getServletContext().removeAttribute("listaMotos");
				this.getServletContext().setAttribute("listaMotos", listaVehiculos);
			}
			else{
				listaVehiculos = (List<Vehiculo>) this.getServletContext().getAttribute("listaCoches");
				listaVehiculos.add(vehiculo);
				this.getServletContext().removeAttribute("listaCoches");
				this.getServletContext().setAttribute("listaCoches", listaVehiculos);
			}
			
			// Redirección del usuario a su página personal.
			request.getRequestDispatcher("/opciones_personales").forward(request, response);
		}
		
		// Cierre de recursos.
		if(scanner != null){
			scanner.close();
		}
		if(is != null){
			is.close();
		}
	}

	// Método para la validación de los datos obtenidos del formulario.
	private List<String> validar(String tipo, String marca, String modelo, String matricula, 
			String añosMatricula, String precio, String km, String color, String descripcion,
			String idTarifa, String meses){
		
		// Los errores encontrados se incluirán en esta lista.
		List<String> errores = new ArrayList<String>();
		
		if(modelo == null || modelo.equals("")){
			errores.add("No se ha especificado el modelo");
		}
		
		if(color == null || color.equals("")){
			errores.add("No se introdujo color");
		}
		
		if(matricula != null){
			Matcher matcher = this.patronMatricula.matcher(matricula);
			if(!matcher.matches()){
				errores.add("Matricula incorrecta.");
			}
		}
		else{
			errores.add("No se introdujo la matrícula");
		}
		
		if(km != null){
			while(km.lastIndexOf('.') >= 0){
				km = km.substring(0, km.lastIndexOf('.')) + km.substring(km.lastIndexOf('.')+1);
			}
			try{
				int kilometros = Integer.parseInt(km);
				if(kilometros < 0){
					errores.add("Kilometros incorrectos");
				}
			} catch (Exception e){
				errores.add("Kilometros incorrectos");
			}
		}
		else{
			errores.add("No se especificaron los kilómetros");
		}
		
		if(precio != null){
			precio = precio.replace(',', '.');
			try{
				float precioNumerico = Float.parseFloat(precio);
				if(precioNumerico < 0){
					errores.add("Precio incorrecto");
				}
			} catch (Exception e){
				errores.add("Precio incorrecto");
			}
		}
		else{
			errores.add("No se introdujo el precio");
		}
		
		if(añosMatricula != null){
			try{
				int años = Integer.parseInt(añosMatricula);
				if(años < 0){
					errores.add("Años matricula incorrectos");
				}
			} catch (Exception e){
				errores.add("Años matricula incorrectos");
			}
		}
		else{
			errores.add("No se especificaron los años de matrícula");
		}
		
		if(meses != null){
			try{
				int numMeses = Integer.parseInt(meses);
				if(numMeses <= 0){
					errores.add("Numero de meses de la tarifa incorrecto");
				}
			} catch (Exception e){
				errores.add("Numero de meses de la tarifa incorrecto");
			}
		}
		else{
			errores.add("No se especificaron los meses del anuncio");
		}
		
		try{
			int id = Integer.parseInt(idTarifa);
			if(id < 0){
				errores.add("Identificador de la tarifa incorrecto");
			}
		} catch (Exception e){
			errores.add("Identificador de la tarifa incorrecto");
		}
	
		return errores;
	}
}
