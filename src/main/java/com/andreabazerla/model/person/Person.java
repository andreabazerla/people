package com.andreabazerla.model.person;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "person")
public class Person implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column
	private String cf;
	
	@Column
	private String name;
	
	@Column
	private String surname;
	
	public Person() {}

	public Person(String cf, String name, String surname) {
		this.cf = cf;
		this.name = name;
		this.surname = surname;
	}
	
	public Person(int id, String cf, String name, String surname) {
		this.id = id;
		this.cf = cf;
		this.name = name;
		this.surname = surname;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public String getCf() {
		return cf;
	}

	public void setCf(String cf) {
		this.cf = cf;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	@Override
	public String toString() {
		return "Person [id=" + id + ", cf=" + cf + ", name=" + name
				+ ", surname=" + surname + "]";
	}
	
}
