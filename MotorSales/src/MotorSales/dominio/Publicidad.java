package MotorSales.dominio;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Publicidad implements Serializable{

	private static final long serialVersionUID = -530227335462170639L;
	private String banner; // Ruta del fichero de imagen.
	private Usuario publicista; // Usuario publicista propietario de esta publicidad.
	private String textoAnuncio; // Texto del anuncio.
	private Tarifa tarifa;
	private Date fechaInsercion;
	private int id;
	private DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	private String fechaInsercionFormateada;
	private Date fechaFin;
	private String fechaFinFormateada;
	

	// Constructor vacío.
	public Publicidad(){
		
	}
	
	// Constructor que recibe todos los parámetros.
	public Publicidad(String banner, String textoAnuncio, Usuario publicista, Tarifa tarifa, Date fechaInsercion, int id){
		this.banner = banner;
		this.publicista = publicista;
		this.textoAnuncio = textoAnuncio;
		this.tarifa = tarifa;
		this.fechaInsercion = fechaInsercion;
		this.id = id;
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
	public String getBanner() {
		return banner;
	}
	public void setBanner(String banner) {
		this.banner = banner;
	}
	public Usuario getPublicista() {
		return publicista;
	}
	public void setPublicista(Usuario publicista) {
		this.publicista = publicista;
	}
	public String getTextoAnuncio() {
		return textoAnuncio;
	}
	public void setTextoAnuncio(String textoAnuncio) {
		this.textoAnuncio = textoAnuncio;
	}

	public Tarifa getTarifa() {
		return tarifa;
	}

	public void setTarifa(Tarifa tarifa) {
		this.tarifa = tarifa;
	}

	public Date getFechaInsercion() {
		return fechaInsercion;
	}

	public void setFechaInsercion(Date fechaInsercion) {
		this.fechaInsercion = fechaInsercion;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public DateFormat getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(DateFormat dateFormat) {
		this.dateFormat = dateFormat;
	}

	public String getFechaInsercionFormateada() {
		return fechaInsercionFormateada;
	}

	public void setFechaInsercionFormateada(String fechaInsercionFormateada) {
		this.fechaInsercionFormateada = fechaInsercionFormateada;
	}
	public void setFechaInsercionFormateada(Date fecha){
		this.fechaInsercionFormateada = this.dateFormat.format(fecha);
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
	
}
