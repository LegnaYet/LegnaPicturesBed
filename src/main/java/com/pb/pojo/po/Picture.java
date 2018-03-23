package com.pb.pojo.po;

import java.io.Serializable;

public class Picture implements Serializable {
    private Integer pid;

    private String filename;

    private String url;

    private static final long serialVersionUID = 1L;

    public Picture(Integer pid, String filename, String url) {
        this.pid = pid;
        this.filename = filename;
        this.url = url;
    }

    public Picture() {
        super();
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
}