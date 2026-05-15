package com.puntopet.punto_pet.service;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.repository.MascotaRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import java.io.IOException;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class MascotaServiceTest {

    @Mock
    private MascotaRepository mascotaRepository;

    @InjectMocks
    private MascotaService mascotaService;

    @Test
    @DisplayName("CA01.6 - Rechazar archivos que no sean PDF")
    void testRechazoFormatoInvalido() throws IOException {
        Mascota mascota = new Mascota();
        // Añadir fecha para pasar la validación de fecha
        mascota.setFechaNacimiento(LocalDate.now().minusDays(1)); 
        
        MockMultipartFile docxFile = new MockMultipartFile("certificado", "test.docx", "application/msword", "contenido".getBytes());
        // Crear una foto válida para pasar la validación de fotos
        MockMultipartFile fotoValida = new MockMultipartFile("foto", "foto.jpg", "image/jpeg", "fotobytes".getBytes());

        IllegalArgumentException ex = assertThrows(IllegalArgumentException.class, () -> {
            // Pasar la lista con la foto válida
            mascotaService.registrarMascota(mascota, docxFile, java.util.List.of(fotoValida));
        });

        assertEquals("Solo se permiten archivos PDF", ex.getMessage());
    }

    @Test
    @DisplayName("CA01.8 - Verificar que se llame al repositorio para guardar")
    void testPersistenciaLlamada() throws IOException {
        Mascota mascota = new Mascota();
        // Añadir fecha para pasar la validación de fecha
        mascota.setFechaNacimiento(LocalDate.now().minusYears(1)); 
        
        MockMultipartFile foto = new MockMultipartFile("foto", "perro.jpg", "image/jpeg", "bytes".getBytes());
        
        mascotaService.registrarMascota(mascota, null, java.util.List.of(foto));

        verify(mascotaRepository, times(1)).save(any(Mascota.class));
    }
}