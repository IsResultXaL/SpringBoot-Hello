package com.caogen.springboothello.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("hello")
    public String HelloWord() {
        return "Hello CaoGen!";
    }

}
