//
//  MemeTextField.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import SwiftUI

import SwiftUI
import UIKit
struct MemeTextField: View {
    @Binding var meme: String
    var body: some View {
        TextField("", text: $meme, onEditingChanged: { isChanged in
            self.meme = isChanged ? "" : self.meme
        }){}
            .font(.custom("impact", size: 40))
            .foregroundStyle(.white)
            .minimumScaleFactor(0.0001)
            .lineLimit(1, reservesSpace: true)
            .autocapitalization(.allCharacters)
    }
}
