package com.andreabazerla.dao;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.andreabazerla.model.user.User;

@Repository
public class UserDao implements IUserDao {

  @Autowired
  private SessionFactory sessionFactory;

  public void createUser(User user) {
    sessionFactory.getCurrentSession().saveOrUpdate(user);
  }

  @SuppressWarnings("unchecked")
  public List<User> readUsers() {
    return sessionFactory.getCurrentSession().createQuery("from User").list();
  }

  public User updateUser(User user) {
    sessionFactory.getCurrentSession().update(user);
    return user;
  }

  public void deleteUser(int id) {
    User user = (User) sessionFactory.getCurrentSession().load(User.class, id);
    if (null != user) {
      this.sessionFactory.getCurrentSession().delete(user);
    }
  }

  public User loadUser(String pattern) {

    Session currentSession = sessionFactory.getCurrentSession();

    User user = (User) currentSession.createCriteria(User.class)
        .add(Restrictions.eq("username", pattern)).uniqueResult();

    return user;
  }

  public User getUser(int id) {

    return (User) sessionFactory.getCurrentSession().get(User.class, id);
  }

}
