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
    static let shared = MemeViewModel()
    
    func saveMeme(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage, sentMeme: UIImage) {
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: memeImage, sentMeme: sentMeme)
        memes.append(meme)
    }
}
