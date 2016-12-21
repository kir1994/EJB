/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dcn.ivanov;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.security.SecureRandom;
import java.math.BigInteger;

/**
 *
 * @author Ki3iLL
 */
@Stateless
public class WorkplaceSessionBean implements WorkplaceSessionBeanRemote, WorkplaceSessionBeanLocal {
    private final SecureRandom random = new SecureRandom();

    @PersistenceContext(unitName = "DistributedWorkers-ejbPU")
    private EntityManager em;
    @Override
    public void createTask(String Description) {
        Task t = new Task();
        t.setDescription(Description);
        em.persist(t);
    }

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    
    @Override
    public void finishTask(int taskID) {
        Query query = em.createNamedQuery("Task.findById");
        query.setParameter("id", taskID);
        Task t = (Task)query.getResultList().get(0);
        t.setFinished(Boolean.TRUE);
        em.merge(t);        
    }

    public void persist(Object object) {
        em.persist(object);
    }

    @Override
    public List<Object> getTasksByWorkerID(int workerID) {
        Query query = em.createNamedQuery("Task.findByWorkerid");
        query.setParameter("workerid", workerID);
        return query.getResultList();
    }

    @Override
    public String authorize(String login, String password) throws ConnectionException {
        Query query = em.createNamedQuery("Worker.authorize");
        query.setParameter("login", login);
        query.setParameter("password", password);
        List lst = query.getResultList();
        if (lst.isEmpty())
            throw new ConnectionException("Incorrect login/password");
        
        Worker w = (Worker)lst.get(0);
        String session = new BigInteger(130, random).toString(32);
        session = session.substring(0, Math.min(30, session.length() - 1));
        w.setSession(session);
        em.persist(w);
        return session;
    }
    @Override
    public List getWorkers() {
        Query query = em.createNamedQuery("Worker.findAll");
        return query.getResultList();      
    }

    @Override
    public void assignTask(int taskID, int workerID, int priority) {
        Query query = em.createNamedQuery("Task.findById");
        query.setParameter("id", taskID);
        Task t = (Task)query.getResultList().get(0);
        t.setWorkerid(workerID);
        t.setPriority(priority);
        em.merge(t);
    }

    @Override
    public void unassignTask(int taskID) {
        Query query = em.createNamedQuery("Task.findById");
        query.setParameter("id", taskID);
        Task t = (Task)query.getResultList().get(0);
        t.setWorkerid(-1);
        em.merge(t);        
    }

    @Override
    public void removeTask(int taskID) {
        Query query = em.createNamedQuery("Task.findById");
        query.setParameter("id", taskID);
        Task t = (Task)query.getResultList().get(0);
        em.remove(t);
    }

    @Override
    public Object getAccount(String session) throws ConnectionException {
        Query query = em.createNamedQuery("Worker.findBySession");
        query.setParameter("session", session);
        List lst = query.getResultList();
        if (lst.isEmpty())
            throw new ConnectionException("Incorrect session");
        Worker w = (Worker)lst.get(0);        
        return w;        
    }

    @Override
    public void closeSession(String session) {
        Query query = em.createNamedQuery("Worker.findBySession");
        query.setParameter("session", session);
        List lst = query.getResultList();
        if (!lst.isEmpty()) {
            Worker w = (Worker)lst.get(0);        
            w.setSession(null);
            em.persist(w);
        }
    }
}
