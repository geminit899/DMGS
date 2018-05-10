package com.geminit.dao;

import org.springframework.stereotype.Repository;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

@Repository
public interface AboutUsDao {

    String getLawStatement();

    String getPrivacyProtection();

    String getWebsiteMap();

    String getContactUs();

    void setLawStatement(String law_statement);

    void setPrivacyProtection(String privacy_protection);

    void setWebsiteMap(String website_map);

    void setContactUs(String contact_us);

}
