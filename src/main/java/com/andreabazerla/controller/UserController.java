package com.andreabazerla.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.andreabazerla.exception.PeopleException;
import com.andreabazerla.model.user.User;
import com.andreabazerla.util.EmailValidator;

@Controller
public class UserController extends ParentController {
  
  /**
   * Redirect to profile.jsp
   * 
   * @param model
   * @return
   */
  @RequestMapping(value = "/Profile", method = RequestMethod.GET)
  public String profile(ModelAndView model) {
    return "profile";
  }

  @RequestMapping(value = "/Users", method = {RequestMethod.GET, RequestMethod.POST})
  public ModelAndView userListPOST() {

    ArrayList<User> users = new ArrayList<User>();

    users = (ArrayList<User>) userService.read();

    ModelAndView modelAndView = new ModelAndView("userList");
    modelAndView.addObject("users", users);

    return modelAndView;
  }

  @RequestMapping(value = "/EditUser", method = RequestMethod.POST)
  public ModelAndView editUser(HttpServletRequest request) {
    request.setAttribute("action", "EDIT_USER");
    int id = Integer.parseInt(request.getParameter("idUser"));

    User otherUser = null;
    otherUser = userService.get(id);
    if (otherUser == null)
      throw new PeopleException("Utente non trovato, ID = " + id);

    request.setAttribute("currentUser", otherUser);
    ModelAndView modelAndView = new ModelAndView("signup");
    modelAndView.addObject("currentUser", otherUser);
    modelAndView.addObject("action", "EDIT_USER");

    return modelAndView;
  }

  @RequestMapping(value = "/DeleteUser", method = RequestMethod.POST)
  public void deleteUser(HttpServletRequest request, HttpServletResponse response)
      throws IOException {
    int id = Integer.parseInt(request.getParameter("id"));
    userService.delete(id);
  }

  @RequestMapping(value = "/EditAdmin", method = RequestMethod.POST)
  public ModelAndView editAdmin(HttpServletRequest request) {
    HttpSession httpSession = request.getSession();
    User user = (User) httpSession.getAttribute("currentUser");

    ModelAndView modelAndView = new ModelAndView("signup");
    modelAndView.addObject("currentUser", user);
    modelAndView.addObject("action", "EDIT_ADMIN");

    return modelAndView;
  }

  @RequestMapping(value = "/UpdateProfile", method = RequestMethod.POST)
  public String updateProfile(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

    String button = null;
    String action = request.getParameter("action");
    HttpSession httpSession = request.getSession();

    if (action == null) {
      button = (String) httpSession.getAttribute("button");
    } else {
      button = request.getParameter("button");
      httpSession.setAttribute("button", button);
    }

    User user = (User) httpSession.getAttribute("currentUser");

    String feedback = null;
    PrintWriter printWriter = response.getWriter();

    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String surname = request.getParameter("surname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmation = request.getParameter("confirmation");
    String email = request.getParameter("email");
    String birthday = request.getParameter("birthday");
    String sex = request.getParameter("sex");
    String region = request.getParameter("region");
    button = request.getParameter("button");
    String role = null;

    if (button.equals("Update")) {
      role = user.getRole();
    } else if (button.equals("Manage")) {
      role = request.getParameter("role");
    }

    if (role == null)
      role = "USER";
    if (role.equals("on"))
      role = "ADMIN";

    if (!ifNull(name) && !ifNull(surname) && !ifNull(username) && !ifNull(password)
        && !ifNull(confirmation) && !ifNull(email) && !ifNull(region) && !ifNull(birthday)
        && (button.equals("Update") || button.equals("Manage"))) {

      User tempUser = userService.load(username);

      if (tempUser == null || (!username.equals(user.getUsername()) && (button.equals("Update")))) {
        feedback =
            "{ \"type\": \"0\", \"field\": \"username\", \"message\": \"Users not equals\" }";
      } else {
        if (!password.equals(confirmation)) {
          feedback =
              "{ \"type\": \"0\", \"field\": \"confirmation\", \"message\": \"Passwords not equals\" }";
        } else if (!EmailValidator.validate(email)) {
          feedback = "{ \"type\": \"0\", \"field\": \"email\", \"message\": \"Email not valid\" }";
        } else {
          feedback = "{ \"type\": \"1\", \"message\": \"Ok user updated\" }";

          user =
              new User(id, name, surname, username, password, email, birthday, sex, region, role);
          userService.update(user);

          if (button.equals("Update")) {
            request.getSession().setAttribute("currentUser", user);
          } else if (button.equals("Manage")) {
            request.setAttribute("action", "USER_UPDATED");
          }
        }
      }
    } else {
      if (ifNull(birthday)) {
        feedback = "{ \"type\": \"0\", \"field\": \"birthday\", \"message\": \"Empty field\" }";
      } else {
        request.setAttribute("error", "Empty field");
      }
    }

    response.setContentType("application/json;charset=utf-8");
    printWriter.print(feedback);
    printWriter.flush();
    printWriter.close();
    return null;
  }

}
