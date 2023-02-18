//
//  ContentView.swift
//  FaceTracking
//
//  Created by 藤治仁 on 2023/02/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FaceTrackingViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let sceneView = viewModel.sceneView {
                    ARSceneView(sceneView: sceneView)
                        .opacity(0.0)
                }
                
                if let message = viewModel.message {
                    Text(message)
                        .font(.largeTitle)
                }
                // Color(.white)
                
                Image(systemName: "eyes")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .position(viewModel.pointerLocation)
            }
            .onAppear {
                viewModel.screenSize.width = geometry.size.width
                viewModel.screenSize.height = geometry.size.height
                viewModel.pointerLocation = CGPoint(x: viewModel.screenSize.width / 2.0, y: viewModel.screenSize.height / 2.0)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
