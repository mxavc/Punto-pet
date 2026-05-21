package com.puntopet.punto_pet.controller;
import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.service.MascotaService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/parejas")
public class ParejaController {
    private final MascotaService mascotaService;

    public ParejaController(MascotaService mascotaService) {
        this.mascotaService = mascotaService;
    }

    @GetMapping("/buscar")
    public String iniciarBusqueda(HttpSession session, Model model) {
        String usuario = (String) session.getAttribute("usuarioLogeado");
        if (usuario == null) return "redirect:/login";

        List<Mascota> misMascotas = mascotaService.listarPorDueno(usuario);

        // Regla de negocio: Si solo tiene una mascota, avanza automáticamente al paso de filtros
        if (misMascotas.size() == 1) {
            return "redirect:/parejas/filtros?mascotaId=" + misMascotas.get(0).getId();
        }

        model.addAttribute("mascotas", misMascotas);
        return "seleccionarMascotaBusqueda"; // Carga seleccionarMascotaBusqueda.jsp
    }

    @GetMapping("/filtros")
    public String mostrarFiltros(@RequestParam("mascotaId") Long mascotaId, HttpSession session, Model model) {
        if (session.getAttribute("usuarioLogeado") == null) return "redirect:/login";

        model.addAttribute("mascotaId", mascotaId);
        return "elegirFiltroRaza";
    }

    @GetMapping("/resultados")
    public String procesarFiltrado(@RequestParam("mascotaId") Long mascotaId,
                                   @RequestParam("tipoFiltro") String tipoFiltro,
                                   HttpSession session, Model model) {
        String usuario = (String) session.getAttribute("usuarioLogeado");
        if (usuario == null) return "redirect:/login";

        List<Mascota> resultados = mascotaService.buscarParejasDisponibles(mascotaId, tipoFiltro, usuario);
        model.addAttribute("resultados", resultados);
        return "resultadosParejas"; // Carga resultadosParejas.jsp
    }
}
