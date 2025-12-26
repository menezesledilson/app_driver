package com.app.api.Repository;

import com.app.api.Entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

    //busca exata pela data
    //List<Usuario> findByData(String dataInicial, String dataFinal);
    @Repository
    public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

        List<Usuario> findByDataBetween(LocalDate dataInicial, LocalDate dataFinal);

    }

