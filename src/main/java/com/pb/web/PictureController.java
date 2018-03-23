package com.pb.web;

import com.pb.pojo.po.Picture;
import com.pb.service.IPictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
public class PictureController {
    @Autowired
    private IPictureService service;

    @RequestMapping(value = "/allPics", method = RequestMethod.GET)
    public String selectAllPics(HttpServletRequest request, HttpServletResponse response) {
        List<Picture> pictures = service.selectAllPics();
        request.setAttribute("pictures",pictures);
        return "allPics";
    }
}
