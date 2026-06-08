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

    @org.springframework.web.bind.annotation.GetMapping("/mis-mensajes")
    public String verMisMensajes(HttpSession session, org.springframework.ui.Model model) {
        String correo = (String) session.getAttribute("usuarioLogeado");
        if (correo == null) return "redirect:/login";

        java.util.List<com.puntopet.punto_pet.model.Mensaje> mensajes = mensajeService.obtenerMisMensajes(correo);
        model.addAttribute("mensajes", mensajes);
        model.addAttribute("usuarioActual", correo);

        return "misMensajes";
    }

    @PostMapping("/responder")
    public String responderMensaje(@RequestParam("destinatarioId") String destinatarioId,
                                   @RequestParam("contenido") String contenido,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
                                    
        String remitenteId = (String) session.getAttribute("usuarioLogeado");
        if (remitenteId == null) return "redirect:/login";

        try {
            mensajeService.enviarMensaje(remitenteId, destinatarioId, contenido);
            redirectAttributes.addFlashAttribute("mensajeExito", "Respuesta enviada correctamente");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/mensajes/mis-mensajes";
    }
}
