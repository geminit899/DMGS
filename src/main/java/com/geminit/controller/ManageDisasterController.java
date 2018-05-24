package com.geminit.controller;

import com.geminit.dao.CityDao;
import com.geminit.dao.EarthquakeDao;
import com.geminit.dao.TaifengDao;
import com.geminit.entity.City;
import com.geminit.entity.Earthquake;
import com.geminit.entity.Taifeng;
import com.geminit.entity.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Controller
public class ManageDisasterController {

    //添加一个日志器
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    CityDao cityDao;

    @Autowired
    TaifengDao taifengDao;

    @Autowired
    EarthquakeDao earthquakeDao;

    //映射一个action
    @RequestMapping("/manageDisaster")
    public String manageDisaster(Model model, HttpServletRequest request) {

        if ( request.getParameter("prefix") == null )
            return null;

        String prefix = request.getParameter("prefix");

        int currentPage = 1;
        int pageNum = 1;

        if ( request.getParameter("page") != null )
            currentPage = Integer.parseInt( request.getParameter("page") );

        if ( prefix.equals("temperature") || prefix.equals("pm2_5") ){
            List<City> cities = cityDao.getCities();
            List<String> name = new ArrayList<>();
            List<String> value = new ArrayList<>();

            for ( int i = 0; i < cities.size(); i++ ) {
                name.add(cities.get(i).getName());
                if ( prefix.equals("temperature") )
                    value.add(cities.get(i).getTemperature());
                else if ( prefix.equals("pm2_5") )
                    value.add(cities.get(i).getPm2_5());
            }

            model.addAttribute("name", name);
            model.addAttribute("value", value);
        } else if ( prefix.equals("taifeng") ) {
            List<String> taifengNames = taifengDao.getTaifengName();
            pageNum = taifengNames.size();

            int i = currentPage - 1;

            List<Taifeng> thisTaifeng = taifengDao.getTaifengByName(taifengNames.get(i));

            model.addAttribute("objList", thisTaifeng);
        } else if ( prefix.equals("earthquake") ) {
            List<Earthquake> earthquakes =  earthquakeDao.getEarthquakeInfo( (currentPage-1)*10, 10 );
            int totalNum = earthquakeDao.getEarthquakeNum();

            if( totalNum%10 == 0 )
                pageNum = totalNum/10;
            else
                pageNum = totalNum/10 + 1;

            model.addAttribute("objList", earthquakes);
        }

        Subject subject = SecurityUtils.getSubject();
        User user = (User)subject.getPrincipal();
        model.addAttribute("user", user.getName());

        model.addAttribute("prefix", prefix);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("pageNum", pageNum);

        return "back/manageDisaster";
    }

    @RequestMapping("/manageDisaster/edit")
    @ResponseBody
    public String edit(HttpServletRequest request, HttpServletResponse response){

        String prefix = request.getParameter("prefix");
        String name = request.getParameter("name");
        String value = request.getParameter("value");

        try {
            if ( prefix.equals("temperature") ){
                List<City> theCities = cityDao.getCityByName(name);

                int id = theCities.get(0).getId();

                cityDao.setTemperatureById(id, value);
            } else if ( prefix.equals("pm2_5") ) {
                List<City> theCities = cityDao.getCityByName(name);

                int id = theCities.get(0).getId();

                cityDao.setPm2_5ById(id, value);
            } else if ( prefix.equals("taifeng") ) {
                String id = request.getParameter("id");
                String time = request.getParameter("time");
                String lng = request.getParameter("lng");
                String lat = request.getParameter("lat");

                taifengDao.updateTaifengById(id, name, lng, lat, time, value);
            } else if ( prefix.equals("earthquake") ) {
                String id = request.getParameter("id");
                String time = request.getParameter("time");
                String lng = request.getParameter("lng");
                String lat = request.getParameter("lat");

                earthquakeDao.updateEarthquakeById(id, name, lng, lat, value, time);
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }

    @RequestMapping("/manageDisaster/delete")
    @ResponseBody
    public String delete(HttpServletRequest request, HttpServletResponse response){

        String id = request.getParameter("id");
        String prefix = request.getParameter("prefix");

        try {
            switch (prefix){
                case "taifeng":
                    taifengDao.deleteTaifengById(id);
                    break;
                case "earthquake":
                    earthquakeDao.deleteEarthquakeById(id);
                    break;
            }
        } catch ( Exception e ) {
            e.printStackTrace();
            return "error";
        }

        return "success";
    }
}
