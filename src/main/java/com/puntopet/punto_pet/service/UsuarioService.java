package com.puntopet.punto_pet.service;
import com.puntopet.punto_pet.model.Usuario;
import com.puntopet.punto_pet.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class UsuarioService {
    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }
    public boolean autenticar(String username, String password) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        if (usuarioOpt.isPresent()) {
            return usuarioOpt.get().getPassword().equals(password);
        }
        return false;
    }

}
