//
//  MetalView.swift
//  MetalPhotoFrame
//
//  Created by Munok Kim on 2021/01/27.
//

import MetalKit

class MetalView: MTKView {
    
    var renderer: Renderer!
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        
        self.device = device
        colorPixelFormat = .bgra8Unorm
        clearColor = MTLClearColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        
        createRenderer()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createRenderer() {
        guard let deviceForRender = device
        else { fatalError("Device loading error") }
        
        renderer = Renderer(device: deviceForRender)
        delegate = renderer
    }
}
