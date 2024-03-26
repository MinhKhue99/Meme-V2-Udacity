//
//  Extension.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import Foundation
import SwiftUI

func isSimulator() -> Bool {
#if targetEnvironment(simulator)
    return true
#else
    return false
#endif
}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func glowBorder(color: Color, lineWidth: Int) -> some View {
            self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
        }
}
