package com.geminit.listener;

import com.geminit.service.ListenerService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

/**
 * @author Geminit
 * @create 2018-5-4
 * @modify 2018-5-4
 */

@WebListener()
public class Listener implements ServletContextListener,
        HttpSessionListener, HttpSessionAttributeListener {

    @Autowired
    ListenerService listenerService;

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed).
         You can initialize servlet context related data here.
      */

        long schedulePeriod = 24 * 60 * 60 * 1000; // h * m * s * ms
        Timer timer = new Timer();
        timer.schedule(new TimerTask(){
            @Override
            public void run() {
                // todo auto-generated method stub
                //执行你的任务类
            }
        }, new Date(), schedulePeriod);

        long earthquakeSchedulePeriod = 1 * 1 * 60 * 1000; // h * m * s * ms
        Timer earthquakeTimer = new Timer();
        earthquakeTimer.schedule(new TimerTask(){
            @Override
            public void run() {
                // todo auto-generated method stub
                //执行你的任务类
                listenerService.updateEarthquakeInfo();
            }
        }, new Date(), earthquakeSchedulePeriod);




    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context
         (the Web application) is undeployed or
         Application Server shuts down.
      */
    }

    // Public constructor is required by servlet spec
    public Listener() {
    }

    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    public void sessionCreated(HttpSessionEvent se) {
        /* Session is created. */
    }

    public void sessionDestroyed(HttpSessionEvent se) {
        /* Session is destroyed. */
    }

    // -------------------------------------------------------
    // HttpSessionAttributeListener implementation
    // -------------------------------------------------------

    public void attributeAdded(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute
         is added to a session.
      */
    }

    public void attributeRemoved(HttpSessionBindingEvent sbe) {
      /* This method is called when an attribute
         is removed from a session.
      */
    }

    public void attributeReplaced(HttpSessionBindingEvent sbe) {
      /* This method is invoked when an attibute
         is replaced in a session.
      */
    }
}
