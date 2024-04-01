//
//  MemeListTabView.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import SwiftUI

struct MemeListTabView: View {
   @EnvironmentObject private var memeViewModel: MemeViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(memeViewModel.memes) {meme in
                    HStack(alignment: .center) {
                        Image(uiImage: meme.memeImage ?? meme.originalImage)
                            .resizable()
                            .frame(width: 120, height: 120)
                        Text("\(meme.topText)...\(meme.bottomText)")
                            .foregroundStyle(Color("Textcolor"))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .padding()
                }
            }
        }
    }
}
