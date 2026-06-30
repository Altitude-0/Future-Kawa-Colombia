package com.futurekawa.colombia.mqtt;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.futurekawa"})
public class ColombiaMqttApplication {
    public static void main(String[] args) {
        SpringApplication.run(ColombiaMqttApplication.class, args);
    }
}
