/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dcn.ivanov;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Ki3iLL
 */
@Entity
@Table(name = "WORKERS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Worker.findAll", query = "SELECT w FROM Worker w")
    , @NamedQuery(name = "Worker.findById", query = "SELECT w FROM Worker w WHERE w.id = :id")
    , @NamedQuery(name = "Worker.findByFirstname", query = "SELECT w FROM Worker w WHERE w.firstname = :firstname")
    , @NamedQuery(name = "Worker.findByLastname", query = "SELECT w FROM Worker w WHERE w.lastname = :lastname")
    , @NamedQuery(name = "Worker.findByRole", query = "SELECT w FROM Worker w WHERE w.role = :role")
    , @NamedQuery(name = "Worker.findBySession", query = "SELECT w FROM Worker w WHERE w.session = :session")
    , @NamedQuery(name = "Worker.findByLogin", query = "SELECT w FROM Worker w WHERE w.login = :login")
    , @NamedQuery(name = "Worker.authorize", query = "SELECT w FROM Worker w WHERE w.login = :login AND w.password = :password")
    , @NamedQuery(name = "Worker.findByPassword", query = "SELECT w FROM Worker w WHERE w.password = :password")})
public class Worker implements Serializable {
    @Size(max = 30)
    @Column(name = "SESSION")
    private String session;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID")
    @GeneratedValue
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "FIRSTNAME")
    private String firstname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "LASTNAME")
    private String lastname;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ROLE")
    private int role;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "LOGIN")
    private String login;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "PASSWORD")
    private String password;
    
    public static final int MANAGER = 1;
    public static final int WORKER = 2;

    public Worker() {
    }

    public Worker(Integer id) {
        this.id = id;
    }

    public Worker(Integer id, String firstname, String lastname, int role, String login, String password) {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.role = role;
        this.login = login;
        this.password = password;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Worker)) {
            return false;
        }
        Worker other = (Worker) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "dcn.student.ivanov.Worker[ id=" + id + " ]";
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }
    
}
