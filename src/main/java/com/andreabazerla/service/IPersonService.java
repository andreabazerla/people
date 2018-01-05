package com.andreabazerla.service;

import java.util.ArrayList;

import com.andreabazerla.model.person.Person;

public interface IPersonService extends IGenericService<Person> {
	
	public Person get(String cf);
	public ArrayList<Person> load(String search);
	
}
