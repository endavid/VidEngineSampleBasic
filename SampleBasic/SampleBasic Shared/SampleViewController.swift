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
        cube.lightingType = .UnlitOpaque
        cube.transform.position = [0, 0, -5]
        cube.queue(renderer)
        self.cube = cube
    }
    
    override func update(_ elapsed: TimeInterval) {
        super.update(elapsed)
        angle += Float(elapsed)
        cube?.transform.rotation = Quaternion(AngleAxis(angle: angle, axis: normalize([1, 1, 0])))
    }
}
