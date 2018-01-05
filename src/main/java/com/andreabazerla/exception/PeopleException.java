package com.andreabazerla.exception;

public class PeopleException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	public PeopleException(String message) {
		super(message);
	}
	
	public PeopleException(Throwable t) {
		super(t);
	}

}
