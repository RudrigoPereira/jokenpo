import Foundation

enum JoKenPo: String {
    case pedra = "Pedra"
    case papel = "Papel"
    case tesoura = "Tesoura"
    
    static func randomChoice() -> JoKenPo {
        let choices: [JoKenPo] = [.pedra, .papel, .tesoura]
        return choices.randomElement()!
    }
    
    func vence(_ outro: JoKenPo) -> Bool {
        switch (self, outro) {
        case (.pedra, .tesoura), (.papel, .pedra), (.tesoura, .papel):
            return true
        default:
            return false
        }
    }
}

func solicitarEscolhaDoUsuario() -> JoKenPo? {
    print("Escolha sua jogada (1. Pedra, 2. Papel, 3. Tesoura): ", terminator: "")
    if let input = readLine() {
        switch input {
        case "1": return .pedra
        case "2": return .papel
        case "3": return .tesoura
        default: print("Escolha inválida. Tente novamente.")
        }
    }
    return nil
}

func modoDeJogo() -> Int? {
    print("""
        \nEscolha o modo de jogo:
        1. Melhor de 3
        2. Melhor de 5
        3. Melhor de 7\n
        """
    )
    if let input = readLine() {
        switch input {
        case "1": return 3
        case "2": return 5
        case "3": return 7
        default: print("Escolha inválida. Tente novamente.")
        }
    }
    return nil
}

func exibirPlacar(vitorias: Int, derrotas: Int, empates: Int) {
    print("\nPlacar Atual:")
    print("Vitórias: \(vitorias) | Derrotas: \(derrotas) | Empates: \(empates)")
}

func exibirEstatisticas(vitorias: Int, derrotas: Int, empates: Int, totalPartidas: Int) {
    let percentualVitorias = Double(vitorias) / Double(totalPartidas) * 100
    let percentualDerrotas = Double(derrotas) / Double(totalPartidas) * 100
    let percentualEmpates = Double(empates) / Double(totalPartidas) * 100
    
    print("\n--- Estatísticas Finais ---")
    print("Total de Partidas Jogadas: \(totalPartidas)")
    print(String(format: "Vitórias: %.2f%%", percentualVitorias))
    print(String(format: "Derrotas: %.2f%%", percentualDerrotas))
    print(String(format: "Empates: %.2f%%", percentualEmpates))
}

func perguntarSeDesejaJogarNovamente() -> Bool {
    while true {
        print("\nDeseja jogar novamente? (S/N): ", terminator: "")
        if let resposta = readLine()?.lowercased() {
            if resposta == "s" {
                return true
            } else if resposta == "n" {
                return false
            } else {
                print("Resposta inválida. Digite 'S' para sim ou 'N' para não.")
            }
        }
    }
}

func jogar() {
    var continuarJogando = true
    
    while continuarJogando {
        var vitorias = 0
        var derrotas = 0
        var empates = 0
        var totalPartidas = 0
        
        guard let modo = modoDeJogo() else { continue }
        let necessarioParaVencer = (modo / 2) + 1

        print("\n--- Melhor de \(modo) ---")
        
        while vitorias < necessarioParaVencer && derrotas < necessarioParaVencer {
            guard let escolhaUsuario = solicitarEscolhaDoUsuario() else { continue }
            let escolhaPC = JoKenPo.randomChoice()
            
            print("Você escolheu: \(escolhaUsuario.rawValue)")
            print("O PC escolheu: \(escolhaPC.rawValue)")
            
            if escolhaUsuario.vence(escolhaPC) {
                print("Você venceu esta rodada!")
                vitorias += 1
            } else if escolhaPC.vence(escolhaUsuario) {
                print("O PC venceu esta rodada!")
                derrotas += 1
            } else {
                print("Empate!")
                empates += 1
            }
            
            totalPartidas += 1
            exibirPlacar(vitorias: vitorias, derrotas: derrotas, empates: empates)
        }
        
        if vitorias > derrotas {
            print("\n--- Parabéns! Você venceu o modo Melhor de \(modo). ---")
        } else {
            print("\n--- Que pena! O PC venceu o modo Melhor de \(modo). ---")
        }
        
        exibirEstatisticas(vitorias: vitorias, derrotas: derrotas, empates: empates, totalPartidas: totalPartidas)
        
        continuarJogando = perguntarSeDesejaJogarNovamente()
    }
    
    print("\nObrigado por jogar! Até a próxima!\n")
}

jogar()
