package dcn.ivanov;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.0.v20130507-rNA", date="2016-12-16T14:32:21")
@StaticMetamodel(Task.class)
public class Task_ { 

    public static volatile SingularAttribute<Task, Integer> workerid;
    public static volatile SingularAttribute<Task, String> description;
    public static volatile SingularAttribute<Task, Boolean> finished;
    public static volatile SingularAttribute<Task, Integer> id;
    public static volatile SingularAttribute<Task, Integer> priority;

}