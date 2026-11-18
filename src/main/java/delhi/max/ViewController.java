package delhi.max;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {
	@Autowired
	LocationDAO locationDAO;

	@RequestMapping(value = "viewjsp", method = RequestMethod.GET)
	public ModelAndView viewDetail() {
		Iterable<RegDTO> list = locationDAO.getResDetail();

		// Location maps for code -> name lookup
		Map<String, String> stateMap = new HashMap<>();
		List<StateBean> stateList = locationDAO.getStateList();
		if (stateList != null) {
			for (StateBean s : stateList) {
				stateMap.put(String.valueOf(s.getStCode()), s.getStName());
				if (s.getStCode() < 10) {
					stateMap.put("0" + s.getStCode(), s.getStName());
				}
			}
		}

		Map<String, String> distMap = new HashMap<>();
		List<DistBean> distList = locationDAO.getAllDistricts();
		if (distList != null) {
			for (DistBean d : distList) {
				distMap.put(d.getDistCode(), d.getDistName());
			}
		}

		// Calculate Analytics Metrics
		int totalResidents = 0;
		Set<String> uniqueStates = new HashSet<>();
		Set<String> uniqueDistricts = new HashSet<>();
		Map<String, Integer> stateCounts = new HashMap<>();

		if (list != null) {
			for (RegDTO r : list) {
				totalResidents++;
				if (r.getStCode() != null && !r.getStCode().trim().isEmpty()) {
					String sName = stateMap.getOrDefault(r.getStCode(), "State " + r.getStCode());
					uniqueStates.add(sName);
					stateCounts.put(sName, stateCounts.getOrDefault(sName, 0) + 1);
				}
				if (r.getDistCode() != null && !r.getDistCode().trim().isEmpty()) {
					String dName = distMap.getOrDefault(r.getDistCode(), "Dist " + r.getDistCode());
					uniqueDistricts.add(dName);
				}
			}
		}

		String topState = "None";
		int maxCount = 0;
		for (Map.Entry<String, Integer> entry : stateCounts.entrySet()) {
			if (entry.getValue() > maxCount) {
				maxCount = entry.getValue();
				topState = entry.getKey() + " (" + maxCount + ")";
			}
		}

		ModelAndView mv = new ModelAndView("view");
		mv.addObject("v", list);
		mv.addObject("stateMap", stateMap);
		mv.addObject("distMap", distMap);
		mv.addObject("totalResidents", totalResidents);
		mv.addObject("totalStates", uniqueStates.size());
		mv.addObject("totalDistricts", uniqueDistricts.size());
		mv.addObject("topState", topState);
		return mv;
	}

	@RequestMapping(value = "exportCsv", method = RequestMethod.GET)
	public void exportCsv(HttpServletResponse response) throws IOException {
		response.setContentType("text/csv; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=\"Delhi_Residents_Registry.csv\"");

		Map<String, String> stateMap = new HashMap<>();
		List<StateBean> stateList = locationDAO.getStateList();
		if (stateList != null) {
			for (StateBean s : stateList) {
				stateMap.put(String.valueOf(s.getStCode()), s.getStName());
				if (s.getStCode() < 10) {
					stateMap.put("0" + s.getStCode(), s.getStName());
				}
			}
		}

		Map<String, String> distMap = new HashMap<>();
		List<DistBean> distList = locationDAO.getAllDistricts();
		if (distList != null) {
			for (DistBean d : distList) {
				distMap.put(d.getDistCode(), d.getDistName());
			}
		}

		Iterable<RegDTO> list = locationDAO.getResDetail();

		PrintWriter writer = response.getWriter();
		writer.println("RID,State Code,State Name,District Code,District Name,Full Name,Phone Number");

		if (list != null) {
			for (RegDTO r : list) {
				String sName = stateMap.getOrDefault(r.getStCode(), r.getStCode());
				String dName = distMap.getOrDefault(r.getDistCode(), r.getDistCode());
				writer.println(String.format("%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"",
					r.getRid(),
					r.getStCode() != null ? r.getStCode() : "",
					sName != null ? sName.replace("\"", "\"\"") : "",
					r.getDistCode() != null ? r.getDistCode() : "",
					dName != null ? dName.replace("\"", "\"\"") : "",
					r.getName() != null ? r.getName().replace("\"", "\"\"") : "",
					r.getPhone() != null ? r.getPhone() : ""
				));
			}
		}
		writer.flush();
	}
}
