package svc;

import java.sql.*;
import java.util.*;
import static db.JdbcUtil.*;
import dao.BoardDAO;
import vo.BoardBean;

public class BoardListService {
	public int getListCount() throws Exception {
		int listCount = 0;
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		listCount = boardDAO.selectListCount();
		close(con);
		return listCount;
	}
	
	public ArrayList<BoardBean> getArticleList(int page, int limit) throws Exception{
		ArrayList<BoardBean> articleList = null;
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		articleList = boardDAO.selectArticicleList(page, limit);
		close(con);
		return articleList;
	}

}
