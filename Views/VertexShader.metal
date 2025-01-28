#include <metal_stdlib>
using namespace metal;

// Must match the layout/order in your Swift `Uniforms` struct
struct Uniforms {
    float2 viewportSize;
    float  dotSpacing;
    float  dotRadius;
    float4 color;
    float  cameraCenterX;
    float  cameraCenterY;
    float  cameraZoom;
};

// Vertex layout must match Swift's `Vertex(position:)`
struct Vertex {
    float2 position [[attribute(0)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

// ----------------------------------------------
// MARK: Vertex Function
// ----------------------------------------------
vertex VertexOut vertexShader(Vertex in                 [[stage_in]],
                              constant Uniforms& uniforms [[buffer(1)]])
{
    VertexOut out;
    // Pass through the vertex position to clip space.
    // We'll draw a full-screen quad from -1 to 1 in X & Y.
    out.position = float4(in.position, 0.0, 1.0);
    out.uv       = in.position;  // You can use this if needed
    return out;
}

// ----------------------------------------------
// MARK: Fragment Function
// ----------------------------------------------
fragment half4 fragmentShader(VertexOut in               [[stage_in]],
                              constant Uniforms& uniforms [[buffer(0)]])
{
    // Example: Just fill with the uniform color
    return half4(uniforms.color);
}
