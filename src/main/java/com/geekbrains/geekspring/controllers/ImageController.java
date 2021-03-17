package com.geekbrains.geekspring.controllers;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import static com.geekbrains.geekspring.services.ImageSaverService.UPLOADED_FOLDER;

@Controller
@RequestMapping("/images")
public class ImageController {

    @GetMapping("/{imageName}")
    @ResponseBody
    public byte[] getImage(@PathVariable String imageName) throws IOException {
        if (imageName == null || imageName.isEmpty()) {
            return null;
        }
        File initialFile = new File(UPLOADED_FOLDER + imageName);
        byte[] bytes = new byte[(int) initialFile.length()];
        DataInputStream dataInputStream = new DataInputStream(new FileInputStream(initialFile));
        dataInputStream.readFully(bytes);
        return bytes;
    }
}
