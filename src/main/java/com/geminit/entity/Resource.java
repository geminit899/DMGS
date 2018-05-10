package com.geminit.entity;

/**
 * @author Geminit
 * @create 2018-5-10
 * @modify 2018-5-10
 */

public class Resource {

    private String id;
    private String name;
    private byte[] content;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }
}
