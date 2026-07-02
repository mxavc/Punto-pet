package com.puntopet.punto_pet.service;

import com.puntopet.punto_pet.model.Mensaje;
import com.puntopet.punto_pet.repository.MensajeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MensajeService {
    
    private final MensajeRepository mensajeRepository;
    private final NotificacionService notificacionService;

    public MensajeService(MensajeRepository mensajeRepository, NotificacionService notificacionService) {
        this.mensajeRepository = mensajeRepository;
        this.notificacionService = notificacionService;
    }

    public void enviarMensaje(String remitenteId, String destinatarioId, String contenido) {
        if (contenido == null || contenido.trim().isEmpty()) {
            throw new IllegalArgumentException("El mensaje no puede estar vacío");
        }
        
        Mensaje mensaje = new Mensaje(remitenteId, destinatarioId, contenido.trim());
        mensajeRepository.save(mensaje);

        notificacionService.crearNotificacion(destinatarioId, "Has recibido un nuevo mensaje");
    }

    public List<Mensaje> obtenerMensajesDeUsuario(String destinatarioId) {
        return mensajeRepository.findByDestinatarioIdOrderByFechaEnviadoDesc(destinatarioId);
    }

    public List<Mensaje> obtenerMisMensajes(String correo) {
        return mensajeRepository.findByRemitenteIdOrDestinatarioIdOrderByFechaEnviadoDesc(correo, correo);
    }
}
