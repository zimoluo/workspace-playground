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
    
    float2 worldPos = (uv - uniforms.viewportSize * 0.5) / uniforms.cameraZoom +
    float2(uniforms.cameraCenterX, -uniforms.cameraCenterY);
    
    float2 offset = floor(worldPos / uniforms.dotSpacing);
    float2 gridPos = worldPos - (offset * uniforms.dotSpacing);
    gridPos = gridPos - uniforms.dotSpacing * 0.5;
    
    float adjustedRadius = uniforms.dotRadius;
    float radiusZoomProduct = uniforms.dotRadius * uniforms.cameraZoom;
    
    if (radiusZoomProduct < 1.35) {
        adjustedRadius = 1.35 / uniforms.cameraZoom;
    } else if (radiusZoomProduct > 1.55) {
        adjustedRadius = 1.55 / uniforms.cameraZoom;
    }
    
    float dist = length(gridPos);
    
    if (dist < adjustedRadius) {
        return float4(uniforms.color.rgb, uniforms.color.a);
    } else {
        return float4(0.0, 0.0, 0.0, 0.0);
    }
}

