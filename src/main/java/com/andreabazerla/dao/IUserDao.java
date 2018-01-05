package com.andreabazerla.dao;

import java.util.List;

import com.andreabazerla.model.user.User;

public interface IUserDao extends IGenericDao<User> {
	
	public void createUser(User user);

	public List<User> readUsers();

	public User updateUser(User user);

	public void deleteUser(int id);

	public User loadUser(String pattern);
	
}
