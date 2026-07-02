package com.puntopet.punto_pet.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "notificacion")
public class Notificacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String usuarioId;

    @Column(nullable = false)
    private String mensaje;

    @Column(nullable = false)
    private boolean leida = false;

    @Column(nullable = false)
    private LocalDateTime fecha;

    public Notificacion() {}

    public Notificacion(String usuarioId, String mensaje) {
        this.usuarioId = usuarioId;
        this.mensaje = mensaje;
        this.leida = false;
        this.fecha = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUsuarioId() { return usuarioId; }
    public void setUsuarioId(String usuarioId) { this.usuarioId = usuarioId; }
    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    public boolean isLeida() { return leida; }
    public void setLeida(boolean leida) { this.leida = leida; }
    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
}
