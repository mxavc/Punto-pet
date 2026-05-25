package com.puntopet.punto_pet.service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.puntopet.punto_pet.model.Mascota;
import com.puntopet.punto_pet.repository.MascotaRepository;

@Service
@Transactional
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
        if (fotos == null || fotos.isEmpty() || fotos.get(0).isEmpty() || fotos.size() > 5) {
            throw new IllegalArgumentException("Se requiere entre 1 y 5 fotos");
        }
        
        for (MultipartFile foto : fotos) {
            String contentType = foto.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new IllegalArgumentException("Solo se permiten archivos de imagen (JPG, PNG, etc.)");
            }
            mascota.getFotos().add(foto.getBytes());
        }

        // 4. Persistencia (CA01.8)
        return mascotaRepository.save(mascota);
    }

    public Mascota obtenerPorId(Long id) {
        return mascotaRepository.findById(id).orElse(null);
    }

    public List<Mascota> listarPorDueno(String duenoId) {
        return mascotaRepository.findByDuenoId(duenoId);
    }

    public void actualizarMascota(Long id, double peso, double altura, MultipartFile certificado, List<MultipartFile> nuevasFotos) throws IOException {
        Mascota mascota = mascotaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Mascota no encontrada"));

        // Actualización de rangos básicos
        if (peso <= 0 || altura <= 0) throw new IllegalArgumentException("Peso y altura deben ser mayores a 0");
        mascota.setPeso(peso);
        mascota.setAltura(altura);

        // Adjuntar nuevo certificado si se subió uno
        if (certificado != null && !certificado.isEmpty()) {
            if (!"application/pdf".equals(certificado.getContentType())) {
                throw new IllegalArgumentException("Solo se permiten archivos PDF");
            }
            mascota.setCertificadoPdf(certificado.getBytes());
        }

        // Agregar nuevas fotos si existen sin borrar el historial previo
        if (nuevasFotos != null && !nuevasFotos.isEmpty() && !nuevasFotos.get(0).isEmpty()) {
            for (MultipartFile foto : nuevasFotos) {
                mascota.getFotos().add(foto.getBytes());
            }
        }

        mascotaRepository.save(mascota);
    }

    public List<Mascota> buscarParejasDisponibles(Long mascotaId, String tipoFiltro, String duenoIdLogueado) {
        Mascota miMascota = mascotaRepository.findById(mascotaId)
                .orElseThrow(() -> new IllegalArgumentException("Mascota no encontrada")); //

        // Determinar el sexo opuesto para la reproducción
        String sexoPareja = miMascota.getSexo().equalsIgnoreCase("Macho") ? "Hembra" : "Macho";
        String especie = miMascota.getEspecie();
        String raza = miMascota.getRaza();

        if ("MISMA_RAZA".equals(tipoFiltro)) {
            return mascotaRepository.findByEspecieAndRazaAndSexoAndDuenoIdNot(especie, raza, sexoPareja, duenoIdLogueado);
        } else {
            return mascotaRepository.findByEspecieAndRazaNotAndSexoAndDuenoIdNot(especie, raza, sexoPareja, duenoIdLogueado);
        }
    }
}