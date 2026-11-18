package delhi.max;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
//http://localhost:2222/dist
@RestController
public class DistController {
	@Autowired
	LocationDAO locationDAO;
    @RequestMapping(value = "dist", method = RequestMethod.GET)
	public List<DistBean> getDistList(@RequestParam("sCode") String sCode)
	{
		System.out.println("in dist "+sCode);
		List<DistBean> dlsit = locationDAO.getDistListtt(sCode.length()==1?"0"+sCode:sCode);
		return dlsit;
	}
	
}
