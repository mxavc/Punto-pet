package com.puntopet.punto_pet.controller;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.service.MascotaService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/mascotas") // Base más limpia
public class MascotaController {

    private final MascotaService service;

    public MascotaController(MascotaService service) {
        this.service = service;
    }

    // Si entras a localhost:8080/mascotas/ te lleva al formulario
    @GetMapping("/")
    public String index(HttpSession session) {
        if (session.getAttribute("usuarioLogeado") == null) {
            return "redirect:/login";
        }
        return "redirect:/mascotas/registro";
    }

    @GetMapping("/registro")
    public String mostrarFormulario(Model model, HttpSession session) {
        if (session.getAttribute("usuarioLogeado") == null) {
            return "redirect:/login";
        }
        if (!model.containsAttribute("mascota")) {
            model.addAttribute("mascota", new Mascota());
            }
        return "formularioRegistroMascota";
    }

    @PostMapping("/guardar")
    public String guardarMascota(@Valid @ModelAttribute("mascota") Mascota mascota, 
                                BindingResult result,
                                @RequestParam("fileCertificado") MultipartFile certificado,
                                @RequestParam("filesFotos") List<MultipartFile> fotos,
                                Model model,
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {

        if (session.getAttribute("usuarioLogeado") == null){
            return "redirect:/login";
        }

        if (result.hasErrors()) return "formularioRegistroMascota";

        try {
            service.registrarMascota(mascota, certificado, fotos);
            redirectAttributes.addFlashAttribute("mensajeExito", "Documentación ingresada exitosamente");
            return "redirect:/mascotas/registro";
        } catch (Exception e) {
            model.addAttribute("error", "Error al guardar la mascota: " + e.getMessage());
            return "formularioRegistroMascota";
        }
    }
}