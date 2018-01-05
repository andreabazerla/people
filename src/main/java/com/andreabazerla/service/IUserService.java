package com.andreabazerla.service;

import com.andreabazerla.model.user.User;

public interface IUserService extends IGenericService<User> {

	public User get(int id);	
	public User load(String pattern);
	
}
