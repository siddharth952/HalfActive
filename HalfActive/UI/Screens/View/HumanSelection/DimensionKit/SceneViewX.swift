//
//  SceneViewX.swift
//  HalfActive
//
//  Created by Siddharth S on 18/05/25.
//

import SceneKit
import SwiftUI

enum Model3D: String {
    case bodybuilder = "Bodybuilder_Man.usdc"
}

// MARK: - Model3DView
/// View to render a 3D model or scene.
///
/// This view utilizes SceneKit to render a 3D model or a SceneKit scene.
/// ```swift
/// Model3DView(named: "duck.gltf")
///     .transform(scale: 0.5)
///     .camera(PerspectiveCamera())
/// ```
///
/// - Note: It is advised to keep the number of `Model3DView`s simultaneously on screen to a minimum.
struct SceneViewRepresentable: UIViewRepresentable {
    @Binding var selectedPart: String?
    @Binding var zoomedPartName: String?

    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = SCNScene(named: Model3D.bodybuilder.rawValue)
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.backgroundColor = .clear
        
        
        addTapGesture(to: scnView)

        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if let part = zoomedPartName {
            zoomTo(nodeNamed: part, in: uiView)
        }
        
//        if let node = uiView.scene?.rootNode.childNode(withName: Model3D.bodybuilder.rawValue, recursively: true) {
//            let action = SCNAction.rotateBy(
//                x: .zero,
//                y: CGFloat(GLKMathDegreesToRadians(360)),
//                z: .zero,
//                duration: 5
//            )
//            let forever = SCNAction.repeatForever(action)
//            node.runAction(forever)
//        }
    }
    
    //MARK: Methods

    private func addTapGesture(to scnView: SCNView) {
        let tap = UITapGestureRecognizer(target: scnView, action: #selector(scnView.hdlTap))
        scnView.addGestureRecognizer(tap)
        print(tap)
        scnView.handleTapAction = { hitPart in
            selectedPart = hitPart
            zoomedPartName = hitPart
            zoomTo(nodeNamed: hitPart, in: scnView)
        }
        
    }

    private func zoomTo(nodeNamed name: String, in scnView: SCNView) {
        guard let scene = scnView.scene,
              let targetNode = scene.rootNode.childNode(withName: name, recursively: true) else {
            print("Node not found: \(name)")
            return
        }

        // Create camera if missing
        if scnView.pointOfView == nil {
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            scene.rootNode.addChildNode(cameraNode)
            scnView.pointOfView = cameraNode
        }

        guard let cameraNode = scnView.pointOfView else { return }

        // Remove existing constraints
        cameraNode.constraints = []

        // 1. Look at the target node
        let lookAt = SCNLookAtConstraint(target: targetNode)
        lookAt.isGimbalLockEnabled = true
        cameraNode.constraints = [lookAt]

        // 2. Move camera near the target node (in front of it)
        let direction = SCNVector3Make(1, 1, 2.0) // offset distance from target
        let targetWorldPosition = targetNode.worldPosition
        let newCameraPosition = SCNVector3(
            targetWorldPosition.x + direction.x,
            targetWorldPosition.y + direction.y,
            targetWorldPosition.z + direction.z
        )

        let moveAction = SCNAction.move(to: newCameraPosition, duration: 1.5)
        moveAction.timingMode = .easeInEaseOut
        cameraNode.runAction(moveAction)
    }

}


extension SCNView {
    
    private struct AssociatedKeys {
        static var handleTapAction = "handleTapAction"
    }
    
    var handleTapAction: ((String) -> Void)? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.handleTapAction) as? ((String) -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.handleTapAction, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func hdlTap(_ gesture: UITapGestureRecognizer) {

        
        let location = gesture.location(in: self)
        let hitResults = hitTest(location, options: [:])
        
        for result in hitResults {
            print("Hit node: \(result.node.name ?? "Unnamed")")
        }
        
        if let firstHit = hitResults.first {
            let nodeName = firstHit.node.name ?? "Unknown"
            handleTapAction?(nodeName)
        }
    }
}
