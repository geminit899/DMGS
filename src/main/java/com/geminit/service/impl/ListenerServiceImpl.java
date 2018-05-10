package com.geminit.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.*;
import com.geminit.entity.*;
import com.geminit.service.ListenerService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Geminit
 * @create 2018-5-7
 * @modify 2018-5-7
 */

@Service
@Transactional(rollbackFor = Exception.class)
public class ListenerServiceImpl implements ListenerService {

    @Autowired
    CityDao cityDao;

    @Autowired
    EarthquakeDao earthquakeDao;

    @Autowired
    NewsDao newsDao;

    @Autowired
    LawDao lawDao;

    @Autowired
    KnowledgeDao knowledgeDao;

    @Override
    public void updateTemperature(){

        List<City> cities = new ArrayList<>();

        try {
            cities = cityDao.getCities();
        } catch (Exception e){
            e.printStackTrace();
            return;
        }

        for (int i = 0; i < cities.size(); i++){
            int id = cities.get(i).getId();
            String lat = cities.get(i).getLat();
            String lng = cities.get(i).getLng();
            //请求url的location为 纬度 ： 经度
            String location = lat + ":" + lng;
            String url = "https://api.seniverse.com/v3/weather/now.json?key=24fx6zvg0mnfjfqf&location=" + location;
            StringBuilder jsonString = new StringBuilder();
            try {
                URL oracle = new URL(url);
                URLConnection yc = oracle.openConnection();
                BufferedReader in = new BufferedReader(new InputStreamReader(
                        yc.getInputStream(),"utf-8"));//防止乱码
                String inputLine = null;
                while ((inputLine = in.readLine()) != null) {
                    jsonString.append(inputLine);
                }
                in.close();
            } catch (Exception e){
                e.printStackTrace();
                continue;
            }
            JSONObject json = JSON.parseObject(jsonString.toString());
            JSONArray results = (JSONArray)json.get("results");
            JSONObject result = (JSONObject)results.get(0);
            JSONObject now = (JSONObject)result.get("now");
            String temperature = now.get("temperature").toString();

            try {
                cityDao.setTemperatureById(id, temperature);
            } catch (Exception e){
                e.printStackTrace();
                continue;
            }
        }
    }

    @Override
    public void updateEarthquakeInfo(){

        Earthquake latestEarthquake = new Earthquake();

        try {
            latestEarthquake = earthquakeDao.getLatestEarthquake();
        } catch ( Exception e ) {
            e.printStackTrace();
            return;
        }

        String latestName = latestEarthquake.getName();
        String tempTime = latestEarthquake.getTime();
        String latestTime = tempTime.substring(0, tempTime.length()-2);

        String url = "http://news.ceic.ac.cn/index.html";
        Document doc;

        try{
            doc = Jsoup.connect(url).get();
        }
        catch(Exception e){
            e.printStackTrace();
            return;
        }

        Element news = doc.getElementById("news");
        Elements trs = news.getElementsByTag("tr");

        for ( int i = 1; i < trs.size(); i++ ) {
            Elements tds = trs.get(i).getElementsByTag("td");
            String name = tds.get(5).text();
            String time = tds.get(1).text();

            if ( latestName.equals(name)  && latestTime.equals(time) )
                return;

            if ( !inChina(name) )
                continue;

            String lng = tds.get(3).text();
            String lat = tds.get(2).text();
            String degree = tds.get(0).text();


            try {
                earthquakeDao.insertEarthquakeInfo(name, lng, lat, degree, time);
            } catch ( Exception e ) {
                e.printStackTrace();
                continue;
            }

        }
    }

    @Override
    public void updatePM2_5(){

        List<City> cities = new ArrayList<>();

        try {
            cities = cityDao.getCities();
        } catch (Exception e){
            e.printStackTrace();
            return;
        }

        try {
            URL url = new URL("https://chkj02.market.alicloudapi.com/qgtq");// 创建连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setUseCaches(false);
            connection.setInstanceFollowRedirects(true);
            connection.setRequestMethod("GET"); // 设置请求方式
            connection.setRequestProperty("Authorization", "APPCODEbb1a9c2cea4848ba93d4d60811730e8c"); // 设置接收数据的格式
            connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式
            connection.connect();
            OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); // utf-8编
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("city", "深圳");
            out.append(JSON.toJSONString(jsonObject));
            out.flush();
            out.close();

            int code = connection.getResponseCode();
            InputStream is = null;
            if (code == 200) {
                is = connection.getInputStream();
            } else {
                is = connection.getErrorStream();
            }

            // 读取响应
            int length = (int) connection.getContentLength();// 获取长度
            if (length != -1) {
                byte[] data = new byte[length];
                byte[] temp = new byte[512];
                int readLen = 0;
                int destPos = 0;
                while ((readLen = is.read(temp)) > 0) {
                    System.arraycopy(temp, 0, data, destPos, readLen);
                    destPos += readLen;
                }
                String result = new String(data, "UTF-8"); // utf-8编码
                System.out.println(result);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void updateNews(){

        News latestNews;

        try {
            latestNews = newsDao.getLatestNews();
        } catch ( Exception e ) {
            e.printStackTrace();
            return;
        }

        String latestTitle = latestNews.getTitle();

        String url = "http://www.dsac.cn/News";
        Document doc;

        try{
            doc = Jsoup.connect(url).get();
        }catch(Exception e){
            e.printStackTrace();
            return;
        }

        Element newsList = doc.getElementsByClass("newsList").first();
        Elements lis = newsList.getElementsByTag("li");

        for (int i = 0; i < lis.size(); i++){
            Element li = lis.get(i);
            Element a = li.getElementsByTag("a").first();
            Element span = li.getElementsByTag("span").first();

            String newsURL = "http://www.dsac.cn" + a.attr("href");
            String title = a.text();
            String time = span.text();

            if ( latestTitle.equals(title) )
                return;

            try{
                doc = Jsoup.connect(newsURL).get();
            }
            catch(Exception e){
                e.printStackTrace();
                continue;
            }

            String content = doc.getElementById("main_artical_div").text();

            try {
                newsDao.insertNews(title, time, content);
            } catch ( Exception e ) {
                e.printStackTrace();
                continue;
            }
        }
    }

    @Override
    public void updateLaw(){

        Law law;

        try {
            law = lawDao.getLatestLaw();
        } catch ( Exception e ) {
            e.printStackTrace();
            return;
        }

        String latestTitle = law.getTitle();

        String url = "http://www.110.com/fagui/tag_193288_1.html";
        Document doc;

        try{
            doc = Jsoup.connect(url).get();
        }
        catch(Exception e){
            e.printStackTrace();
            return;
        }

        Element box = doc.select("[class=\"box01\"]").first();
        Elements as = box.getElementsByTag("a");

        for ( int i = 0; i < as.size(); i++) {
            String lawURL = as.get(i).attr("href");
            String name = as.get(i).text();

            if ( latestTitle.equals(name) )
                return;

            try{
                doc = Jsoup.connect(lawURL).get();
            }
            catch(Exception e){
                e.printStackTrace();
                continue;
            }

            Element timeDiv = doc.select("[class=\"info\"]").first();
            String[] timeList = timeDiv.text().split(":");
            String time = timeList[timeList.length-1];

            Element articleBody = doc.getElementById("articleBody");
            String content = articleBody.text();

            try {
                lawDao.insertLaws(name, time, content);
            } catch ( Exception e ) {
                e.printStackTrace();
                continue;
            }

        }

    }

    @Override
    public void updateKnowledge(){

        Knowledge knowledge;

        try {
            knowledge = knowledgeDao.getLatestKnowledge();
        } catch ( Exception e ) {
            e.printStackTrace();
            return;
        }

        String latestTitle = knowledge.getTitle();

        String url = "http://www.mlr.gov.cn/kpyd/zhkp/";
        Document doc;

        try{
            doc = Jsoup.connect(url).get();
        }
        catch(Exception e){
            e.printStackTrace();
            return;
        }

        Element table = doc.getElementById("con");
        Elements as = table.getElementsByTag("a").select("[target=\"_blank\"]");

        for ( int i = 0; i < as.size(); i++) {
            String tempURL = as.get(i).attr("href");
            String knowledgeURL = "http://www.mlr.gov.cn/kpyd/zhkp" + tempURL.substring(1);
            String name = as.get(i).text();

            if ( latestTitle.equals(name) )
                return;

            try{
                doc = Jsoup.connect(knowledgeURL).get();
            }
            catch(Exception e){
                e.printStackTrace();
                continue;
            }

            String timeTd = doc.select("[class=\"Gray12\"]").first().text();
            String time = timeTd.split(" | ")[0];
            String content = doc.getElementById("content1").text();

            try {
                knowledgeDao.insertKnowledges(name, time, content);
            } catch ( Exception e ) {
                e.printStackTrace();
                continue;
            }
        }

    }

    private boolean inChina(String name){
        String[] suffix = { "区", "县", "市", "海域" };

        for (int i = 0; i < suffix.length; i++){
            if ( name.endsWith(suffix[i]) ) {
                return true;
            }
        }

        return false;
    }

}
