//
//  ThreeSixtyDegreeImageViewVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 20/06/25.
//

import UIKit
import SceneKit

class ThreeSixtyDegreeImageViewVC: UIViewController {
    
    var image: String?
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Three Sixty Image Url -----> \(image ?? "")")
        let sceneView = SCNView(frame: view.bounds)
        view.addSubview(sceneView)
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        if let imageUrl = image, let url = URL(string: imageUrl) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data, let downloadedImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            scene.background.contents = downloadedImage
                        }
                    }
                }.resume()
            }
        
        sceneView.allowsCameraControl = true
     
        backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.backgroundColor = .white
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backButton.layer.cornerRadius = backButton.frame.height / 2
        backButton.BackViewShadowAppyManually(cornerRadius: backButton.layer.cornerRadius)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
   
}
