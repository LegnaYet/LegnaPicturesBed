package com.pb.pojo.po;

import java.io.Serializable;
import java.util.List;

public class Result implements Serializable{
    private String code;
    private Data data;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }
}
