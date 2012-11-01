package MotorSales.dominio;

import java.io.Serializable;

public class Usuario implements Serializable{

	private static final long serialVersionUID = 2574500809711471437L;
	
	// Datos del usuario.
	private String nombreUsuario;
	private String contraseña;
	private String nombre;
	private String apellidos;
	private String direccion;
	private String poblacion;
	private String provincia;
	private int CP;
	private String email;
	private int telefono;
	
	// Permisos del usuario.
	private boolean comprador;
	private boolean vendedor;
	private boolean publicista;
	private boolean administrador;
	
	// Constructor vacío.
	public Usuario(){
		
	}
	
	// Constructor con todos los parámetros.
	public Usuario(String nombreUsuario, String contraseña, String nombre, String apellidos, String direccion,
			String poblacion, String provincia, int CP,int telefono, String email,   
			boolean comprador, boolean vendedor, boolean publicista, boolean administrador) {
		super();
		this.nombreUsuario = nombreUsuario;
		this.contraseña = contraseña;
		this.nombre = nombre;
		this.apellidos = apellidos;
		this.direccion = direccion;
		this.poblacion = poblacion;
		this.provincia = provincia;
		this.CP = CP;
		this.telefono = telefono;
		this.email = email;
		this.comprador = comprador;
		this.vendedor = vendedor;
		this.publicista = publicista;
		this.administrador = administrador;
	}

	// Getters y setters.
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getContraseña() {
		return contraseña;
	}
	public void setContraseña(String contraseña) {
		this.contraseña = contraseña;
	}
	public boolean isVendedor() {
		return vendedor;
	}
	public void setVendedor(boolean vendedor) {
		this.vendedor = vendedor;
	}
	public boolean isPublicista() {
		return publicista;
	}
	public void setPublicista(boolean publicista) {
		this.publicista = publicista;
	}
	public boolean isAdministrador() {
		return administrador;
	}
	public void setAdministrador(boolean administrador) {
		this.administrador = administrador;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public String getPoblacion() {
		return poblacion;
	}

	public void setPoblacion(String poblacion) {
		this.poblacion = poblacion;
	}

	public int getCP() {
		return CP;
	}

	public void setCP(int cP) {
		CP = cP;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public boolean isComprador() {
		return comprador;
	}

	public void setComprador(boolean comprador) {
		this.comprador = comprador;
	}
	
}
