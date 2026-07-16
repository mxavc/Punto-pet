package com.puntopet.punto_pet.service;
import com.puntopet.punto_pet.model.Usuario;
import com.puntopet.punto_pet.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import java.util.Optional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Service
public class UsuarioService {
    private final UsuarioRepository usuarioRepository;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }
    public boolean autenticar(String correo, String password) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByCorreo(correo);
        if (usuarioOpt.isPresent()) {
            return passwordEncoder.matches(password, usuarioOpt.get().getPassword());
        }
        return false;
    }

    public void registrarUsuario(Usuario usuario) {
        if (usuarioRepository.existsByCorreo(usuario.getCorreo())) {
            throw new IllegalArgumentException("El correo ya está en uso");
        }

        String regexLetras = "^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$";
        if (!usuario.getNombres().matches(regexLetras) || !usuario.getApellidos().matches(regexLetras)) {
            throw new IllegalArgumentException("Nombres y apellidos solo deben contener letras");
        }

        String regexTelefono = "^[0-9]+$";
        if (!usuario.getTelefono().matches(regexTelefono)) {
            throw new IllegalArgumentException("El teléfono debe contener solo dígitos");
        }

        String pwd = usuario.getPassword();
        if (!pwd.matches(".*[A-Z].*") || !pwd.matches(".*[a-z].*") || !pwd.matches(".*[0-9].*")) {
            throw new IllegalArgumentException("La contraseña debe incluir mayúsculas, minúsculas y números");
        }
        if (!pwd.matches(".*[^a-zA-Z0-9].*")) {
            throw new IllegalArgumentException("La contraseña debe incluir al menos un carácter especial");
        }

        String regexCorreo = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!usuario.getCorreo().matches(regexCorreo)) {
            throw new IllegalArgumentException("Correo electrónico inválido");
        }

        usuario.setPassword(passwordEncoder.encode(usuario.getPassword()));
        usuarioRepository.save(usuario);
    }

    public Usuario obtenerPorCorreo(String correo) {
        return usuarioRepository.findByCorreo(correo).orElse(null);
    }
}
