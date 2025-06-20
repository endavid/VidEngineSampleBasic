//
//  SampleViewController.swift
//  SampleBasic
//
//  Created by David Gavilan Ruiz on 19/06/2025.
//
import VidEngine
import Foundation
import simd

class SampleViewController: VidController {
    var cube: CubePrimitive?
    var angle: Float = 0
    
    override func onAppear() {
        let cube = CubePrimitive(renderer: renderer, instanceCount: 1)
        cube.lightingType = .unlitOpaque
        cube.transform.position = [0, 0, -5]
        cube.queue(renderer)
        self.cube = cube
        spawnPlanes(count: 5)
        initTextDemo()
    }
    
    func spawnPlanes(count: Int) {
        let plane = PlanePrimitive(instanceCount: count)
        plane.material.diffuse = LinearRGBA(r: 0.5, g: 1, b: 1, a: 0.5)
        plane.lightingType = .unlitTransparent
        plane.transform.scale = [2, 1, 1]
        plane.transform.rotation = Quaternion(AngleAxis(angle: 1.57, axis: normalize([1, 0, 0])))
        for i in 0..<count {
            plane.instances[i].transform.position = [0, 0, -4.5 - 0.5 * Float(i)]
        }
        plane.queue(renderer)
    }
    
    func initTextDemo() {
        let fontName = "HoeflerText-Regular"
        guard let font = VidFont(name: fontName, size: 72) else {
            NSLog("Font not found: \(fontName)")
            return
        }
        if let fontAtlas = try? FontAtlas.createFontAtlas(font: font, textureSize: 2048, archive: false) {
            let makeItStand = Quaternion(AngleAxis(angle: .pi / 2, axis: simd_float3(1,0,0)))
            let tiltToOneSide = Quaternion(AngleAxis(angle: .pi / 4, axis: simd_float3(0,1,0)))
            let prim = TextPrimitive(instanceCount: 1, font: fontAtlas, text: "Hello World! :)", fontSizeMeters: 1, enclosingFrame: CGRect(x: -2, y: -5, width: 4, height: 10))
            prim.transform.position = simd_float3(0,0,-22)
            prim.transform.rotation = tiltToOneSide * makeItStand
            prim.queue(renderer)
            // debug the font atlas
            let debugPanel = PlanePrimitive(instanceCount: 1)
            debugPanel.lightingType = .unlitTransparent
            debugPanel.transform = Transform(position: simd_float3(-4, 2, -20), scale: simd_float3(4,1,4), rotation: makeItStand)
            debugPanel.albedoTexture = try? fontAtlas.getFontTexture(renderer)
            debugPanel.queue(renderer)
        } else {
            NSLog("Error initializing FontAtlas")
        }
    }
    
    override func update(_ elapsed: TimeInterval) {
        super.update(elapsed)
        angle += Float(elapsed)
        cube?.transform.rotation = Quaternion(AngleAxis(angle: angle, axis: normalize([1, 1, 0])))
    }
}
