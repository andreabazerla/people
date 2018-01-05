package com.andreabazerla.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.andreabazerla.model.person.Person;

@Controller
public class PersonController extends ParentController {

	/**
	 * Store and Update a Person
	 * 
	 * @param request
	 * @param response
	 * @throws SQLException
	 * @throws IOException
	 */
	@RequestMapping(value = "/StorePerson", method = RequestMethod.POST)
	public void storePerson(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

		PrintWriter printWriter = response.getWriter();

		String idString = request.getParameter("id");
		int id = 0;
		if (idString != null) {
			id = Integer.parseInt(idString);
		}

		String cf = request.getParameter("cf");
		String name = request.getParameter("name");
		String surname = request.getParameter("surname");

		Person tempPerson = null;
		Person person = null;
		String feedback = null;

		if (checkData(cf, name, surname)) {

			if (id == 0) {

				tempPerson = personService.get(cf);

				if (tempPerson == null) {
					person = new Person(cf, name, surname);
					personService.create(person);
					feedback = "{ \"type\": \"0\", \"header\": \"Success! \", \"message\": \"Ok, user created\" }";

				} else {
					feedback = "{ \"type\": \"1\", \"header\": \"Error! \", \"message\": \"User already exist\" }";
				}

			} else {

				person = new Person(id, cf, name, surname);

				personService.update(person);
				feedback = "{ \"type\": \"0\", \"header\": \"Success! \", \"message\": \"Ok, user updated\" }";

			}

		} else {
			feedback = "{ \"type\": \"1\", \"header\": \"Error! \", \"message\": \"Empty fields\" }";
		}

		response.setContentType("application/json;charset=utf-8");
		printWriter.print(feedback);
		printWriter.flush();
		printWriter.close();
	}

	/**
	 * Delete a Person
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/DeletePerson", method = RequestMethod.POST)
	public ModelAndView deletePerson(HttpServletRequest request) {
		int personId = Integer.parseInt(request.getParameter("id"));
		personService.delete(personId);
		return new ModelAndView("redirect:/");
	}
	
	/**
	 * Search a Person
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/SearchPerson", method = RequestMethod.POST)
	public ModelAndView searchPerson(HttpServletRequest request) {
  		
		String search = "";
		
		ArrayList<Person> personList = new ArrayList<Person>();			

		search = request.getParameter("search");
		request.setAttribute("search", search);
		
		personList = (ArrayList<Person>) personService.load(search);
		
		request.setAttribute("people", personList);
		
		ModelAndView modelAndView = new ModelAndView("personList");
		modelAndView.addObject("people", personList);
		
		return modelAndView;
	}
	
}
