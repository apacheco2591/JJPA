package MotorSales.filtros;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import MotorSales.dominio.Publicidad;
import MotorSales.dominio.Tarifa;
import MotorSales.dominio.Usuario;
import MotorSales.dominio.Vehiculo;
 
public class IniciarBD implements Filter {

    private static final String rutaPublicidad = "./publicidad/";
	private static final String rutaFotos = "./anuncios/";
	private final String[] provincias = {
		"ALBACETE", "ALICANTE", "ALMERIA", "ALAVA", "ASTURIAS", "AVILA", "BADAJOZ",
		"BARCELONA", "BIZKAIA", "BURGOS", "CACERES", "CADIZ", "CANTABRIA", "CASTELLON",
		"CEUTA", "CIUDAD REAL", "CORDOBA", "CORUÑA, A", "CUENCA", "GIPUZKOA", "GIRONA",
		"GRANADA", "GUADALAJARA", "HUELVA", "HUESCA", "ILLES BALEARS", "JAEN", "LEON",
		"LLEIDA", "LUGO", "MADRID", "MALAGA", "MELILLA", "MURCIA", "NAVARRA", "OURENSE",
		"PALENCIA", "PALMAS, LAS", "PONTEVEDRA", "RIOJA, LA", "SALAMANCA", "SANTA CRUZ DE TENERIFE",
		"SEGOVIA", "SEVILLA", "SORIA", "TARRAGONA", "TERUEL", "TOLEDO", "VALENCIA",
		"VALLADOLID", "ZAMORA", "ZARAGOZA"
	};
	private String textoPubli = "Ejemplo de texto para una publicidad cualquiera. Ejemplo de texto para una publicidad cualquiera. Ejemplo de texto para una publicidad cualquiera. Ejemplo de texto para una publicidad cualquiera. Ejemplo de texto para una publicidad cualquiera.";
	
	// Constructor vacío.
    public IniciarBD() {
        
    }

    // Método destroy de la clase.
	public void destroy() {
		// Vacío.
	}

	// Método propio del filtro.
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		// No tiene contenido, sólo el método init.

		chain.doFilter(request, response);
	}

	// Método inicial del filtro. Sirve para cargar la "base de datos".
	public void init(FilterConfig fConfig) throws ServletException {
		
		// Iniciar lista de usuarios.
		List<Usuario> listaUsuarios = new ArrayList<Usuario>();
		Usuario vendedor = new Usuario("vendedor", "clave", "Juan", "Martinez Angulo", "Direccion de Juan", "Madrid", "MADRID", 28035, 913456789, "jma@server1.com", true, true, false, false);
		Usuario publicista = new Usuario("publicista", "clave", "Pepito", "Jimenez Sanchez", "Direccion de pepito", "Aniezo", "CANTABRIA", 39571, 656789123, "pepito@server2.com", false, false, true, false);
		Usuario administrador = new Usuario("administrador", "clave", "Ana", "Diaz Salazar", "Direccion de ana", "Cornoncillo", "PALENCIA", 34878, 914789632, "ana@server3.com", true, true, true, true);
		Usuario user = new Usuario("usuario", "clave", "Pepe Luis", "Gonzalez Maldonado", "Dirección de Pepe Luis", "Puertollano", "JAEN", 23685, 917539514, "pepe.luis@server.es", true, true, true, false);
		listaUsuarios.add(vendedor);
		listaUsuarios.add(publicista);
		listaUsuarios.add(administrador);
		listaUsuarios.add(user);
		fConfig.getServletContext().setAttribute("listaUsuarios", listaUsuarios);
		
		// Iniciar lista de tarifas.
		List<Tarifa> listaTarifas = new ArrayList<Tarifa>();
		float precio = 20;
		Tarifa tarifa1 = new Tarifa(1, 1, 1, precio);
		listaTarifas.add(tarifa1);
		precio = 16;
		Tarifa tarifa2 = new Tarifa(2, 2, 2, precio);
		listaTarifas.add(tarifa2);
		precio = 8;
		Tarifa tarifa3 = new Tarifa(3, 4, 3, precio);
		listaTarifas.add(tarifa3);
		fConfig.getServletContext().setAttribute("listaTarifas", listaTarifas);
		
		// Iniciar lista de motos.
		List<Vehiculo> listaMotos = new ArrayList<Vehiculo>();
		listaMotos.add(new Vehiculo("moto", "Yamaha", "modelo8", "C-4567-V", 12, 5000, 80000, "Amarillo", null, rutaFotos+"yamaha.jpg",vendedor, tarifa1, new Date()));
		listaMotos.add(new Vehiculo("moto", "Suzuki", "modelo9", "M-1234-J", 8, 6000, 150000, "rojo", "Buen estado", rutaFotos+"suzuki.jpg",user, tarifa2, new Date()));
		listaMotos.add(new Vehiculo("moto", "Honda", "modelo7", "B-7894-H", 4, 8000, 50000, "verde", "Como nueva", rutaFotos+"honda.jpg", vendedor, tarifa3, new Date()));
		fConfig.getServletContext().setAttribute("listaMotos", listaMotos);
		
		// Iniciar marcas de motos.
		List<String> marcasMotos = new ArrayList<String>();
		marcasMotos.add("Yamaha");
		marcasMotos.add("Suzuki");
		marcasMotos.add("Honda");
		marcasMotos.add("Gilera");
		fConfig.getServletContext().setAttribute("marcasMotos", marcasMotos);
		
		// Iniciar lista de coches.
		List<Vehiculo> listaCoches = new ArrayList<Vehiculo>();
		listaCoches.add(new Vehiculo("coche", "Renault", "Clio", "4042-CWK", 9, 4000, 156000, "azul", "Perfecto estado", rutaFotos+"clio.jpg", vendedor, tarifa3, new Date()));
		listaCoches.add(new Vehiculo("coche", "Citroen", "C4", "7894-DPF", 8, 8000, 126480, "rojo", "Ejemplo de descripcion muy larga que no se muestra entera en el listado normal", rutaFotos+"c4.jpg", user, tarifa1, new Date()));
		listaCoches.add(new Vehiculo("coche", "Audi", "A6", "M-4568-JK", 16, 10000, 256080, "Plata", "Catastrofico", rutaFotos+"a6.jpg", vendedor, tarifa2, new Date()));
		fConfig.getServletContext().setAttribute("listaCoches", listaCoches);
		
		// Iniciar marcas de coches.
		List<String> marcasCoches = new ArrayList<String>();
		marcasCoches.add("Renault");
		marcasCoches.add("Audi");
		marcasCoches.add("Citroen");
		marcasCoches.add("BMW");
		marcasCoches.add("Mercedes");
		fConfig.getServletContext().setAttribute("marcasCoches", marcasCoches);
		
		
		
		// Iniciar BD publicidad.
		List<Publicidad> listaPublicidad = new ArrayList<Publicidad>();
		String rutaAbsolutaPublicidad = fConfig.getServletContext().getRealPath(rutaPublicidad);
		File directorioPublicidad = new File(rutaAbsolutaPublicidad);
		String[] banners = directorioPublicidad.list();
		
		int i;
		Publicidad nuevaPublicidad = null;
		for(i=0;i<banners.length/2;i++){
			nuevaPublicidad = new Publicidad(rutaPublicidad+banners[i], textoPubli, publicista, tarifa1, new Date(), i);
			listaPublicidad.add(nuevaPublicidad);
		}
		for(i=banners.length/2;i<banners.length;i++){
			nuevaPublicidad = new Publicidad(rutaPublicidad+banners[i], textoPubli, user, tarifa2, new Date(), i);
			listaPublicidad.add(nuevaPublicidad);
		}
		fConfig.getServletContext().setAttribute("listaPublicidad", listaPublicidad);

		// Iniciar lista de provincias
		List<String> listaProvincias = new ArrayList<String>();
		for(i=0;i<this.provincias.length;i++){
			listaProvincias.add(this.provincias[i]);
		}
		fConfig.getServletContext().setAttribute("listaProvincias", listaProvincias);
	}
}
