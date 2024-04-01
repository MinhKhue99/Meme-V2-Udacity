//
//  Meme.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import Foundation
import SwiftUI

struct Meme: Identifiable {
    let id = UUID()
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memeImage: UIImage?
}
