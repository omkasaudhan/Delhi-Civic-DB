package delhi.max;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class A {
	@Autowired
	LoginBean loginBean;
	@Autowired
	RegBean regBean;
	@Autowired
	LocationDAO locationDAO;
	@Autowired
	LoginInterface loginInterface;
@RequestMapping(value  = "lgn", method = RequestMethod.GET)
	public ModelAndView  login()
	{
		String d="raja is good";
		return new ModelAndView("login","lg",loginBean);
	}
	
@RequestMapping(value = "loginUser", method = RequestMethod.POST)
public ModelAndView getDetail(@ModelAttribute("lg")LoginBean loginBean)
{
	if(loginBean == null || loginBean.getUid() == null || loginBean.getPass() == null)
	{
		return new ModelAndView("E");
	}

	LoginDTO dbbean = loginInterface.getLoginDTOByUid(loginBean.getUid().trim());
	
	if(dbbean != null && dbbean.getPass() != null && loginBean.getPass().equalsIgnoreCase(dbbean.getPass().trim()))
	{
		return new ModelAndView("reg","rr",regBean);
	}
	else
	{
		return new ModelAndView("E");
	}
}

@RequestMapping(value = "loginUser", method = RequestMethod.GET)
public String loginUserGet()
{
	return "redirect:/lgn";
}
@ModelAttribute("modiji")
public List<StateBean> getState()
{
	List<StateBean> list = locationDAO.getStateList();
	System.out.println("statteee "+list.size());
	return list;
}

}
