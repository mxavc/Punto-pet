package com.puntopet.punto_pet.controller;

import com.puntopet.punto_pet.service.NotificacionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notificaciones")
public class NotificacionController {

    private final NotificacionService notificacionService;

    public NotificacionController(NotificacionService notificacionService) {
        this.notificacionService = notificacionService;
    }

    @PostMapping("/leer/{id}")
    public String marcarLeida(@PathVariable("id") Long id, HttpSession session) {
        if (session.getAttribute("usuarioLogeado") == null) {
            return "redirect:/login";
        }
        notificacionService.marcarComoLeida(id);
        return "redirect:/home";
    }
}
