//
//  MetalView.swift
//  MetalPhotoFrame
//
//  Created by eazel5 (Munok) on 2021/01/27.
//

import MetalKit

class MetalView: MTKView {
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        
        self.device = device
        colorPixelFormat = .bgra8Unorm
        clearColor = MTLClearColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
