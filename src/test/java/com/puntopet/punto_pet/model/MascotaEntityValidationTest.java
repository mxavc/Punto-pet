package com.puntopet.punto_pet.model;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;

import java.time.LocalDate;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class MascotaEntityValidationTest {

    private static Validator validator;

    @BeforeAll
    public static void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    private Mascota createValidMascota() {
        Mascota mascota = new Mascota();
        mascota.setNombre("Tobby");
        mascota.setEspecie("Perro");
        mascota.setRaza("Labrador");
        mascota.setSexo("Macho");
        mascota.setFechaNacimiento(LocalDate.now().minusYears(1));
        mascota.setPeso(25.5);
        mascota.setAltura(0.6);
        mascota.setNombreDueno("Juan Perez");
        mascota.setTelefonoDueno("1234567890");
        return mascota;
    }

    @ParameterizedTest
    @ValueSource(strings = {"", " ", "123", "Nombre123"})
    @DisplayName("CA01.1 - Escenario Negativo: Nombre inválido")
    void testInvalidNombre(String nombre) {
        Mascota mascota = createValidMascota();
        mascota.setNombre(nombre);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
    }

    @ParameterizedTest
    @ValueSource(strings = {"Tobby", "Luna de Noche"})
    @DisplayName("CA01.1 - Escenario Positivo: Nombre válido")
    void testValidNombre(String nombre) {
        Mascota mascota = createValidMascota();
        mascota.setNombre(nombre);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertTrue(violations.isEmpty());
    }

    @ParameterizedTest
    @ValueSource(strings = {"", " "})
    @DisplayName("CA01.2 - Escenario Negativo: Especie, Raza o Sexo en blanco")
    void testBlankFields(String value) {
        Mascota mascota = createValidMascota();
        mascota.setEspecie(value);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());

        mascota = createValidMascota();
        mascota.setRaza(value);
        violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());

        mascota = createValidMascota();
        mascota.setSexo(value);
        violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
    }

    @Test
    @DisplayName("CA01.3 - Escenario Negativo: Fecha de nacimiento futura")
    void testFutureFechaNacimiento() {
        Mascota mascota = createValidMascota();
        mascota.setFechaNacimiento(LocalDate.now().plusDays(1));
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertEquals("La fecha no puede ser superior a la fecha actual", violations.iterator().next().getMessage());
    }

    @ParameterizedTest
    @ValueSource(doubles = {0.0, -1.0})
    @DisplayName("CA01.4 - Escenario Negativo: Peso menor o igual a 0")
    void testInvalidPeso(double peso) {
        Mascota mascota = createValidMascota();
        mascota.setPeso(peso);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertEquals("El peso debe ser mayor a 0", violations.iterator().next().getMessage());
    }

    @ParameterizedTest
    @ValueSource(doubles = {0.0, -1.0})
    @DisplayName("CA01.4 - Escenario Negativo: Altura menor o igual a 0")
    void testInvalidAltura(double altura) {
        Mascota mascota = createValidMascota();
        mascota.setAltura(altura);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertEquals("La altura debe ser mayor a 0", violations.iterator().next().getMessage());
    }

    @ParameterizedTest
    @ValueSource(strings = {"", " ", "Juan123"})
    @DisplayName("CA01.5 - Escenario Negativo: Nombre de dueño inválido")
    void testInvalidNombreDueno(String nombre) {
        Mascota mascota = createValidMascota();
        mascota.setNombreDueno(nombre);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
    }

    @ParameterizedTest
    @CsvSource({"123-456", "telefono", "123 456"})
    @DisplayName("CA01.6 - Escenario Negativo: Teléfono de dueño inválido")
    void testInvalidTelefonoDueno(String telefono) {
        Mascota mascota = createValidMascota();
        mascota.setTelefonoDueno(telefono);
        Set<ConstraintViolation<Mascota>> violations = validator.validate(mascota);
        assertFalse(violations.isEmpty());
        assertEquals("El teléfono solo debe contener números", violations.iterator().next().getMessage());
    }
}