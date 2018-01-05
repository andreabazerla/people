package com.andreabazerla.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.andreabazerla.dao.PersonDao;
import com.andreabazerla.model.person.Person;

@Service
@Transactional
public class PersonService implements IPersonService {

	@Autowired
	private PersonDao personDao;
	
	public void create(Person person) throws SQLException {
		personDao.createPerson(person);
	}

	public List<Person> read() {
		return personDao.readPersons();
	}
	
	public Person get(String cf) {
		return personDao.loadPerson(cf);
	}
	
	public ArrayList<Person> load(String search) {
		return (ArrayList<Person>) personDao.searchPerson(search);
	}
	
	public void delete(int id) {
		personDao.deletePerson(id);
	}

	public void update(Person person) {
		personDao.updatePerson(person);
	}
}
