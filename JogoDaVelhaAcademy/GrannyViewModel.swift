//
//  GrannyViewModel.swift
//  JogoDaVelha
//
//  Created by Gilberto Magno on 29/06/23.
//

import Foundation
import SwiftUI

struct CheckersResult {
    private static let resultCases: [[[Int]]] = [
        [[1, 0, 0], [1, 0, 0], [1, 0, 0]],
        [[0, 1, 0], [0, 1, 0], [0, 1, 0]],
        [[0, 0, 1], [0, 0, 1], [0, 0, 1]],

        [[1, 1, 1], [0, 0, 0], [0, 0, 0]],
        [[0, 0, 0], [1, 1, 1], [0, 0, 0]],
        [[0, 0, 0], [0, 0, 0], [1, 1, 1]],

        [[1, 0, 0], [0, 1, 0], [0, 0, 1]],
        [[0, 0, 1], [0, 1, 0], [1, 0, 0]]
    ]

    static func checkIfHasVictory(_ board: [[Marker]]) -> Marker {
        for result in CheckersResult.resultCases {
            var multiplication = 0
            for (index, row) in result.enumerated() {
                multiplication += row[0] * board[index][0].rawValue
                multiplication += row[1] * board[index][1].rawValue
                multiplication += row[2] * board[index][2].rawValue
            }

            if multiplication == 3 {
                for index in 0...2 {
                    if checkRow(index, with: 1, in: board) ||
                       checkColumn(index, with: 1, in: board) {
                        return .X
                    }
                }

                if checkDiagonal(1, with: 1, in: board) ||
                   checkDiagonal(2, with: 1, in: board) {
                    return .X
                }
            }

            if multiplication == 6 {
                for index in 0...2 {
                    if checkRow(index, with: 2, in: board) ||
                       checkColumn(index, with: 2, in: board) {
                        return .O
                    }
                }

                if checkDiagonal(1, with: 2, in: board) ||
                   checkDiagonal(2, with: 2, in: board) {
                    return .O
                }
            }
        }

        return .none
    }

    private static func checkRow(_ rowIndex: Int,
                                 with value: Int,
                                 in board: [[Marker]]) -> Bool {
        if  board[rowIndex][0].rawValue == value &&
            board[rowIndex][1].rawValue == value &&
            board[rowIndex][2].rawValue == value {
            return true
        }

        return false
    }

    private static func checkColumn(_ columnIndex: Int,
                                    with value: Int,
                                    in board: [[Marker]]) -> Bool {
        if  board[0][columnIndex].rawValue == value &&
            board[1][columnIndex].rawValue == value &&
            board[2][columnIndex].rawValue == value {
            return true
        }

        return false
    }

    private static func checkDiagonal(_ index: Int,
                                      with value: Int,
                                      in board: [[Marker]]) -> Bool {
        if index == 1 {
            if board[0][0].rawValue == value &&
               board[1][1].rawValue == value &&
               board[2][2].rawValue == value {
                return true
            }
        } else {
            if board[0][2].rawValue == value &&
               board[1][1].rawValue == value &&
               board[2][0].rawValue == value {
                return true
            }
        }

        return false
    }
}


enum Marker: Int, Identifiable {
    var id: UUID { UUID() }
    case X = 1
    case O = 2
    case none = 0
}

class GrannyViewModel: ObservableObject {
    
    var columns: [GridItem] {
        var columns: [GridItem] = []
        for _ in 1...boardSize {
            columns.append(.init(.flexible()))
        }
        return columns
    }
    @Published var board: [[Marker]] =         [[.none,.none,.none],
                                     [.none,.none,.none],
                                     [.none,.none,.none]]
    @Published var boardSize: Int = 3
    @Published var turn: Marker = .X
    @Published var winner: Marker = .none
    @Published var matchEnded: Bool = false
    
    func checkIfHasVictory() -> Marker {
        var isThereSpace: Bool = false
        board.forEach {
            isThereSpace = $0.contains(.none)
        }
        
        // Checando as linhas
        for i in 0..<3 {
            if board[i][0] != .none && board[i][0] == board[i][1] && board[i][0] == board[i][2] {
                return board[i][0]
            }
        }
        
        // Checando as colunas
        for i in 0..<3 {
            if board[0][i] != .none && board[0][i] == board[1][i] && board[0][i] == board[2][i] {
                return board[0][i]
            }
        }
        
        // Checando as diagonais
        if board[0][0] != .none && board[0][0] == board[1][1] && board[0][0] == board[2][2] {
            return board[0][0]
        }
        
        if board[0][2] != .none && board[0][2] == board[1][1] && board[0][2] == board[2][0] {
            return board[0][2]
        }
        matchEnded = !isThereSpace
        return .none
    }
    
    func addMarker(at position: (i: Int,j: Int)) {
        board[position.i][position.j] = turn
        turn = turn == .O ? .X : .O
        winner = checkIfHasVictory()
        if winner != .none {
            matchEnded = true
        }
    }
    
    func resetBoard() {
        board = [[.none,.none,.none],
                 [.none,.none,.none],
                 [.none,.none,.none]]
        winner = .none
        matchEnded = false
        turn = .X
    }
    
}
