package com.ge.atv.simplerest;

import com.ge.atv.simplerest.services.ISampleService;
import com.ge.atv.simplerest.services.SampleService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

@org.springframework.context.annotation.Configuration
@ComponentScan("com.ge.atv.simplerest")
public class Configuration {
    @Bean(name = "sampleService")
    public ISampleService sampleService() {
        return new SampleService();
    }
}
