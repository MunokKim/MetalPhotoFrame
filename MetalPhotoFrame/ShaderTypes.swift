//
//  ShaderTypes.swift
//  MetalPhotoFrame
//
//  Created by Munok Kim on 2021/01/29.
//

import simd

struct Vertex {
    var position: vector_float2
    var textureCoordinate: vector_float2
}

enum VertexInputIndex: Int {
    case vertices
    case viewportSize
}

enum TextureIndex: Int {
    case baseColor
}
