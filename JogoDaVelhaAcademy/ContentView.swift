//
//  ContentView.swift
//  JogoDaVelha
//
//  Created by Gilberto Magno on 29/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewmodel: GrannyViewModel = GrannyViewModel()
    
    var body: some View {
        Rectangle()
            .colorInvert()
            .overlay {
                VStack {
                    if viewmodel.winner == .O {
                        Text("O CIRCULO VENCEU")
                    }
                    if viewmodel.winner == .X {
                        Text("O XIS VENCEU")
                    }
                    if viewmodel.winner == .none && viewmodel.matchEnded {
                        Text("EMPATE")
                    }
                    LazyVGrid(columns: viewmodel.columns) {
                        ForEach(0..<3) { line in
                            ForEach(0..<3) { column in
                                Rectangle()
                                    .colorInvert()
                                    .border(.black)
                                    .frame(width: 60,height: 60)
                                    .padding(.horizontal,4).padding(.vertical,4)
                                    .overlay {
                                        if viewmodel.board[line][column] == .X {
                                            Text("X")
                                        } else if viewmodel.board[line][column] == .O {
                                            Text("O")
                                        }
                                    }
                                    .onTapGesture {
                                        viewmodel.addMarker(at: (line,column))
                                    }
                            }
                            
                        }
                    }
                    if viewmodel.turn == .X {
                        Text("Turno do X")
                    } else {Text("Turno do O")}
                }
            }
        .onTapGesture {
            if viewmodel.matchEnded {
                viewmodel.resetBoard()
            }
        }
                
    }
}
