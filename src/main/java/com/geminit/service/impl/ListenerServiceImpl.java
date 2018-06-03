package com.geminit.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.geminit.dao.*;
import com.geminit.entity.*;
import com.geminit.service.ListenerService;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.http.client.HttpClient;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.security.cert.X509Certificate;
import java.util.*;

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
                URL xinZhiTianQi = new URL(url);
                URLConnection uc = xinZhiTianQi.openConnection();
                BufferedReader in = new BufferedReader(new InputStreamReader(
                        uc.getInputStream(),"utf-8"));//防止乱码
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
    public void updateTaifeng(){

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

            String lng = tds.get(3).text();
            String lat = tds.get(2).text();
            String degree = tds.get(0).text();

            int province;

            try {
                province = cityDao.getProvinceByName(name.substring(0,2));
            } catch ( Exception e ) {
                province = -1;
            }

            try {
                earthquakeDao.insertEarthquakeInfo(name, lng, lat, degree, time, province);
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


        HttpClient httpClient = new DefaultHttpClient();
        try {

            SSLContext ctx = SSLContext.getInstance("TLS");
            X509TrustManager tm = new X509TrustManager() {
                public X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
                public void checkClientTrusted(X509Certificate[] xcs, String str) {

                }
                public void checkServerTrusted(X509Certificate[] xcs, String str) {

                }
            };
            ctx.init(null, new TrustManager[] { tm }, null);
            SSLSocketFactory ssf = new SSLSocketFactory(ctx);
            ssf.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
            ClientConnectionManager ccm = httpClient.getConnectionManager();
            SchemeRegistry registry = ccm.getSchemeRegistry();
            registry.register(new Scheme("https", 443, ssf));
        } catch ( Exception e ) {
            e.printStackTrace();
        }


        for ( int i = 236; i < cities.size(); i++) {
            int id = cities.get(i).getId();
            String result = "";

            try {
                String name = cities.get(i).getShortname();
                HttpResponse response = null;
                HttpGet get = new HttpGet("https://chkj02.market.alicloudapi.com/qgtq?city=" + name);
                get.addHeader("Authorization", "APPCODE bb1a9c2cea4848ba93d4d60811730e8c");
                response = httpClient.execute(get);
                HttpEntity entity = response.getEntity();

                byte[] buffer = new byte[1024];
                int len = 0;

                while ((len = entity.getContent().read(buffer)) > 0) {
                    result += new String(buffer, 0, len);
                }
            } catch ( Exception e ) {
                e.printStackTrace();
                continue;
            }


            JSONObject jsonObject = (JSONObject)JSONObject.parseObject(result).get("data");
            String pm2_5 = JSONObject.parseObject(jsonObject.get("pm25").toString()).get("pm2_5").toString();

            cityDao.setPm2_5ById(id, pm2_5);
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
}
