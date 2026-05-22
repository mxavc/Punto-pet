package com.puntopet.punto_pet.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "mascotas")
public class Mascota {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "El nombre es obligatorio")
    @Pattern(regexp = "^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$", message = "El nombre solo debe contener letras")
    private String nombre;

    @NotBlank(message = "La especie es obligatoria")
    private String especie;

    @NotBlank(message = "La raza es obligatoria")
    private String raza;

    @NotBlank(message = "El sexo es obligatorio")
    private String sexo;

    @Past(message = "La fecha no puede ser superior a la fecha actual")
    private LocalDate fechaNacimiento;
    
    @NotNull(message = "El peso es obligatorio")
    @DecimalMin(value = "0.0", inclusive = false, message = "El peso debe ser mayor a 0")
    private Double peso;

    @NotNull(message = "La altura es obligatoria")
    @DecimalMin(value = "0.0", inclusive = false, message = "La altura debe ser mayor a 0")
    private Double altura;

    private String duenoId;

    @Lob
    private byte[] certificadoPdf;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "mascota_fotos", joinColumns = @JoinColumn(name = "mascota_id"))
    @Lob
    @Column(name = "foto_bytes")
    private List<byte[]> fotos = new ArrayList<>();

    @Transient
    public String getEdadCalculada(){
        if(this.fechaNacimiento == null) return "Edad desconocida";
        java.time.Period periodo = java.time.Period.between(this.fechaNacimiento, java.time.LocalDate.now());
        if (periodo.getYears()>0){
            return periodo.getYears() + ((periodo.getYears() == 1)? " año" : " años");
        } else {
            return periodo.getMonths() + ((periodo.getMonths() == 1)? " mes" : " meses");
        }
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public String getRaza() {
        return raza;
    }

    public void setRaza(String raza) {
        this.raza = raza;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    public Double getAltura() {
        return altura;
    }

    public void setAltura(Double altura) {
        this.altura = altura;
    }

    public String getDuenoId() { return duenoId; }

    public void setDuenoId(String duenoId) { this.duenoId = duenoId; }

    public byte[] getCertificadoPdf() {
        return certificadoPdf;
    }

    public void setCertificadoPdf(byte[] certificadoPdf) {
        this.certificadoPdf = certificadoPdf;
    }

    public List<byte[]> getFotos() {
        return fotos;
    }

    public void setFotos(List<byte[]> fotos) {
        this.fotos = fotos;
    }
}
