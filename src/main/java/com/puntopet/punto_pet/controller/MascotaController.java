package com.puntopet.punto_pet.controller;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.model.Usuario;
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

        String usuarioLogeado = (String) session.getAttribute("usuarioLogeado");
        mascota.setDuenoId(usuarioLogeado);

        try {
            service.registrarMascota(mascota, certificado, fotos);
            redirectAttributes.addFlashAttribute("mensajeExito", "Documentación ingresada exitosamente");
            return "redirect:/mascotas/registro";
        } catch (Exception e) {
            model.addAttribute("error", "Error al guardar la mascota: " + e.getMessage());
            return "formularioRegistroMascota";
        }
    }

    @GetMapping("/mis-mascotas")
    public String listarMisMascotas(HttpSession session, Model model) {
        String usuario = (String) session.getAttribute("usuarioLogeado");
        if (usuario == null) return "redirect:/login";

        List<Mascota> misMascotas = service.listarPorDuenio(usuario);
        model.addAttribute("mascotas", misMascotas);
        return "misMascotas"; // Carga misMascotas.jsp
    }

    @GetMapping("/detalle/{id}")
    public String verDetalle(@PathVariable("id") Long id, HttpSession session, Model model) {
        if (session.getAttribute("usuarioLogeado") == null) return "redirect:/login";

        Mascota mascota = service.obtenerPorId(id);
        model.addAttribute("mascota", mascota);
        return "detalleMascota"; // Carga detalleMascota.jsp
    }

    @PostMapping("/actualizar/{id}")
    public String actualizarMascota(@PathVariable("id") Long id,
                                    @RequestParam("peso") double peso,
                                    @RequestParam("altura") double altura,
                                    @RequestParam("fileCertificado") MultipartFile certificado,
                                    @RequestParam("filesFotos") List<MultipartFile> fotos,
                                    RedirectAttributes redirectAttributes,
                                    HttpSession session) {
        if (session.getAttribute("usuarioLogueado") == null) return "redirect:/login";

        try {
            service.actualizarMascota(id, peso, altura, certificado, fotos);
            redirectAttributes.addFlashAttribute("mensajeExito", "Perfil actualizado correctamente");
            return "redirect:/mascotas/detalle/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/mascotas/detalle/" + id;
        }
    }
}