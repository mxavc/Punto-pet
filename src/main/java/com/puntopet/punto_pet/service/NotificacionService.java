package com.puntopet.punto_pet.service;

import com.puntopet.punto_pet.model.Notificacion;
import com.puntopet.punto_pet.repository.NotificacionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificacionService {
    
    private final NotificacionRepository notificacionRepository;

    public NotificacionService(NotificacionRepository notificacionRepository) {
        this.notificacionRepository = notificacionRepository;
    }

    public void crearNotificacion(String usuarioId, String mensaje) {
        Notificacion notificacion = new Notificacion(usuarioId, mensaje);
        notificacionRepository.save(notificacion);
    }

    public List<Notificacion> obtenerNotificacionesNoLeidas(String usuarioId) {
        return notificacionRepository.findByUsuarioIdAndLeidaFalseOrderByFechaDesc(usuarioId);
    }

    public void marcarComoLeida(Long id) {
        notificacionRepository.findById(id).ifPresent(notificacion -> {
            notificacion.setLeida(true);
            notificacionRepository.save(notificacion);
        });
    }
}
