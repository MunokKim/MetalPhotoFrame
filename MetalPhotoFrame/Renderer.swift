//
//  Renderer.swift
//  MetalPhotoFrame
//
//  Created by Munok Kim on 2021/01/27.
//

import MetalKit

class Renderer: NSObject {
    
    // MARK: - Declarations
    
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    var texture: MTLTexture!
    var vertexBuffer: MTLBuffer!
    var numberOfVertices: Int = 0
    var viewportSize: vector_uint2!
    
    var quadVertices: [Vertex] = [
        Vertex(position: vector_float2( 250, -250), textureCoordinate: vector_float2(1, 1)),
        Vertex(position: vector_float2(-250, -250), textureCoordinate: vector_float2(0, 1)),
        Vertex(position: vector_float2(-250,  250), textureCoordinate: vector_float2(0, 0)),
        
        Vertex(position: vector_float2( 250, -250), textureCoordinate: vector_float2(1, 1)),
        Vertex(position: vector_float2(-250,  250), textureCoordinate: vector_float2(0, 0)),
        Vertex(position: vector_float2( 250,  250), textureCoordinate: vector_float2(1, 0))
    ]
    
    // MARK: - Initiatialization
    
    init(device: MTLDevice) {
        super.init()
        
        createCommandQueue(device: device)
        createPipelineState(device: device)
        createBuffers(device: device)
        createTexture(device: device)
    }
    
    //MARK: - Builders
    
    private func createCommandQueue(device: MTLDevice) {
        commandQueue = device.makeCommandQueue()
    }
    
    private func createPipelineState(device: MTLDevice) {
        // The device will make a library for us
        let library = device.makeDefaultLibrary()
        // Our vertex function name
        let vertexFunction = library?.makeFunction(name: "vertexShader")
        // Our fragment function name
        let fragmentFunction = library?.makeFunction(name: "samplingShader")
        // Create basic descriptor
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        // Attach the pixel format that si the same as the MetalView
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        // Attach the shader functions
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        // Try to update the state of the renderPipeline
        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: quadVertices,
                                         length: MemoryLayout<Vertex>.stride * quadVertices.count,
                                         options: [])
    }
    
    private func createTexture(device: MTLDevice) {
        let textureLoader = MTKTextureLoader(device: device)
        
        guard
            let imageUrl: URL = Bundle.main.url(forResource: "wood", withExtension: "tga"),
            let texture = try? textureLoader.newTexture(URL: imageUrl, options: nil)
        else {
            print("Failed to create new texture.")
            return
        }
        
        self.texture = texture
    }
}

// MARK: - MTKViewDelegate

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        print("Drawable size will change 👉🏼 ", size)
        
        // Save the size of the drawable to pass to the vertex shader.
        viewportSize.x = UInt32(size.width)
        viewportSize.y = UInt32(size.height)
    }
    
    func draw(in view: MTKView) {
        // Get the current drawable and descriptor
        guard let drawable = view.currentDrawable,
            let renderPassDescriptor = view.currentRenderPassDescriptor else {
                return
        }
        // Create a buffer from the commandQueue
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        commandEncoder?.setRenderPipelineState(renderPipelineState)
        // Pass in the vertexBuffer into index 0
        commandEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        let memorySize = MemoryLayout.size(ofValue: viewportSize)
        commandEncoder?.setVertexBytes(&viewportSize,
                                       length: memorySize,
                                       index: VertexInputIndex.viewportSize.rawValue)
        commandEncoder?.setFragmentTexture(texture,
                                           index: TextureIndex.baseColor.rawValue)
        commandEncoder?.drawPrimitives(type: .triangle,
                                       vertexStart: 0,
                                       vertexCount: numberOfVertices)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
