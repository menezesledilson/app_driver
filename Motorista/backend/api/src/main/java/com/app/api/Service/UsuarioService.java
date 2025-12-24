package com.app.api.Service;

import com.app.api.Entity.Usuario;
import com.app.api.Repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public Usuario criar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }

    public Usuario atualizar(Long id, Usuario usuarioDetails) {
        Usuario usuario = buscarPorId(id);

        usuario.setMotorista(usuarioDetails.getMotorista());
        usuario.setPlaca(usuarioDetails.getPlaca());
        usuario.setKmSaida(usuarioDetails.getKmSaida());
        usuario.setKmChegada(usuarioDetails.getKmChegada());
        usuario.setDestino(usuarioDetails.getDestino());
        usuario.setData(usuarioDetails.getData());
        usuario.setHoraSaida(usuarioDetails.getHoraSaida());
        usuario.setHoraChegada(usuarioDetails.getHoraChegada());
        usuario.setObs(usuarioDetails.getObs());

        return usuarioRepository.save(usuario);
    }

    public void deletar(Long id) {
        usuarioRepository.deleteById(id);
    }
}
