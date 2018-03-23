package com.pb.Utils;

import java.util.UUID;

public class NameUtil {
    public static String getUUID(){
        String string = UUID.randomUUID().toString();
        String id = string.replace("-", "");
        return id;
    }

    public static String getFileName(String originalFilename) {
        String[] split = originalFilename.split("\\.");
        String filename = getUUID()+"."+split[1];
        return filename;
    }

    public static String getFileExtName(String originalFilename) {
        String[] split = originalFilename.split("\\.");
        String filename = split[1];
        return filename;
    }
}
