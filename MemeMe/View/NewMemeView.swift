//
//  NewMemeView.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import SwiftUI

struct NewMemeView: View {
    @EnvironmentObject private var memeViewModel: MemeViewModel
    @State private var selectedImage = UIImage()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showSheet = false
    @State private var memeImage: Image?
    @FocusState private var isForcused: Bool
    @State private var topText = "TOP"
    @State private var bottomText = "BOTTOM"
    var originalImage = UIImage(named: "image-black")!
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.dismiss) var dismiss
    @Binding var showSheetView: Bool
    @State private var isShare = false
    func loadImage() {
        memeImage = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack {
            
            topView
            
            Spacer()
            
            centerView
            
            Spacer()
            
            bottomView
            
        }
        .background(Color.black)
        .sheet(isPresented: $showSheet, onDismiss: loadImage) {
            ImagePicker(sourceType: sourceType, selectedImage: self.$selectedImage)
        }
    }
}

extension NewMemeView {
    
    private var topView: some View {
        ZStack {
            BlurView(style: .systemChromeMaterial)
                .frame(width: UIScreen.main.bounds.width, height: 40)
            HStack {
                //share
                if memeImage != nil {
                    Button(action: {
                        isShare.toggle()
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
                    .background(SharingViewController(isPresenting: $isShare) {
                        let screenshot = centerView.snapshot()
                        let activityVC = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
                        
                        // For iPad
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            activityVC.popoverPresentationController?.sourceView = UIView()
                        }
                        
                        activityVC.completionWithItemsHandler = { (_, completed:
                                                                    Bool, _, error: Error?) in
                            if completed {
                                memeViewModel.saveMeme(topText: topText, bottomText: bottomText, originalImage: originalImage, memeImage: selectedImage)
                                memeViewModel.saveSentMeme(sentMeme: screenshot)
                                isShare = false
                                debugPrint("share completed")
                                dismiss()
                            } else {
                                debugPrint("cancel")
                            }
                        }
                        return activityVC
                    }
                    )
            } else {
                Image(systemName: "square.and.arrow.up")
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            //cancel
            Button(action: {
                topText = "TOP"
                bottomText = "BOTTOM"
                memeImage = Image(uiImage: originalImage)
                dismiss()
            }, label: {
                Text("Cancel")
            })
        }
        .padding(verticalSizeClass == .regular ? 10 : 40)
        .frame(width: UIScreen.main.bounds.width, height: 20)
    }
}

private var centerView: some View {
    ZStack {
        if let memeImage = memeImage {
            memeImage
                .resizable()
                .scaledToFill()
                .frame(width: verticalSizeClass == .regular ? UIScreen.main.bounds.width : UIScreen.main.bounds.width / 2, height: verticalSizeClass == .regular ? 350 : UIScreen.main.bounds.height / 2)
        }
        VStack {
            Spacer()
            MemeTextField(meme: $topText)
                .glowBorder(color: .black, lineWidth: 3)
                .focused($isForcused)
            
            Spacer()
            
            MemeTextField(meme: $bottomText)
                .glowBorder(color: .black, lineWidth: 3)
                .focused($isForcused)
            Spacer()
        }
        .foregroundColor(Color.white)
        .font(Font.system(size: 50, design: .default))
        .multilineTextAlignment(.center)
    }
}

private var bottomView: some View {
    ZStack {
        BlurView(style: .systemChromeMaterial)
            .frame(width: UIScreen.main.bounds.width, height: 40)
        HStack {
            //select image from camera
            Button(action: {
                sourceType = .camera
                showSheet.toggle()
            }, label: {
                Image(systemName: "camera")
            })
            .padding()
            .disabled(isSimulator() ? true : false)
            
            
            //select image from photo
            Button(action: {
                sourceType = .photoLibrary
                showSheet.toggle()
            }, label: {
                Text("Album")
            })
            .padding()
        }
        .padding(verticalSizeClass == .regular ? 10 : 40)
        .frame(width: UIScreen.main.bounds.width, height: 20)
    }
}
}

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
    }
    
}

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

struct SharingViewController: UIViewControllerRepresentable {
    @Binding var isPresenting: Bool
    var content: () -> UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresenting {
            uiViewController.present(content(), animated: true, completion: nil)
        }
    }
}



//#Preview {
//    NewMemeView()
//}
