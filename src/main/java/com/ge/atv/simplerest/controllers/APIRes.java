package com.ge.atv.simplerest.controllers;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.http.HttpStatus;

import java.io.StringWriter;
import java.io.PrintWriter;
import java.time.LocalDateTime;

public class APIRes {
    private HttpStatus status;
    private String message;
    private Object data;
    private String[] trace;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy hh:mm:ss")
    private LocalDateTime timestamp;

    private APIRes() {
        this.timestamp = LocalDateTime.now();
    }

    public APIRes(String message, Object data, HttpStatus status) {
        this();
        this.message = message;
        this.data = data;
        this.status = status;
    }

    public APIRes(String message, Throwable ex, HttpStatus status) {
        this();
        this.message = message;
        this.status = status;

        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        ex.printStackTrace(pw);
        this.trace = sw.toString().split("\r\n\t");
    }

    public HttpStatus getStatus() {
        return status;
    }

    public String getMessage() {
        return message;
    }

    public Object getData() {
        return data;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public String[] getTrace() {
        return trace;
    }

    public void setTrace(String[] trace) {
        this.trace = trace;
    }
}
