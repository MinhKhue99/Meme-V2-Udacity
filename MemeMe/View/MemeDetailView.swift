//
//  DetailView.swift
//  MemeMe
//
//  Created by KhuePM on 02/04/2024.
//

import SwiftUI

struct MemeDetailView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    let meme: Meme
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: meme.memeImage ?? meme.sentMeme)
                .resizable()
                .scaledToFill()
                .frame(width: verticalSizeClass == .regular ? UIScreen.main.bounds.width : UIScreen.main.bounds.width / 2, height: verticalSizeClass == .regular ? 350 : UIScreen.main.bounds.height / 2)
        }
    }
}
