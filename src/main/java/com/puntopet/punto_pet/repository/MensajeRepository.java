package com.puntopet.punto_pet.repository;

import com.puntopet.punto_pet.model.Mensaje;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface MensajeRepository extends JpaRepository<Mensaje, Long> {
    List<Mensaje> findByDestinatarioIdOrderByFechaEnviadoDesc(String destinatarioId);
}
