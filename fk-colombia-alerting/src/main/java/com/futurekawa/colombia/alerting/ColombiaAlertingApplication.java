package com.futurekawa.colombia.alerting;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.futurekawa"})
public class ColombiaAlertingApplication {
    public static void main(String[] args) {
        SpringApplication.run(ColombiaAlertingApplication.class, args);
    }
}
