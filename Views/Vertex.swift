//
//  Vertex.swift
//  WorkSpace
//
//  Created by Zimo Luo on 1/28/25.
//

import MetalKit
import SwiftUI

// MARK: - Shader Types

struct Vertex {
    var position: SIMD2<Float>
}

struct Uniforms {
    var viewportSize: SIMD2<Float>
    var dotSpacing: Float
    var dotRadius: Float
    var color: SIMD4<Float>
    var cameraCenterX: Float
    var cameraCenterY: Float
    var cameraZoom: Float
}

// MARK: - Metal Renderer

class MetalDotsRenderer {
    private var device: MTLDevice
    private var commandQueue: MTLCommandQueue
    private var pipelineState: MTLRenderPipelineState
    private var vertexBuffer: MTLBuffer
    
    init() {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue()
        else {
            fatalError("Metal is not supported on this device")
        }
        
        self.device = device
        self.commandQueue = commandQueue
        
        // Create vertices for a quad that covers the entire viewport
        let vertices = [
            Vertex(position: SIMD2<Float>(-1, -1)),
            Vertex(position: SIMD2<Float>(1, -1)),
            Vertex(position: SIMD2<Float>(-1, 1)),
            Vertex(position: SIMD2<Float>(1, 1))
        ]
        
        guard let vertexBuffer = device.makeBuffer(bytes: vertices,
                                                   length: vertices.count * MemoryLayout<Vertex>.stride,
                                                   options: .storageModeShared)
        else {
            fatalError("Failed to create vertex buffer")
        }
        self.vertexBuffer = vertexBuffer
        
        // Create the render pipeline
        let library = try! device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "vertexShader")
        let fragmentFunction = library?.makeFunction(name: "fragmentShader")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.colorAttachments[0].isBlendingEnabled = true
        pipelineDescriptor.colorAttachments[0].rgbBlendOperation = .add
        pipelineDescriptor.colorAttachments[0].alphaBlendOperation = .add
        pipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
        pipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = .sourceAlpha
        pipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
        pipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha
        
        do {
            self.pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            fatalError("Failed to create pipeline state: \(error)")
        }
    }
    
    func render(in view: MTKView, color: Color, viewSize: CGSize, cameraCenterX: CGFloat, cameraCenterY: CGFloat, cameraZoom: CGFloat) {
        guard let commandBuffer = commandQueue.makeCommandBuffer(),
              let renderPassDescriptor = view.currentRenderPassDescriptor,
              let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        else {
            return
        }
        
        var uniforms = Uniforms(
            viewportSize: SIMD2<Float>(Float(viewSize.width), Float(viewSize.height)),
            dotSpacing: 50.0,
            dotRadius: 1.0,
            color: color.toSIMD4Float(),
            cameraCenterX: Float(cameraCenterX),
            cameraCenterY: Float(cameraCenterY),
            cameraZoom: Float(cameraZoom)
        )
        
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.setVertexBytes(&uniforms, length: MemoryLayout<Uniforms>.size, index: 1)
        renderEncoder.setFragmentBytes(&uniforms, length: MemoryLayout<Uniforms>.size, index: 0)
        renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
        
        renderEncoder.endEncoding()
        
        if let drawable = view.currentDrawable {
            commandBuffer.present(drawable)
        }
        
        commandBuffer.commit()
    }
}

// MARK: - Metal View

struct MetalView: UIViewRepresentable {
    var color: Color
    var viewSize: CGSize
    var cameraCenterX: CGFloat
    var cameraCenterY: CGFloat
    var cameraZoom: CGFloat
    
    private let renderer = MetalDotsRenderer()
    
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.framebufferOnly = true
        mtkView.delegate = context.coordinator
        mtkView.enableSetNeedsDisplay = true
        mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        mtkView.colorPixelFormat = .bgra8Unorm
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        context.coordinator.color = color
        context.coordinator.viewSize = viewSize
        context.coordinator.cameraCenterX = cameraCenterX
        context.coordinator.cameraCenterY = cameraCenterY
        context.coordinator.cameraZoom = cameraZoom
        uiView.setNeedsDisplay()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(renderer: renderer)
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        let renderer: MetalDotsRenderer
        var color: Color = .black
        var viewSize: CGSize = .zero
        var cameraCenterX: CGFloat = 0
        var cameraCenterY: CGFloat = 0
        var cameraZoom: CGFloat = 1
        
        init(renderer: MetalDotsRenderer) {
            self.renderer = renderer
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
        
        func draw(in view: MTKView) {
            renderer.render(in: view,
                            color: color,
                            viewSize: viewSize,
                            cameraCenterX: cameraCenterX,
                            cameraCenterY: cameraCenterY,
                            cameraZoom: cameraZoom)
        }
    }
}

extension Color {
    func toSIMD4Float() -> SIMD4<Float> {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        return SIMD4<Float>(
            Float(components[0]),
            Float(components[1]),
            Float(components[2]),
            Float(components[3])
        )
    }
}
