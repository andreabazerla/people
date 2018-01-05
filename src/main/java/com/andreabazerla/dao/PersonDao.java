package com.andreabazerla.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.andreabazerla.model.person.Person;

@Repository
public class PersonDao implements IPersonDao {

	@Autowired
	private SessionFactory sessionFactory;

	public void createPerson(Person person) {
		sessionFactory.getCurrentSession().saveOrUpdate(person);
	}

	@SuppressWarnings("unchecked")
	public List<Person> readPersons() {
		return sessionFactory.getCurrentSession().createQuery("from Person").list();
	}

	public List<Person> searchPerson(String search) {
		Session currentSession = sessionFactory.getCurrentSession();

		@SuppressWarnings("unchecked")
		List<Person> personList = currentSession.createCriteria(Person.class)
			.add(Restrictions.disjunction()
				.add(Restrictions.ilike("cf", search, MatchMode.ANYWHERE))
				.add(Restrictions.ilike("name", search, MatchMode.ANYWHERE))
				.add(Restrictions.ilike("surname", search, MatchMode.ANYWHERE)))
				
					.list();

		return personList;
	}

	public void deletePerson(int id) {
		Person person = (Person) sessionFactory.getCurrentSession().load(Person.class, id);
		if (null != person) {
			this.sessionFactory.getCurrentSession().delete(person);
		}
	}

	public Person updatePerson(Person person) {
		sessionFactory.getCurrentSession().update(person);
		return person;
	}

	public Person loadPerson(String cf) {

		Session currentSession = sessionFactory.getCurrentSession();

		Person person = (Person) currentSession.createCriteria(Person.class).add(Restrictions.eq("cf", cf))
				.uniqueResult();

		return person;
	}

}