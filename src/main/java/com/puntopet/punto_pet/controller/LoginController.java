package com.puntopet.punto_pet.controller;
import com.puntopet.punto_pet.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {
    private final UsuarioService usuarioService;

    public LoginController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
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
    public String mostrarHome(HttpSession session){
        if (session.getAttribute("usuarioLogeado") == null){
            return "redirect:/login";
        }
        return "home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/login";
    }
}
