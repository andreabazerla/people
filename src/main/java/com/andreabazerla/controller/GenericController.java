package com.andreabazerla.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.andreabazerla.model.person.Person;

@Controller
public class GenericController extends ParentController {
	
	@RequestMapping(value = "/Home", method = RequestMethod.GET)
	public ModelAndView home() throws IOException {
		ModelAndView modelAndView = new ModelAndView("personList");
		List<Person> people = personService.read();
		modelAndView.addObject("people", people);
		return modelAndView;
	}
	
	@RequestMapping(value = "/404", method = RequestMethod.GET)
	public ModelAndView errorPage() {

		ModelAndView modelAndView = new ModelAndView("404");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/401", method = RequestMethod.GET)
	public String error() {
		return "401";
	}

}
