//
//  DrawResignView.swift
//  ChessMate
//
//  Created by Anuj Jain on 18/02/25.
//

import SwiftUI

struct DrawResignView: View {
    @Binding var drawConfirmation : Bool
    @Binding var resignConfirmation : Bool
    var body: some View {
        HStack{
            Image("draw-button")
                .onTapGesture {
                    drawConfirmation = !drawConfirmation
                }
            Image("resign-button")
                .onTapGesture {
                    resignConfirmation = !resignConfirmation
                }
        }
    }
}
