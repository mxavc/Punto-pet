package com.puntopet.punto_pet.service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.repository.MascotaRepository;

@Service
public class MascotaService {

    private final MascotaRepository mascotaRepository;
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5 MB

    public MascotaService(MascotaRepository mascotaRepository) {
        this.mascotaRepository = mascotaRepository;
    }

    public Mascota registrarMascota(Mascota mascota, MultipartFile certificado, List<MultipartFile> fotos) throws IOException {
        
        // 1. Validación de Fechas (CA01.2)
        if (mascota.getFechaNacimiento().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("La fecha no puede ser superior a la fecha actual");
        }

        // 2. Validación del Certificado Opcional (CA01.1, CA01.6, CA01.7)
        if (certificado != null && !certificado.isEmpty()) {
            
            // CA01.6: Validar tipo MIME
            if (!"application/pdf".equals(certificado.getContentType())) {
                throw new IllegalArgumentException("Solo se permiten archivos PDF");
            }
            
            // CA01.7: Validar tamaño
            if (certificado.getSize() > MAX_FILE_SIZE) {
                throw new IllegalArgumentException("El archivo supera el tamaño máximo permitido (5 MB)");
            }

            // Extraer bytes para la BD
            mascota.setCertificadoPdf(certificado.getBytes());
        }

        // 3. Validación de Fotos (CA01.5)
        if (fotos == null || fotos.isEmpty() || fotos.size() > 5) {
            throw new IllegalArgumentException("Se requiere entre 1 y 5 fotos");
        }
        // (Aquí iría la validación del formato JPG/PNG de las fotos)

        // 4. Persistencia (CA01.8)
        return mascotaRepository.save(mascota);
    }
}