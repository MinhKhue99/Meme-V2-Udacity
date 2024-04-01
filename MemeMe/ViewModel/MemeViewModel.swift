//
//  MemeViewModel.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import Foundation
import SwiftUI

class MemeViewModel: ObservableObject {
    @Published var memes = [Meme]()
    @Published var sentMemes = [SentMeme]()
    static let shared = MemeViewModel()
    
    func saveMeme(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: memeImage)
        memes.append(meme)
    }
    
    func saveSentMeme(sentMeme: UIImage) {
        let sentMeme = SentMeme(meme: sentMeme)
        sentMemes.append(sentMeme)
    }
}
