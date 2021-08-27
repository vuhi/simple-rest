package com.ge.atv.simplerest.controllers;

import org.springframework.http.HttpStatus;

public class APIError extends RuntimeException {

    public HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
    public String message = "Unexpected error";
//    private String debugMessage;

    public APIError(String message) {
        super(message);
    }

    public APIError(Throwable cause) {
        super(cause);
    }

    public APIError(String message, Throwable cause) {
        super(message, cause);
    }

    public APIError(String message, Throwable cause, HttpStatus status) {
        super(message, cause);
        this.status = status;
//        this.debugMessage = cause.getLocalizedMessage();
    }
}
