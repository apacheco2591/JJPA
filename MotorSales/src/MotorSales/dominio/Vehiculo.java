package MotorSales.dominio;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Vehiculo implements Serializable{
	
	private static final long serialVersionUID = -428520483909172775L;
	
	// Datos del vehículo.
	private String tipo;
	private String marca;
	private String modelo;
	private String matricula;
	private int añosMatricula;
	private float precio;
	private int km;
	private String color;
	private String descripcion;
	private String foto;
	private Usuario usuario; // Propietario del vehículo.
	private Tarifa tarifa;
	private DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	private Date fechaInsercion;
	private String fechaInsercionFormateada;
	private Date fechaFin;
	private String fechaFinFormateada;
	
	// Constructor vacío.
	public Vehiculo(){
		
	}
	
	// Constructor con todos los parámetros.
	public Vehiculo(String tipo, String marca, String modelo, String matricula,
			int añosMatricula, float precio, int km, String color,
			String descripcion, String foto, Usuario usuario, Tarifa tarifa, Date fechaInsercion) {
		super();
		this.tipo = tipo;
		this.marca = marca;
		this.modelo = modelo;
		this.matricula = matricula;
		this.añosMatricula = añosMatricula;
		this.precio = precio;
		this.km = km;
		this.color = color;
		this.descripcion = descripcion;
		this.usuario = usuario;
		this.foto = foto;
		this.tarifa = tarifa;
		this.fechaInsercion = fechaInsercion;
		this.fechaInsercionFormateada = this.dateFormat.format(fechaInsercion);
		this.calcularFechaFin();
		this.fechaFinFormateada = this.dateFormat.format(this.fechaFin);
	}
	
	private void calcularFechaFin(){
		
		Calendar fechaFin = new GregorianCalendar();
		fechaFin.setTime(this.fechaInsercion);
		fechaFin.add(Calendar.MONTH, this.tarifa.getMeses());
		this.fechaFin = fechaFin.getTime();
	}

	// Getters y setters.
	public String getMatricula() {
		return matricula;
	}
	public void setMatricula(String matricula) {
		this.matricula = matricula;
	}
	public int getAñosMatricula() {
		return añosMatricula;
	}
	public void setAñosMatricula(int añosMatricula) {
		this.añosMatricula = añosMatricula;
	}
	public float getPrecio() {
		return precio;
	}
	public void setPrecio(float precio) {
		this.precio = precio;
	}
	public int getKm() {
		return km;
	}
	public void setKm(int km) {
		this.km = km;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getMarca() {
		return marca;
	}
	public void setMarca(String marca) {
		this.marca = marca;
	}
	public String getModelo() {
		return modelo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public String getFoto() {
		return foto;
	}
	public void setFoto(String foto) {
		this.foto = foto;
	}

	public Tarifa getTarifa() {
		return tarifa;
	}

	public void setTarifa(Tarifa tarifa) {
		this.tarifa = tarifa;
	}

	public String getFechaInsercionFormateada() {
		return fechaInsercionFormateada;
	}

	public DateFormat getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(DateFormat dateFormat) {
		this.dateFormat = dateFormat;
	}

	public Date getFechaInsercion() {
		return fechaInsercion;
	}

	public void setFechaInsercion(Date fechaInsercion) {
		this.fechaInsercion = fechaInsercion;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}

	public String getFechaFinFormateada() {
		return fechaFinFormateada;
	}

	public void setFechaFinFormateada(String fechaFinFormateada) {
		this.fechaFinFormateada = fechaFinFormateada;
	}

	public void setFechaInsercionFormateada(String fechaInsercionFormateada) {
		this.fechaInsercionFormateada = fechaInsercionFormateada;
	}
	
}
