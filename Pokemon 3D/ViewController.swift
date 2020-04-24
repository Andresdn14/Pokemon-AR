//
//  ViewController.swift
//  Pokemon 3D
//
//  Created by Andres Felipe De La Ossa Navarro on 4/11/20.
//  Copyright © 2020 Andres Felipe De La Ossa Navarro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        
       sceneView.autoenablesDefaultLighting = true
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        if  let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
         configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
            print("Images Succesfully added")
            
        }
        
       

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
          
           plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            let model = (imageAnchor.referenceImage.name == "kyurem-card") ? "whitekyurem.scn" : "riolu.scn"
           if let pokeScene = SCNScene(named: "art.scnassets/\(model)") {
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = .pi / 2
                    planeNode.addChildNode(pokeNode)
                }
            }
        }
        
        return node
        
    }
}
