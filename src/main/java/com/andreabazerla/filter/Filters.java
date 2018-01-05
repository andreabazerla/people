package com.andreabazerla.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Filters implements Filter {

  public void init(FilterConfig arg0) throws ServletException {}

  static String[] pagesNotLogged = {"/Login", "/Logout", "/404", "/jsp/partials/navbar.jsp",
      "/Signup", "/CheckUsername", "/CheckBirthday", "/401", "/", "/css/style.css", "/UploadImage" };

  static String[] pagesLogged =
      {"/Home", "/Profile", "/DeletePerson", "/StorePerson", "/SearchPerson", "/Users",
          "/EditAdmin", "/EditUser", "/UpdateProfile", "/DeleteUser", "/css/style.css"};

  final static List<String> ALL_PAGES = new ArrayList<String>();

  static {
    ALL_PAGES.addAll(Arrays.asList(pagesLogged));
    ALL_PAGES.addAll(Arrays.asList(pagesNotLogged));
  }

  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
      throws IOException, ServletException {

    HttpServletRequest request = (HttpServletRequest) req;
    HttpServletResponse response = (HttpServletResponse) res;

    String appName = request.getContextPath();
    String servletPath = request.getServletPath();
    HttpSession session = request.getSession(false);

    if (servletPath.endsWith(".js") || servletPath.endsWith(".css") || servletPath.endsWith(".html")
        || servletPath.endsWith(".jpg")) {
      chain.doFilter(request, response);
      return;
    } else {
      if (Arrays.asList(pagesNotLogged).contains(servletPath)) {
        if (session != null && session.getAttribute("currentUser") != null
            && servletPath.equals("/")) {
          response.sendRedirect(appName + "/Home");
        } else if (servletPath.equals("/")) {
          response.sendRedirect(appName + "/Login");
        } else {
          chain.doFilter(request, response);
        }
        return;
      } else if (Arrays.asList(pagesLogged).contains(servletPath)) {
        if (session != null && session.getAttribute("currentUser") != null) {
          chain.doFilter(request, response);
          return;
        } else {
          response.sendRedirect(appName + "/Login");
          // response.sendRedirect(appName + "/401");
        }
      } else {
        response.sendError(404);
        return;
      }

    }

  }

  public void destroy() {}
}
