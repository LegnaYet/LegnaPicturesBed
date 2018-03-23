package com.pb.service;

import com.pb.pojo.po.Picture;

import java.util.List;

public interface IPictureService {
    void upload(Picture picture);

    List<Picture> selectAllPics();
}
