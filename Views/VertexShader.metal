#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float2 position [[attribute(0)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

struct Uniforms {
    float2 viewportSize;
    float dotSpacing;
    float dotRadius;
    float4 color;
    float cameraCenterX;
    float cameraCenterY;
    float cameraZoom;
};

vertex VertexOut vertexShader(const device Vertex *vertices [[buffer(0)]],
                              constant Uniforms &uniforms [[buffer(1)]],
                              uint vid [[vertex_id]]) {
    VertexOut out;
    out.position = float4(vertices[vid].position, 0.0, 1.0);
    out.uv = vertices[vid].position * 0.5 + 0.5;
    return out;
}

fragment float4 fragmentShader(VertexOut in [[stage_in]],
                               constant Uniforms &uniforms [[buffer(0)]]) {
    float2 uv = in.uv * uniforms.viewportSize;
    
    // Apply camera transformation
    float2 worldPos = (uv - uniforms.viewportSize * 0.5) / uniforms.cameraZoom +
    float2(uniforms.cameraCenterX, uniforms.cameraCenterY);
    
    // Calculate grid position
    float2 gridPos = fmod(worldPos, uniforms.dotSpacing);
    gridPos = gridPos - uniforms.dotSpacing * 0.5;
    
    // Calculate distance to nearest dot center
    float dist = length(gridPos);
    
    // Create dot
    float dot = 1.0 - smoothstep(uniforms.dotRadius - 0.5, uniforms.dotRadius + 0.5, dist);
    
    return float4(uniforms.color.rgb, uniforms.color.a * dot);
}
