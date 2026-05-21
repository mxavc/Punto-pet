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
    public String procesarLogin(@RequestParam("username") String username,
                                @RequestParam("password") String password,
                                HttpSession session, Model model){
        if (usuarioService.autenticar(username, password)){
            session.setAttribute("usuarioLogeado", username);
            return "redirect:/home";
        } else {
          model.addAttribute("error", "Usuario o contraseña incorrectos");
          return "login";
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
