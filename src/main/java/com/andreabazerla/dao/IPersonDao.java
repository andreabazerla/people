package com.andreabazerla.dao;

import java.util.List;

import com.andreabazerla.model.person.Person;

public interface IPersonDao extends IGenericDao<Person> {
	
	public void createPerson(Person Person);

	public List<Person> readPersons();

	public Person updatePerson(Person Person);

	public void deletePerson(int id);

	public Person loadPerson(String pattern);
	public List<Person> searchPerson(String pattern);
	
}
