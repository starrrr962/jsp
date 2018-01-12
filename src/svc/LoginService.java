package svc;

import static db.JdbcUtil.*;

import java.sql.*;

import dao.LoginDAD;
import vo.Member;

public class LoginService {
	public Member getLoginMember(String id, String passwd) {
		LoginDAD loginDAO = LoginDAD.getInstande();
		Connection con = getConnection();
		loginDAO.setConnection(con);
		Member loginMember = loginDAO.selectLoginMember(id, passwd);
		close(con);
		return loginMember;
	}

}
