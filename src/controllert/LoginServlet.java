package controllert;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.LoginService;
import vo.Member;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Cookie[] cookieArray = request.getCookies();
		String id = "";
		String passwd = "";
		
		if(cookieArray != null) {
			for(int i = 0; i< cookieArray.length;i++) {
				if(cookieArray[i].getName().equals("id")) {
					id = cookieArray[i].getValue();
				}
				else if(cookieArray[i].getName().equals("passwd")) {
					passwd = cookieArray[i].getValue();
				}
			}
			
			LoginService loginService = new LoginService();
			Member loginMember = loginService.getLoginMember(id, passwd);
			
			if(loginMember != null) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("loginSuccess.jsp");
				request.setAttribute("loginMember", loginMember);
				dispatcher.forward(request, response);
				
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("loginForm.jsp");
				dispatcher.forward(request, response);
			}
			
			
		}

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String useCookie = request.getParameter("useCookie");
		LoginService loginService = new LoginService();
		Member loginMember = loginService.getLoginMember(id, passwd);
		
		if(useCookie != null) {
			Cookie idCookie = new Cookie("id", id);
			idCookie.setMaxAge(60*60*24);
			Cookie passwdCookie = new Cookie("passwd", passwd);
			passwdCookie.setMaxAge(60*60*24);
			response.addCookie(idCookie);
			response.addCookie(passwdCookie);
		}
		
		if(loginMember != null) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("loginSuccess.jsp");
				request.setAttribute("loginMember", loginMember);
				dispatcher.forward(request, response);
				
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher("loginFail.jsp");
				dispatcher.forward(request, response);
			}
			
			
		}

	}


