package com.puntopet.punto_pet.config;
import com.puntopet.punto_pet.model.Usuario;
import com.puntopet.punto_pet.repository.UsuarioRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataInitializer {
    @Bean
    public CommandLineRunner initData(UsuarioRepository usuarioRepository) {
        return args -> {
            if (usuarioRepository.findByUsername("demouser").isEmpty()){
                usuarioRepository.save(new Usuario("demouser","demopass"));
                System.out.println("Usuario de prueba demouser creado.");
            }
        };
    }
}
