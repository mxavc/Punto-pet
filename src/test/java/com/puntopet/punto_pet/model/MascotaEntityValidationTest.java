package com.puntopet.punto_pet.model;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.*;
import java.time.LocalDate;
import java.util.Set;
import static org.junit.jupiter.api.Assertions.*;

class MascotaEntityValidationTest {

    private Validator validator;

    @BeforeEach
    void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    @DisplayName("CA01.3 - El nombre debe ser obligatorio")
    void testNombreObligatorio() {
        Mascota mascota = new Mascota();
        mascota.setNombre(""); // Vacío

        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertTrue(violations.stream().anyMatch(v -> v.getMessage().equals("El nombre es obligatorio")));
    }

    @Test
    @DisplayName("CA01.2 - La fecha no puede ser futura")
    void testFechaInvalida() {
        Mascota mascota = new Mascota();
        mascota.setFechaNacimiento(LocalDate.now().plusDays(5));

        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertTrue(violations.stream().anyMatch(v -> v.getMessage().contains("fecha no puede ser superior")));
    }

    @Test
    @DisplayName("CA01.4 - El peso debe ser mayor a 0")
    void testPesoInvalido() {
        Mascota mascota = new Mascota();
        mascota.setPeso(-1.0);

        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
    }
}