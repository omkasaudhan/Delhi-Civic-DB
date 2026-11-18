package delhi.max;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class RegController {
	@Autowired
	RegBean regBean;
	@Autowired
	RegInterface regInterface;
	@Autowired
	RegDTO regDTO;
 @RequestMapping(value = "regSave", method = RequestMethod.POST)
	public String savedetailll(@ModelAttribute("rr")RegBean regBean)
	{
	 BeanUtils.copyProperties(regBean, regDTO);
	 
	  RegDTO y = regInterface.save(regDTO);
	  if(y.getRid()>0)
		  return "S";
	  else
	  {
		  return "E";
	  }
	}
	
}
