//
//  ARGalleryViewController.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import UIKit
import SceneKit
import ARKit
import NVActivityIndicatorView

final class ARGalleryViewController: UIViewController, ARSessionDelegate {
    
    private let output: ARGalleryViewOutput
    private var sceneView =  ARSCNView()
    private var activityIndicatorView: NVActivityIndicatorView!
    var videoNode: SKVideoNode?
    var videoPlayer: AVPlayer?
    var observer: NSObjectProtocol?
    init(output: ARGalleryViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
        setUpIndicator()
        sceneView.delegate = self
        sceneView.session.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped(touch:)))
        self.sceneView.addGestureRecognizer(gestureRecognizer)
        
        
        view.backgroundColor = ColorConstants.MainBackGroundColor
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    private func setUpIndicator() {
        var frameCenter = view.center
        frameCenter.x -= 25
        frameCenter.y -= 25
        activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(origin: frameCenter, size: CGSize(width: 50, height: 50)),
            type: .ballScale,
            color: ColorConstants.MainPurpleColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = ""
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        self.videoPlayer?.pause()
        self.videoPlayer = nil
        self.observer = nil
    }
    
    private func addConstraints() {
        view.addSubview(sceneView)
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.sceneView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ARGalleryViewController: ARGalleryViewInput {
    func getImages(newReferenceImages: Set<ARReferenceImage>) {
        activityIndicatorView.stopAnimating()
        configuration.detectionImages = newReferenceImages;
        configuration.maximumNumberOfTrackedImages = 1;
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    func session(_ session: ARSession, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - ARSCNViewDelegate
extension ARGalleryViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let imageAnchor = anchor as? ARImageAnchor else {return}
            if let url = self.output.linkIfExist(name: imageAnchor.name!) {
                let videoItem = AVPlayerItem(url: url)
                
                self.videoPlayer = AVPlayer(playerItem: videoItem)
                self.videoNode = SKVideoNode(avPlayer: self.videoPlayer!)
            
                self.observer = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: nil) { (notification) in
                    self.videoPlayer?.seek(to: CMTime.zero)
                    self.videoPlayer?.play()
                }
                let size = self.output.videoSize(name: imageAnchor.name!)
                let videoScene = SKScene(size: CGSize(width: size.0, height: size.1))
                self.videoNode?.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
                self.videoNode!.yScale = -1.0
                videoScene.addChild(self.videoNode!)
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -Float.pi / 2
                planeNode.categoryBitMask = 0b000000001
                node.addChildNode(planeNode)
            }
            
            let infoLabel = SCNPlane(width: 0.1, height: 0.1)
            infoLabel.firstMaterial?.diffuse.contents = UIImage(named: "info")
            let planeNode = SCNNode(geometry: infoLabel)
            planeNode.position = SCNVector3(
                x: Float(imageAnchor.referenceImage.physicalSize.width) / 2 + 0.1,
                y: 0,
                z: 0
            )
            planeNode.eulerAngles.x = -Float.pi / 2
            planeNode.name =  imageAnchor.name!
            planeNode.categoryBitMask = 0b10000000
            node.addChildNode(planeNode)
        }
    }
    
    @objc func boxTapped(touch: UITapGestureRecognizer) {
        let sceneView = touch.view as! SCNView
        let touchLocation = touch.location(in: sceneView)
        
        let touchResults = sceneView.hitTest(touchLocation, options: [:])
        
        guard !touchResults.isEmpty, let node = touchResults.first?.node else { return }
        if node.categoryBitMask == 0b10000000 {
            self.sceneView.session.pause()
            self.videoPlayer?.pause()
            output.openPainting(name: node.name!)
        }
    }
    
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = (anchor as? ARImageAnchor) else { return }
            guard let children = node.childNodes.filter({ child in
                return child.categoryBitMask == 0b00000001
            }).first else {
                self.videoPlayer?.pause()
                return
            }
        if imageAnchor.isTracked {
            self.videoPlayer?.play()
        } else {
            node.removeFromParentNode()
            self.sceneView.session.remove(anchor: anchor)
            self.videoPlayer?.pause()
            self.videoPlayer = nil
            self.observer = nil
        }
    }
}

