package MotorSales.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// Constructor por defecto del servlet.
    public Logout() {
        super();
    }

	// Método GET del servlet. Sencillamente, termina la sesión y redirige a la página de inicio.
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String origen = request.getParameter("origen");
		
		HttpSession sesion = request.getSession();
		sesion.invalidate();

		if(origen != null){
			this.getServletContext().getRequestDispatcher("/"+origen).forward(request, response);
		}
		else{
			this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
		}
	}

	// Método POST del servlet. Igual que el método GET.
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		sesion.invalidate();

		this.getServletContext().getRequestDispatcher("/default.jsp").forward(request, response);
	}

}
