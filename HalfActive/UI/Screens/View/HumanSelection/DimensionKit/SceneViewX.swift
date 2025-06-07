//
//  SceneViewX.swift
//  HalfActive
//
//  Created by Siddharth S on 18/05/25.
//

import SceneKit
import SwiftUI

enum Model3D: String {
    case bodybuilder = "Bodybuilder_Man.obj"
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
        scnView.allowsCameraControl = false
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
        }
    }

    private func zoomTo(nodeNamed name: String, in scnView: SCNView) {
        guard let node = scnView.scene?.rootNode.childNode(withName: name, recursively: true) else { return }
        let zoomAction = SCNAction.scale(to: 1.5, duration: 0.3)
        node.runAction(zoomAction)
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
        if let firstHit = hitResults.first {
            let nodeName = firstHit.node.name ?? "Unknown"
            handleTapAction?(nodeName)
        }
    }
}
