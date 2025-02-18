struct ChessBoard {
    
    var board: [BoardCell] = []
    
    init() {
        initialiseBoard()
    }
    mutating func initialiseBoard() {
        board = []

        for index in 0..<64 {
            let row = index / 8
            let col = index % 8
            var piece: ChessPiece?

            if row == 1 {
                piece = ChessPiece(rank: .pawn, player: .black)
            } else if row == 6 {
                piece = ChessPiece(rank: .pawn, player: .white)
            } else if row == 0 || row == 7 {
                let player: PlayerType = (row == 0) ? .black : .white
                switch col {
                case 0, 7: piece = ChessPiece(rank: .rook, player: player)
                case 1, 6: piece = ChessPiece(rank: .knight, player: player)
                case 2, 5: piece = ChessPiece(rank: .bishop, player: player)
                case 3: piece = ChessPiece(rank: .queen, player: player)
                case 4: piece = ChessPiece(rank: .king, player: player)
                default: break
                }
            }

            board.append(BoardCell(position: Position(row: row, column: col), chessPiece: piece))
        }
    }
    
    func copy() -> ChessBoard {
        var newBoard = ChessBoard()
        newBoard.board = self.board.map { $0.copy() }
        print("📋 Copied board with \(newBoard.board.count) pieces") // Debugging line
        return newBoard
    }



//    func showBoard() {
//        for row in 0..<8 {
//            print("\(8 - row) ", terminator: "")
//            
//            for col in 0..<8 {
//                let index = row * 8 + col
//                let cell = board[index]
//                
//                if let piece = cell.chessPiece {
//                    let symbol = piece.player == .white ? 
//                    print(symbol, terminator: " ")
//                } else {
//                    print(".", terminator: " ")
//                }
//            }
//            print()
//        }
//        print("  A B C D E F G H")
//    }
    
    func getPiece(at position: Position) -> ChessPiece? {
        let index = position.row * 8 + position.column
        return board[index].chessPiece
    }
    
    mutating func movePiece(from: Position, to: Position) -> Bool{
        let fromIndex = from.row * 8 +  from.column
        let toIndex = to.row * 8 + to.column
        
        guard let movingPiece = board[fromIndex].chessPiece else {
            return false
        }
        
        let capturedPiece = board[toIndex].chessPiece
        _ = Move(movedPiece: movingPiece, capturedPiece: capturedPiece, from: from, to: to)
                    
        if isValidMove(from: from, to: to, movingPiece: movingPiece, board: self){
            board[toIndex].chessPiece = movingPiece
            board[fromIndex].chessPiece = nil
            return true
        }
        return false
    }
    
    mutating func setPiece(at position: Position, piece: ChessPiece?) {
            if let index = board.firstIndex(where: { $0.position == position }) {
                board[index].chessPiece = piece
            }
        }

}
