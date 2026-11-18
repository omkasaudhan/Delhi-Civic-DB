package delhi.max;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class LocationDAO {
	@Autowired
	StateInterface stateInterface;
	@Autowired
	DistInterface distInterface;
	@Autowired
	RegInterface regInterface;
	public List<StateBean> getStateList()
	{
		List<StateBean> list =(List<StateBean>) stateInterface.findAll();
		return list;
	}
	
	public List<DistBean> getDistListtt(String sCode)
	{
		List<DistBean> dlist = distInterface.getDistBeanListByStCode(sCode);
		return dlist;
	}

	
	public Iterable<RegDTO> getResDetail()
	{
		Iterable<RegDTO> list = regInterface.findAll();
		
		return list;
	}

	public List<DistBean> getAllDistricts()
	{
		return (List<DistBean>) distInterface.findAll();
	}
	
}
