package action;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDown {

	public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String filename = request.getParameter("file_name");

		String savePath = "boardUpload";
		ServletContext context = request.getSession().getServletContext();
		String sDownloadPath = context.getRealPath(savePath);
		String sFilePath = sDownloadPath + "\\" + filename;
		byte b[] = new byte[4096];
		
		FileInputStream in = new FileInputStream(sFilePath);
		String sMimeType = request.getSession().getServletContext().getMimeType(sFilePath);
		System.out.println("sMimeType>>>>" + sMimeType);
		
		if(sMimeType == null){
			sMimeType = "application/octet-stream";
		}
		response.setContentType(sMimeType);
		String agent = request.getHeader("User-Agent");
		boolean ieBrowser = (agent.indexOf("MSIE")>-1) || (agent.indexOf("Trident")>-1);
		
		if(ieBrowser){
			filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+","%20");
		}else{
			filename = new String(filename.getBytes("UTF-8"),"iso-8859-1");
		}
		response.setHeader("Content-Disposition", "attachment;filename="+filename);
		ServletOutputStream out2 = response.getOutputStream();
		int numRead;
		
		while((numRead = in.read(b, 0,b.length)) != -1){
			out2.write(b,0,numRead);
		}
		out2.flush();
		out2.close();
		in.close();
	}

}
