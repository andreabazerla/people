package com.andreabazerla.model.user;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "users")
public class User implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int id;

  @Column
  private String name;

  @Column
  private String surname;

  @Column
  private String username;

  @Column
  private String password;

  @Column
  private String email;

  @Column
  private String birthday;

  @Column
  private String sex;

  @Column
  private String region;

  @Column
  private String role;

  public User() {}

  public User(int id, String name, String surname, String username, String password, String email,
      String birthday, String sex, String region, String role) {
    this.setId(id);
    this.name = name;
    this.surname = surname;
    this.username = username;
    this.password = password;
    this.email = email;
    this.birthday = birthday;
    this.sex = sex;
    this.region = region;
    this.role = role;
  }

  public static User make(ResultSet resultSet) throws SQLException {

    int id = Integer.parseInt(resultSet.getString("id"));
    String name = resultSet.getString("name");
    String surname = resultSet.getString("surname");
    String username = resultSet.getString("username");
    String password = resultSet.getString("password");
    String email = resultSet.getString("email");
    String birthday = resultSet.getString("birthday");
    String sex = resultSet.getString("sex");
    String region = resultSet.getString("region");
    String role = resultSet.getString("role");

    return new User(id, name, surname, username, password, email, birthday, sex, region, role);
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getId() {
    return id;
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

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getBirthday() {
    return birthday;
  }

  public void setBirthday(String birthday) {
    this.birthday = birthday;
  }

  public String getSex() {
    return sex;
  }

  public void setSex(String sex) {
    this.sex = sex;
  }

  public String getRegion() {
    return region;
  }

  public void setRegion(String region) {
    this.region = region;
  }

  public String getRole() {
    return role;
  }

  public void setRole(String role) {
    this.role = role;
  }

  @Override
  public String toString() {
    return "User [name=" + name + ", surname=" + surname + ", username=" + username + ", password="
        + password + ", email=" + email + ", birthday=" + birthday + ", sex=" + sex + ", region="
        + region + ", role=" + role + "]";
  }
}
