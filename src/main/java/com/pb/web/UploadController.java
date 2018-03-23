package com.pb.web;

import com.pb.Utils.FastDFSClient;
import com.pb.Utils.NameUtil;
import com.pb.Utils.UploadUtil;
import com.pb.pojo.po.Data;
import com.pb.pojo.po.Picture;
import com.pb.pojo.po.Result;
import com.pb.service.IPictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class UploadController {
    @Autowired
    private IPictureService service;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String toIndex() {
        return "index";
    }

    @RequestMapping(value = "/vsftpd", method = RequestMethod.GET)
    public String toVsftpd() {
        return "UploadPictures";
    }

    @RequestMapping(value = "/upload.do", method = RequestMethod.POST)
    @ResponseBody
    public Result upload(@RequestParam("fileup") MultipartFile file) {
        Result result = new Result();
        Data data = new Data();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        String datefile = sdf.format(new Date()).toString();
        result.setCode("success");
        Picture picture = new Picture();
        String url = "120.79.154.236/images/" + datefile;
        if (!file.isEmpty()) {
            try {
                String filename = NameUtil.getFileName(file.getOriginalFilename());
                boolean hasUpload = UploadUtil.uploadFile("120.79.154.236", 21, "ftpuser",
                        "ych121358", "/home/ftpuser/www/images/", datefile + "/", filename, file.getInputStream());
                picture.setFilename(filename);
                picture.setUrl(url + "/" + filename);
                if (hasUpload) {
                    service.upload(picture);
                    data.setUrl(picture.getUrl());
                }
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        result.setData(data);
        return result;
    }

    @RequestMapping(value = "/fastdfsUpload.do", method = RequestMethod.POST)
    @ResponseBody
    public Result fastdfsUpload(@RequestParam("fileup") MultipartFile file) {
        Result result = new Result();
        Data data = new Data();
        result.setCode("success");
        Picture picture = new Picture();
        if (!file.isEmpty()) {
            try {
                String ext_name = NameUtil.getFileExtName(file.getOriginalFilename());
                FastDFSClient fastDFSClient=new FastDFSClient("classpath:fastdfs.conf");//此处应当注入对象过来
                String path= fastDFSClient.upload_file(file.getBytes(), ext_name, null);
                String url = "120.79.154.236:88/"+path;
                data.setUrl(url);
                picture.setUrl(url);
                picture.setFilename(file.getOriginalFilename());
                service.upload(picture);
            } catch (Exception e) {
                result.setCode("error");
                e.printStackTrace();
            }
        }
        result.setData(data);
        return result;
    }
}
