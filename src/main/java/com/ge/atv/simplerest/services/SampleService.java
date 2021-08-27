package com.ge.atv.simplerest.services;


import com.ge.atv.simplerest.controllers.APIError;
import org.springframework.http.HttpStatus;

import java.math.BigInteger;
import java.util.Random;

public class SampleService implements ISampleService {

    @Override
    public BigInteger doLongRunningProcess(int range) {
        if (range < 4000 || range > 6000) {
            throw new APIError("range should be between 4000 - 6000", null, HttpStatus.BAD_REQUEST);
        }
        BigInteger veryBig = new BigInteger(range, new Random());
        return veryBig.nextProbablePrime();
    }
}
