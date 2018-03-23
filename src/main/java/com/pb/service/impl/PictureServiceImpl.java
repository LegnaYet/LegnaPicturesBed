package com.pb.service.impl;

import com.pb.dao.PictureMapper;
import com.pb.pojo.po.Picture;
import com.pb.service.IPictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PictureServiceImpl implements IPictureService{
    @Autowired
    private PictureMapper dao;

    @Override
    public void upload(Picture picture) {
        dao.insert(picture);
    }

    @Override
    public List<Picture> selectAllPics() {
        return dao.selectByExample(null);
    }
}
