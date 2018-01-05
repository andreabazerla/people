package com.andreabazerla.service;

import java.sql.SQLException;
import java.util.List;

public interface IGenericService<T> {
	
	public void create(T t) throws SQLException;
	
	public List<T> read();
	
	public void update(T t) throws SQLException;
	
	public void delete(int id);


}
