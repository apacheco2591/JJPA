package MotorSales.dominio;

import java.io.Serializable;

public class Tarifa implements Serializable{

	private static final long serialVersionUID = 1L;

	private int id, meses, minMeses;
	private float precio;
	
	// Constructor por defecto (vacío).
	public Tarifa(){
		
	}
	
	// Constructor de la clase.
	public Tarifa(int id, int meses, int minMeses, float precio){
		this.id = id;
		this.meses = meses;
		this.minMeses = minMeses;
		this.precio = precio;
	}

	// Getters y setters.
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMeses() {
		return meses;
	}

	public void setMeses(int meses) {
		this.meses = meses;
	}

	public int getMinMeses() {
		return minMeses;
	}

	public void setMinMeses(int minMeses) {
		this.minMeses = minMeses;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

}
