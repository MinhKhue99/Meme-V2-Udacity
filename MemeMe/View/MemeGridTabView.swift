//
//  MemeGridTabView.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import SwiftUI

struct MemeGridTabView: View {
    let columns = [GridItem(.adaptive(minimum: 80))]
    @EnvironmentObject private var memeViewModel: MemeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geo in
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ], spacing: 3) {
                        ForEach(memeViewModel.sentMemes, id: \.self) { sentMeme in
                            Image(uiImage: sentMeme.meme)
                                .resizable()
                                .frame(width: geo.size.width / 3, height: geo.size.width / 3)
                        }
                    }
                }
            }
        }
    }
}

