package org.example.demo11111.respository;

import org.example.demo11111.entity.Ban;
import org.example.demo11111.entity.MoiQuanHe;
import org.example.demo11111.service.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.sql.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

public class banRespository {
    public List<Ban> getAll() {
        Session session = HibernateUtil.getSession();
        Query<Ban> query = session.createQuery("select p from Ban p", Ban.class);
        return query.getResultList();
    }

    public List<MoiQuanHe> getAllMQH() {
        Session session = HibernateUtil.getSession();
        Query<MoiQuanHe> query = session.createQuery("select p from MoiQuanHe p", MoiQuanHe.class);
        return query.getResultList();
    }

    public Ban getOne(Integer id) {
        Session session = HibernateUtil.getSession();
        Query<Ban> query = session.createQuery("select p from Ban p where p.id = :id", Ban.class);
        query.setParameter("id", id);
        return query.getSingleResult();
    }

    public void add(Ban ban) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        session.save(ban);
        transaction.commit();
    }

    public List<Ban> searchBan(String key) {
        return getAll().stream().filter(b ->
                b.getTen().toLowerCase(Locale.ROOT).contains(key)
                        || b.getMa().contains(key)
                        || b.getGioiTinh().toString().contains(key)
                        || b.getSoThich().contains(key)
        ).collect(Collectors.toList());
    }

    public void delete(Ban ban) {
        Session session = HibernateUtil.getSession();
        Transaction transaction = session.beginTransaction();
        session.delete(ban);
        transaction.commit();
    }
}
