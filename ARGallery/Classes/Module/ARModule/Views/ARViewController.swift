//
//  ARViewController.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 12.03.2022.
//

import UIKit
import ARKit

final class ARViewController: UIViewController, ARSessionDelegate {
    private let output: ARViewOutput
    internal var sceneView = ARSCNView()
    internal var scanningLabel = UILabel()
    internal var foundLabel = UILabel()
    internal var magicButton = UIButton()
    private var touchDifference = SCNVector3()
    private let configuration = ARWorldTrackingConfiguration()
    private var grids = [Grid]()
    
    init(output: ARViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        animateFlash(label: scanningLabel)
        self.output.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraintsAR()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        sceneView.session.run(configuration)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [scanningLabel, foundLabel].forEach({ [weak self] in self?.setCornerRadius(view: $0)
        })
    }
    
    private func setCornerRadius(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.cornerRadius = view.frame.height / 2
    }
    
    private func setUp() {
        [sceneView, scanningLabel, foundLabel, magicButton].forEach({ [weak self] in
            self?.view.addSubview($0)
        })
        setUpBase()
        setUpLabel(label: scanningLabel, text: TitlesConstants.SearchingWall)
        setUpLabel(label: foundLabel, text: TitlesConstants.WallFouned)
        setUpButton()
        setUpSceneView()
        registerGestureRecognizers()
    }
    private func setUpBase() {
        self.navigationController?.navigationBar.topItem?.title = TitlesConstants.BackNavTitle
        self.title = TitlesConstants.AR
    }
    
    private func setUpLabel(label: UILabel, text: String, isHidden: Bool = true) {
        label.layer.masksToBounds = true
        label.backgroundColor = .gray.withAlphaComponent(0.4)
        label.text = text
        label.alpha = isHidden ? 0 : 1
        label.textAlignment = .center
    }
    
    private func setUpButton() {
        self.magicButton.setImage(UIImage(named: "magic"), for: .normal)
        self.magicButton.addTarget(self, action: #selector(openEditFrame), for: .touchUpInside)
    }
    
    private func setUpSceneView() {
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        configuration.planeDetection = .vertical
        sceneView.session.delegate = self
    }
    
    @objc
    private func openEditFrame() {
        
    }
    
    private func animateFlash(label: UILabel) {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            label.alpha = 1
        }, completion: nil)
    }
    
    private func animatefadeOut(label: UILabel) {
        UIView.animate(withDuration: 1,
                       delay: 0.6,
                       options: [],
                       animations: {
            label.alpha = 0
        }, completion: nil)
    }
    
    private func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc
    private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        let touchPosition = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlaneUsingExtent)
        guard let hitTest = hitTestResults.first,
              let anchor = hitTest.anchor as? ARPlaneAnchor,
              let gridIndex = grids.firstIndex(where: { $0.anchor == anchor })
        else { return }
        hangPicture(atLocation: hitTest, grids[gridIndex])
    }
    
    @objc
    private func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        let touchLocation = recognizer.location(in: recognizer.view)
        let hitTestResults = self.sceneView.hitTest(touchLocation, options: nil)
        if var tappedNode = hitTestResults.first?.node {
            if tappedNode.childNodes.isEmpty, let parant = tappedNode.parent {
                tappedNode = parant
            }
            
            AudioServicesPlaySystemSound(1520)
            tappedNode.removeFromParentNode()
        }
    }
    
    @objc
    private func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let touchLocation = recognizer.location(in: recognizer.view)
        
        guard let query = sceneView.raycastQuery(from: touchLocation, allowing: .existingPlaneInfinite, alignment: .vertical) else {return}
        let results = sceneView.session.raycast(query)
        guard let result = results.first else {return}
        
        let hitTestResults = self.sceneView.hitTest(touchLocation, options: nil)
        if var tappedNode = hitTestResults.first?.node {
            if tappedNode.name == "grid" { return }
            if tappedNode.childNodes.isEmpty, let parant = tappedNode.parent {
                tappedNode = parant
            }
            if recognizer.state == .began {
                touchDifference = SCNVector3Make(
                    result.worldTransform.columns.3.x - tappedNode.position.x,
                    result.worldTransform.columns.3.y - tappedNode.position.y,
                    result.worldTransform.columns.3.z - tappedNode.position.z)
            }
            let newPosition = SCNVector3Make(
                result.worldTransform.columns.3.x - touchDifference.x,
                result.worldTransform.columns.3.y - touchDifference.y,
                result.worldTransform.columns.3.z - touchDifference.z
            )
                tappedNode.position = newPosition
        }
    }
    
    private func hangPicture(atLocation hitResult: ARHitTestResult, _ grid2: Grid) {
        guard let hitResultAnchor = hitResult.anchor else { return }
        sceneView.scene.rootNode.childNodes.forEach { elem in
            elem.removeFromParentNode()
        }
        let pictureNode = createPicture()
        let frameDepth = CGFloat(0.03)
        let frameNode = createFrame(depth: CGFloat(frameDepth))
        
        frameNode.transform = SCNMatrix4(hitResultAnchor.transform)
        frameNode.name = "frame"
        frameNode.eulerAngles = SCNVector3(frameNode.eulerAngles.x + (-Float.pi / 2), frameNode.eulerAngles.y, frameNode.eulerAngles.z)
        
        let location = hitResult.worldTransform.columns.3
        frameNode.position = SCNVector3(
            x: location.x,
            y: location.y,
            z: location.z + Float(frameDepth/2)
        )
        
        frameNode.addChildNode(pictureNode)
        
        pictureNode.position = SCNVector3(
            x: 0,
            y: 0,
            z: Float(frameDepth/2)+0.001)
        
        sceneView.scene.rootNode.addChildNode(frameNode)
        grid2.removeFromParentNode()
    }
    
    private func createFrame(depth frameDepth: CGFloat) -> SCNNode {
        guard let arModel = self.output.getARViewModel() else { return SCNNode() }
        let frameBox = SCNBox(
            width: arModel.ARborderThickness.w,
            height: arModel.ARborderThickness.h,
            length: frameDepth,
            chamferRadius: arModel.ARborderRounded)
        setFrameMaterial(frameBox: frameBox)
        configureMaterialLight(plane: frameBox, lightingModel: .physicallyBased, contents: UIColor(white: 0.7, alpha: 1.0))
        return SCNNode(geometry: frameBox)
    }
    
    private func setFrameMaterial(frameBox: SCNGeometry) {
        guard let arModel = self.output.getARViewModel() else { return }
        frameBox.materials.last?.diffuse.contents = UIImage(named: "art.scnassets/\(arModel.ARmaterial)Color.jpg")
        frameBox.materials.last?.normal.contents = UIImage(named: "art.scnassets/\(arModel.ARmaterial)Normal.jpg")
        frameBox.materials.last?.roughness.contents = UIImage(named: "art.scnassets/\(arModel.ARmaterial)Roughness.jpg")
    }
    
    private func setNewFrameConfig(frameBox: SCNGeometry) {
        guard let frameBox = frameBox as? SCNBox, let arModel = self.output.getARViewModel() else { return }
        frameBox.chamferRadius = arModel.ARborderRounded
        frameBox.width = arModel.ARborderThickness.w
        frameBox.height = arModel.ARborderThickness.h
    }
    
    private func createPicture() -> SCNNode {
        guard let arModel = self.output.getARViewModel() else { return SCNNode() }
        let picture = SCNPlane(width: arModel.ARwidth, height: arModel.ARheight)
        picture.firstMaterial?.diffuse.contents = arModel.ARpic
        configureMaterialLight(plane: picture, lightingModel: .blinn, contents: UIColor(white: 0.2, alpha: 1.0))
        return SCNNode(geometry: picture)
    }
    
    private func configureMaterialLight(plane: SCNGeometry, lightingModel: SCNMaterial.LightingModel, contents: Any, shininess: CGFloat = 100) {
        plane.firstMaterial?.lightingModel = lightingModel
        plane.firstMaterial?.specular.contents = contents
        plane.firstMaterial?.shininess = shininess
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        sceneView.session.pause()
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            self.scanningLabel.removeFromSuperview()
            self.foundLabel.isHidden = false
            self.foundLabel.alpha = 1
            self.animatefadeOut(label: self.foundLabel)
        }
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//        let planeNode = createPlane(withPlaneAnchor: planeAnchor)
//        node.addChildNode(planeNode)
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = Grid(anchor: planeAnchor)
        self.grids.append(grid)
        node.addChildNode(grid)
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        print("hello")
//        guard let currentFrame = session.currentFrame?.camera else { return }
//        let transform = currentFrame.transform
//        session.setWorldOrigin(relativeTransform: transform )
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
            }.first
        
        guard let foundGrid = grid else {
            return
        }
        
        foundGrid.update(anchor: planeAnchor)
    }
    
    private func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        let planeNode = SCNNode()
        planeNode.isHidden = true
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        planeNode.geometry = plane
        return planeNode
    }
}

extension ARViewController: ARViewInput {
    func runSession() {
        sceneView.session.run(configuration)
    }
    func loadModel(arModel: ARViewModelDescription?) {
        sceneView.scene.rootNode.childNodes.forEach { node in
            if node.name == "frame" {
                guard let geometry = node.geometry else { return }
                setFrameMaterial(frameBox: geometry)
                setNewFrameConfig(frameBox: geometry)
            }
        }
    }
}
