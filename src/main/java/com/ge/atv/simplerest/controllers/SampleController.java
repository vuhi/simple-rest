package com.ge.atv.simplerest.controllers;

import com.ge.atv.simplerest.daos.Role;
import com.ge.atv.simplerest.services.IRoleService;
import com.ge.atv.simplerest.services.ISampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/api")
public class SampleController {

    private ISampleService sampleService;
    private IRoleService roleService;

    @Autowired
    public SampleController(
        ISampleService sampleService,
        IRoleService roleService

    ) {
        this.sampleService = sampleService;
        this.roleService = roleService;
    }

    @GetMapping("/ping")
    public HashMap<String, String> ping() {
        HashMap<String, String> res = new HashMap<String, String>();
        res.put("message", "pong");
        return res;
    }

    @GetMapping("/error")
    public void error() {
        throw new APIError("Test API Error", null, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping("/long-process")
    public HashMap<String, String> longProcess(@RequestParam int range, @RequestParam boolean hasError) {
        long startTime = System.nanoTime();
        this.sampleService.doLongRunningProcess(range);
        long stopTime = System.nanoTime();
        if (hasError) {
            throw new APIError("Long process encounter error", null, HttpStatus.BAD_REQUEST);
        }
        double elapsedTime  = (double)(stopTime - startTime) / 1_000_000_000.0;
        HashMap<String, String> res = new HashMap<String, String>();
        res.put("message", String.format("success complete long running process in %fs", elapsedTime));
        return res;
    }

    @GetMapping("/role")
    public HashMap<String, List<Role>> getRoles() {
        HashMap<String, List<Role>> res = new HashMap<>();
        res.put("data", this.roleService.findAll());
        return res;
    }

    @GetMapping("/external-api-call")
    public HashMap<String, Object> externalAPICall() {
        final String uri = "https://jsonplaceholder.typicode.com/todos/1";
        RestTemplate http = new RestTemplate();
        Object todo = http.getForObject(uri, Object.class);
        HashMap<String, Object> res = new HashMap<>();
        res.put("data", todo);
        return res;
    }
}
