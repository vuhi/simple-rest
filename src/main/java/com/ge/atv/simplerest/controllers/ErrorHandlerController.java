package com.ge.atv.simplerest.controllers;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@Order(Ordered.HIGHEST_PRECEDENCE)
@ControllerAdvice
@RestController
public class ErrorHandlerController extends ResponseEntityExceptionHandler {

    @ExceptionHandler(Exception.class)
    public final ResponseEntity<APIRes> handleAllExceptions(Exception ex, WebRequest req) {

        APIRes res;
        // Check if it is APIError
        if (ex instanceof APIError) {
            res = new APIRes(ex.getMessage(), ex, ((APIError) ex).status);
        } else {
            res = new APIRes(ex.getMessage(), ex, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<APIRes>(res, res.getStatus());
    }
}
