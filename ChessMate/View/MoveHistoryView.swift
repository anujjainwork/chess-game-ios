//
//  MoveHistoryView.swift
//  ChessMate
//
//  Created by Anuj Jain on 08/02/25.
//

import SwiftUI

struct MoveHistoryView: View {
    
    @ObservedObject var gameViewModel : ChessBoardViewModel
    
    var body: some View{
        VStack(alignment: .leading) {
                    Text("Move History")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    List(gameViewModel.getMoveHistory(), id: \.self) { move in
                        Text(move)
                            .font(.body)
                    }
                }
                .padding()
    }
}


struct MoveHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MoveHistoryView(gameViewModel: ChessBoardViewModel())
    }
}

