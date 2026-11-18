package delhi.max;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewController {
	@Autowired
	LocationDAO locationDAO;

	@RequestMapping(value = "viewjsp", method = RequestMethod.GET)
	public ModelAndView viewDetail(@RequestParam(value = "deleted", required = false) String deleted) {
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

		// Calculate Analytics Metrics & Demographic Breakdown
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

		// Build State Distribution data structure for charts / breakdown bars
		List<Map<String, Object>> stateBreakdown = new ArrayList<>();
		String[] barColors = new String[] { "#1a73e8", "#1e8e3e", "#f29900", "#9334e6", "#e8710a", "#12b5cb" };
		int colorIdx = 0;
		for (Map.Entry<String, Integer> entry : stateCounts.entrySet()) {
			Map<String, Object> item = new HashMap<>();
			item.put("stateName", entry.getKey());
			item.put("count", entry.getValue());
			double pct = totalResidents > 0 ? (entry.getValue() * 100.0 / totalResidents) : 0;
			item.put("percentage", Math.round(pct * 10.0) / 10.0);
			item.put("color", barColors[colorIdx % barColors.length]);
			colorIdx++;
			stateBreakdown.add(item);
		}

		ModelAndView mv = new ModelAndView("view");
		mv.addObject("v", list);
		mv.addObject("stateMap", stateMap);
		mv.addObject("distMap", distMap);
		mv.addObject("stateList", stateList);
		mv.addObject("distList", distList);
		mv.addObject("stateBreakdown", stateBreakdown);
		mv.addObject("totalResidents", totalResidents);
		mv.addObject("totalStates", uniqueStates.size());
		mv.addObject("totalDistricts", uniqueDistricts.size());
		mv.addObject("topState", topState);
		if ("true".equalsIgnoreCase(deleted)) {
			mv.addObject("deletedAlert", "Record has been successfully removed from the civic database.");
		}
		return mv;
	}

	@RequestMapping(value = "deleteResident", method = RequestMethod.GET)
	public String deleteResident(@RequestParam("rid") int rid) {
		locationDAO.deleteResident(rid);
		return "redirect:/viewjsp?deleted=true";
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
