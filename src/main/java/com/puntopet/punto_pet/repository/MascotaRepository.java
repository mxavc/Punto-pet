package com.puntopet.punto_pet.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.puntopet.punto_pet.model.Mascota;
import java.util.List;

@Repository
public interface MascotaRepository extends JpaRepository<Mascota, Long>{
    List<Mascota> findByDuenoId(String duenoId);
}
