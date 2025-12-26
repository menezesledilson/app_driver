package com.app.api.Controller;

import com.app.api.Entity.Usuario;
import com.app.api.Repository.UsuarioRepository;
import com.app.api.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.time.LocalDate;
import java.util.List;

@CrossOrigin(origins = "http://localhost:5000")
@RestController
@RequestMapping("/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Criar usuário - 201 Created
    @PostMapping
    public ResponseEntity<Usuario> createUsuario(@RequestBody Usuario usuario) {
        Usuario saved = usuarioRepository.save(usuario);
        return ResponseEntity
                .created(URI.create("/usuario/" + saved.getId())) // Location Header RESTful
                .body(saved);
    }

    // Listar todos - 200 OK
    @GetMapping
    public ResponseEntity<List<Usuario>> getAllUsuario() {
        return ResponseEntity.ok(usuarioRepository.findAll());
    }

    // Buscar por id - 200 OK / 404
    @GetMapping("/{id}")
    public ResponseEntity<Usuario> getUsuarioById(@PathVariable Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado: " + id));
        return ResponseEntity.ok(usuario);
    }

    // Atualizar - 200 OK / 404
    @PutMapping("/{id}")
    public ResponseEntity<Usuario> updateUsuario(@PathVariable Long id, @RequestBody Usuario usuarioDetails) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado: " + id));

        usuario.setMotorista(usuarioDetails.getMotorista());
        usuario.setPlaca(usuarioDetails.getPlaca());
        usuario.setKmSaida(usuarioDetails.getKmSaida());
        usuario.setKmChegada(usuarioDetails.getKmChegada());
        usuario.setDestino(usuarioDetails.getDestino());
        usuario.setData(usuarioDetails.getData());
        usuario.setHoraSaida(usuarioDetails.getHoraSaida());
        usuario.setHoraChegada(usuarioDetails.getHoraChegada());
        usuario.setObs(usuarioDetails.getObs());

        Usuario atualizado = usuarioRepository.save(usuario);
        return ResponseEntity.ok(atualizado);
    }

    // Deletar - 204 No Content / 404
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUsuario(@PathVariable Long id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuário não encontrado: " + id));

        usuarioRepository.delete(usuario);
        return ResponseEntity.noContent().build();
    }

   // Buscar por data
   @GetMapping("/buscar-por-data")
   public ResponseEntity<List<Usuario>> buscarPorIntervalo(
           @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dataInicial,
           @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dataFinal
   ) {
       return ResponseEntity.ok(
               usuarioRepository.findByDataBetween(dataInicial, dataFinal)
       );
   }

}

