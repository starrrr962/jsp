package svc;

import static db.JdbcUtil.*;

import java.sql.Connection;
import dao.DogDAO;
import vo.Dog;

public class DogRegistService {
	
	public boolean  registDog(Dog dog) {
		// TODO Auto-generated constructor stub
	DogDAO dogDAO = DogDAO.getInstance();
	Connection con = getConnection();
	dogDAO.setConnection(con);
	boolean isRegistSucess = false;
	int insertCount = dogDAO.insertDog(dog);
	
	if(insertCount > 0) {
		commit(con);
		isRegistSucess = true;
	}else {
		rollback(con);
	}
	close(con);
	return isRegistSucess;
	}
}
