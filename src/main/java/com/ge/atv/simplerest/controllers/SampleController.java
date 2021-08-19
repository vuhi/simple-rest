package com.ge.atv.simplerest.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

@RestController
public class SampleController {

    @GetMapping("/ping")
    public HashMap<String, String> ping() {
        HashMap<String, String> res = new HashMap<String, String>();
        res.put("data", "pong");
        return res;
    }

    @GetMapping("/sample")
    public HashMap<String, String> sample() {
        HashMap<String, String> res = new HashMap<String, String>();
        res.put("data", "sample result");
        return res;
    }
}
