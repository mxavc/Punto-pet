package com.puntopet.punto_pet.service;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.repository.MascotaRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class MascotaServiceTest {

    @Mock
    private MascotaRepository mascotaRepository;

    @InjectMocks
    private MascotaService mascotaService;

    private Mascota mascota;
    private MultipartFile certificadoPdf;
    private List<MultipartFile> fotos;

    @BeforeEach
    void setUp() {
        mascota = new Mascota();
        mascota.setNombre("Tobby");
        mascota.setEspecie("Perro");
        mascota.setRaza("Labrador");
        mascota.setSexo("Macho");
        mascota.setFechaNacimiento(LocalDate.now().minusYears(1));
        mascota.setPeso(25.5);
        mascota.setAltura(0.6);


        certificadoPdf = mock(MultipartFile.class);
        fotos = new ArrayList<>();
        fotos.add(mock(MultipartFile.class));
    }

    @Test
    @DisplayName("CA02.1 - Escenario Positivo: Registro exitoso de mascota con todos los datos")
    void testRegistrarMascotaExitoso() throws IOException {
        when(certificadoPdf.getContentType()).thenReturn("application/pdf");
        when(certificadoPdf.getSize()).thenReturn(1024L);
        when(certificadoPdf.getBytes()).thenReturn(new byte[]{1, 2, 3});
        when(mascotaRepository.save(any(Mascota.class))).thenReturn(mascota);

        Mascota registrada = mascotaService.registrarMascota(mascota, certificadoPdf, fotos);

        assertNotNull(registrada);
        verify(mascotaRepository, times(1)).save(mascota);
        assertNotNull(registrada.getCertificadoPdf());
    }

    @Test
    @DisplayName("CA01.2 - Escenario Negativo: Fecha de nacimiento futura")
    void testFechaNacimientoFutura() {
        mascota.setFechaNacimiento(LocalDate.now().plusDays(1));

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.registrarMascota(mascota, certificadoPdf, fotos);
        });

        assertEquals("La fecha no puede ser superior a la fecha actual", exception.getMessage());
    }

    @Test
    @DisplayName("CA01.6 - Escenario Negativo: Certificado no es PDF")
    void testCertificadoNoPdf() {
        when(certificadoPdf.getContentType()).thenReturn("image/jpeg");

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.registrarMascota(mascota, certificadoPdf, fotos);
        });

        assertEquals("Solo se permiten archivos PDF", exception.getMessage());
    }

    @Test
    @DisplayName("CA01.7 - Escenario Negativo: Certificado supera el tamaño máximo")
    void testCertificadoSuperaTamano() {
        when(certificadoPdf.getContentType()).thenReturn("application/pdf");
        when(certificadoPdf.getSize()).thenReturn(6 * 1024 * 1024L); // 6 MB

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.registrarMascota(mascota, certificadoPdf, fotos);
        });

        assertEquals("El archivo supera el tamaño máximo permitido (5 MB)", exception.getMessage());
    }

    @Test
    @DisplayName("CA01.5 - Escenario Negativo: No se proporcionan fotos")
    void testSinFotos() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.registrarMascota(mascota, null, Collections.emptyList());
        });

        assertEquals("Se requiere entre 1 y 5 fotos", exception.getMessage());
    }

    @Test
    @DisplayName("CA01.5 - Escenario Negativo: Se proporcionan más de 5 fotos")
    void testMasDeCincoFotos() {
        List<MultipartFile> seisFotos = new ArrayList<>();
        for (int i = 0; i < 6; i++) {
            seisFotos.add(mock(MultipartFile.class));
        }

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.registrarMascota(mascota, null, seisFotos);
        });

        assertEquals("Se requiere entre 1 y 5 fotos", exception.getMessage());
    }

    @Test
    @DisplayName("CA01.8 - Escenario Positivo: Verificación de persistencia")
    void testVerificarPersistencia() throws IOException {
        when(certificadoPdf.getContentType()).thenReturn("application/pdf");
        when(certificadoPdf.getSize()).thenReturn(1024L);
        when(mascotaRepository.save(any(Mascota.class))).thenReturn(mascota);

        mascotaService.registrarMascota(mascota, certificadoPdf, fotos);

        verify(mascotaRepository, times(1)).save(mascota);
    }

    @Test
    @DisplayName("HU02 - Debería lanzar excepción si el peso de actualización es menor o igual a cero")
    void testActualizarPesoInvalido() {
        // GIVEN: Un ID simulado y un registro existente
        Long idSimulado = 1L;
        Mascota mascotaSimulada = new Mascota();
        mascotaSimulada.setNombre("Clifford");

        when(mascotaRepository.findById(idSimulado)).thenReturn(Optional.of(mascotaSimulada));

        // WHEN & THEN: Intentamos actualizar con peso inválido (-2.5 kg) y esperamos fallo
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            mascotaService.actualizarMascota(idSimulado, -2.5, 45.0, null, new ArrayList<>());
        });

        assertEquals("Peso y altura deben ser mayores a 0", exception.getMessage());
    }
}