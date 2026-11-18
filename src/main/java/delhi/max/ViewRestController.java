package delhi.max;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ViewRestController {
	@Autowired
	LocationDAO locationDAO;
	@RequestMapping(value = "viewRest", method = RequestMethod.GET)
	public Iterable<RegDTO> viewRestApiDetail()
	{
		Iterable<RegDTO> list = locationDAO.getResDetail();
		
		return list;
	}
}
