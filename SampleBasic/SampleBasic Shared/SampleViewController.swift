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
    
    override func update(_ elapsed: TimeInterval) {
        super.update(elapsed)
        angle += Float(elapsed)
        cube?.transform.rotation = Quaternion(AngleAxis(angle: angle, axis: normalize([1, 1, 0])))
    }
}
