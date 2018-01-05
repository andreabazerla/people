package com.andreabazerla.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailValidator {

	/**
	 * Regex pattern for e-mails
	 */
	public static final Pattern VALID_EMAIL_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
			Pattern.CASE_INSENSITIVE);

	/**
	 * Function to validate e-mail
	 * 
	 * @param email
	 * @return
	 */
	public static boolean validate(String email) {
		Matcher matcher = VALID_EMAIL_REGEX.matcher(email);
		return matcher.find();
	}
}
