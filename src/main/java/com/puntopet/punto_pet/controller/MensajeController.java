package com.puntopet.punto_pet.controller;

import com.puntopet.punto_pet.service.MensajeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/mensajes")
public class MensajeController {

    private final MensajeService mensajeService;

    public MensajeController(MensajeService mensajeService) {
        this.mensajeService = mensajeService;
    }

    @PostMapping("/enviar")
    public String enviarMensaje(@RequestParam("destinatarioId") String destinatarioId,
                                @RequestParam("mascotaId") Long mascotaId,
                                @RequestParam("contenido") String contenido,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
                                    
        String remitenteId = (String) session.getAttribute("usuarioLogeado");
        if (remitenteId == null) return "redirect:/login";

        try {
            mensajeService.enviarMensaje(remitenteId, destinatarioId, contenido);
            redirectAttributes.addFlashAttribute("mensajeExito", "Mensaje enviado correctamente");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/mascotas/detalle/" + mascotaId;
    }
}
