//
//  MainTabView.swift
//  MemeMe
//
//  Created by KhuePM on 25/03/2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
    @State private var isShowNewMemeView = false
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                MemeListTabView()
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(0)
                MemeGridTabView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "square.grid.3x3.fill")
                    }
                    .tag(1)
            }
            .navigationTitle("Sent Memes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {
                        // TODO:  Handle edit meme
                    }, label: {
                        Text("Edit")
                    })
                    .opacity(selectedIndex == 0 ? 1.0 : 0.0)
                    .disabled(selectedIndex == 0 ? false : true)
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        isShowNewMemeView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .fullScreenCover(isPresented: $isShowNewMemeView, content: {
                        NewMemeView(showSheetView: $isShowNewMemeView)
                    })
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
