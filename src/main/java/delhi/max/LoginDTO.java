package delhi.max;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.springframework.stereotype.Component;

@Component
@Entity(name = "mst_user")

public class LoginDTO {
  @Id
  @Column(name = "uid")
	String uid;
  @Column(name = "pass")
	String pass;
public String getUid() {
	return uid;
}
public void setUid(String uid) {
	this.uid = uid;
}
public String getPass() {
	return pass;
}
public void setPass(String pass) {
	this.pass = pass;
}
  
  
}
