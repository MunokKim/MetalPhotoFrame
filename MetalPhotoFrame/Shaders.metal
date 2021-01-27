//
//  Shaders.metal
//  MetalPhotoFrame
//
//  Created by Munok Kim on 2021/01/27.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn
{
    float3 position;
    float4 color;
};

struct VertexOut
{
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut
vertex_function(const device VertexIn *vertices [[ buffer(0) ]],
                uint vertexID [[ vertex_id  ]])
{
    VertexOut out;
    out.position = float4(vertices[vertexID].position,1);
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4
fragment_function(VertexOut in [[ stage_in ]])
{
    return in.color;
}
