package com.andreabazerla.controller;

import org.springframework.beans.factory.annotation.Autowired;
import com.andreabazerla.service.PersonService;
import com.andreabazerla.service.UserService;

public class ParentController {

  @Autowired
  protected PersonService personService;

  @Autowired
  protected UserService userService;

  /**
   * Data string checker Used to store person
   * 
   * @param cf
   * @param name
   * @param surname
   * @return
   */
  protected boolean checkData(String cf, String name, String surname) {
    return (cf != null && !cf.isEmpty() && cf.trim().length() > 0)
        && (name != null && !name.isEmpty() && name.trim().length() > 0)
        && (surname != null && !surname.isEmpty() && surname.trim().length() > 0);
  }

  /**
   * String null checker
   * 
   * @param string
   * @return
   */
  public boolean ifNull(String string) {
    if (string != null && !string.isEmpty() && string.trim().length() > 0) {
      return false;
    } else {
      return true;
    }
  }
}
