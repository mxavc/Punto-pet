package com.puntopet.punto_pet.service;

import com.puntopet.punto_pet.model.Mensaje;
import com.puntopet.punto_pet.repository.MensajeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MensajeService {
    
    private final MensajeRepository mensajeRepository;

    public MensajeService(MensajeRepository mensajeRepository) {
        this.mensajeRepository = mensajeRepository;
    }

    public void enviarMensaje(String remitenteId, String destinatarioId, String contenido) {
        if (contenido == null || contenido.trim().isEmpty()) {
            throw new IllegalArgumentException("El mensaje no puede estar vacío");
        }
        
        Mensaje mensaje = new Mensaje(remitenteId, destinatarioId, contenido.trim());
        mensajeRepository.save(mensaje);
    }

    public List<Mensaje> obtenerMensajesDeUsuario(String destinatarioId) {
        return mensajeRepository.findByDestinatarioIdOrderByFechaEnviadoDesc(destinatarioId);
    }
}
