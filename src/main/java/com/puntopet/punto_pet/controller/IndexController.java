package com.puntopet.punto_pet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
    @GetMapping("/")
    public String root() {
        return "redirect:/mascotas/registro";
    }
}
