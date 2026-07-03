package com.puntopet.punto_pet.controller;
import com.puntopet.punto_pet.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {
    private final UsuarioService usuarioService;
    private final com.puntopet.punto_pet.service.NotificacionService notificacionService;

    public LoginController(UsuarioService usuarioService, com.puntopet.punto_pet.service.NotificacionService notificacionService) {
        this.usuarioService = usuarioService;
        this.notificacionService = notificacionService;
    }

    @GetMapping("/login")
    public String mostrarLogin(){
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam("username") String correo,
                                @RequestParam("password") String password,
                                HttpSession session, Model model){
        if (usuarioService.autenticar(correo, password)){
            session.setAttribute("usuarioLogeado", correo);
            return "redirect:/home";
        } else {
          model.addAttribute("error", "Usuario o contraseña incorrectos");
          return "login";
        }
    }

    @GetMapping("/registro")
    public String mostrarRegistro(Model model) {
        return "registro";
    }

    @PostMapping("/registro")
    public String procesarRegistro(@ModelAttribute com.puntopet.punto_pet.model.Usuario usuario, Model model, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            usuarioService.registrarUsuario(usuario);
            redirectAttributes.addFlashAttribute("mensajeExito", "Registro exitoso");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "registro";
        }
    }

    @GetMapping("/home")
    public String mostrarHome(HttpSession session, Model model){
        String usuario = (String) session.getAttribute("usuarioLogeado");
        if (usuario == null){
            return "redirect:/login";
        }
        model.addAttribute("usuarioLogeado", usuario);

        java.util.List<com.puntopet.punto_pet.model.Notificacion> notificaciones = notificacionService.obtenerNotificacionesNoLeidas(usuario);
        model.addAttribute("notificaciones", notificaciones);

        return "home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login";
    }
}
