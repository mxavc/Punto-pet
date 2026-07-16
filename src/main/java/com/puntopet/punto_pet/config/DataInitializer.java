package com.puntopet.punto_pet.config;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.model.Usuario;
import com.puntopet.punto_pet.repository.UsuarioRepository;
import com.puntopet.punto_pet.repository.MascotaRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.util.Collections;

@Configuration
public class DataInitializer {
    private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    @Bean
    public CommandLineRunner initData(UsuarioRepository usuarioRepository, MascotaRepository mascotaRepository) {
        return args -> {
            if (usuarioRepository.findByCorreo("demo@correo.com").isEmpty()) {
                usuarioRepository.save(new Usuario("Demo", "User", "+593", "0999999999", "demo@correo.com", passwordEncoder.encode("Demo123!"), "Quito", "Norte"));
                log.info("Usuario de prueba demouser creado.");
            }

            if (usuarioRepository.findByCorreo("perros@correo.com").isEmpty()) {
                usuarioRepository.save(new Usuario("Owner", "Perros", "+593", "0999999998", "perros@correo.com", passwordEncoder.encode("Demo123!"), "Guayaquil", "Sur"));
            }

            if (usuarioRepository.findByCorreo("gatos@correo.com").isEmpty()) {
                usuarioRepository.save(new Usuario("Owner", "Gatos", "+593", "0999999997", "gatos@correo.com", passwordEncoder.encode("Demo123!"), "Cuenca", "Centro"));
            }

            // Un byte array dummy para simular los bytes de la foto principal obligatoria
            // (CA01.5)
            byte[] fotoDummy = new byte[] { 1, 2, 3 };

            if (mascotaRepository.count() == 0) {

                // --- MASCOTAS PROPIAS DEL DEMOUSER (Para probar que NO salgan en sus
                // búsquedas) ---
                Mascota miPerro = new Mascota();
                miPerro.setNombre("Sparky");
                miPerro.setEspecie("perro");
                miPerro.setRaza("Bulldog");
                miPerro.setSexo("Macho");
                miPerro.setFechaNacimiento(LocalDate.of(2023, 5, 10));
                miPerro.setPeso(12.5);
                miPerro.setAltura(35.0);
                miPerro.setDuenoId("demo@correo.com");
                miPerro.setFotos(Collections.singletonList(fotoDummy));
                mascotaRepository.save(miPerro);

                // --- CANDIDATOS DE LA MISMA RAZA (Para probar filtro MISMA_RAZA) ---
                // Caso Perro: Hembra Bulldog para Sparky (Macho Bulldog)
                Mascota parejaMismaRazaP = new Mascota();
                parejaMismaRazaP.setNombre("Bella");
                parejaMismaRazaP.setEspecie("perro");
                parejaMismaRazaP.setRaza("Bulldog");
                parejaMismaRazaP.setSexo("Hembra");
                parejaMismaRazaP.setFechaNacimiento(LocalDate.of(2022, 8, 20));
                parejaMismaRazaP.setPeso(11.0);
                parejaMismaRazaP.setAltura(32.0);
                parejaMismaRazaP.setDuenoId("perros@correo.com");
                parejaMismaRazaP.setFotos(Collections.singletonList(fotoDummy));
                mascotaRepository.save(parejaMismaRazaP);

                // --- CANDIDATOS DE OTRA RAZA (Para probar filtro OTRA_RAZA) ---
                // Caso Perro: Hembra Terrier (Diferente raza, misma especie, sexo opuesto)
                Mascota parejaOtraRazaP = new Mascota();
                parejaOtraRazaP.setNombre("Luna");
                parejaOtraRazaP.setEspecie("perro");
                parejaOtraRazaP.setRaza("Terrier");
                parejaOtraRazaP.setSexo("Hembra");
                parejaOtraRazaP.setFechaNacimiento(LocalDate.of(2024, 1, 15));
                parejaOtraRazaP.setPeso(6.5);
                parejaOtraRazaP.setAltura(25.0);
                parejaOtraRazaP.setDuenoId("perros@correo.com");
                parejaOtraRazaP.setFotos(Collections.singletonList(fotoDummy));
                mascotaRepository.save(parejaOtraRazaP);

                // Caso Perro: Macho Pitbull (Misma especie pero mismo sexo que Sparky -> NO
                // debe aparecer)
                Mascota perroMachoFiltro = new Mascota();
                perroMachoFiltro.setNombre("Thor");
                perroMachoFiltro.setEspecie("perro");
                perroMachoFiltro.setRaza("Pitbull");
                perroMachoFiltro.setSexo("Macho");
                perroMachoFiltro.setFechaNacimiento(LocalDate.of(2021, 3, 12));
                perroMachoFiltro.setPeso(28.0);
                perroMachoFiltro.setAltura(50.0);
                perroMachoFiltro.setDuenoId("perros@correo.com");
                perroMachoFiltro.setFotos(Collections.singletonList(fotoDummy));
                mascotaRepository.save(perroMachoFiltro);

                // --- CASOS PARA GATOS (Futuras pruebas) ---
                Mascota gatoCandidato = new Mascota();
                gatoCandidato.setNombre("Simba");
                gatoCandidato.setEspecie("gato");
                gatoCandidato.setRaza("Persa");
                gatoCandidato.setSexo("Macho");
                gatoCandidato.setFechaNacimiento(LocalDate.of(2023, 11, 1));
                gatoCandidato.setPeso(4.2);
                gatoCandidato.setAltura(22.0);
                gatoCandidato.setDuenoId("gatos@correo.com");
                gatoCandidato.setFotos(Collections.singletonList(fotoDummy));
                mascotaRepository.save(gatoCandidato);

                log.info("📋 Datos de prueba inyectados con éxito en PostgreSQL.");
            }
        };
    }
}
