//
//  ViewController.swift
//  MetalPhotoFrame
//
//  Created by Munok Kim on 2021/01/27.
//

import MetalKit

class ViewController: UIViewController {
    
    let frameThickness: CGFloat = 15.0
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "apple.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let photoFrameView: MetalView = MetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configueViews()
        setConstraints()
    }
    
    private func configueViews() {
        view.addSubview(photoFrameView)
        view.addSubview(photoImageView)
    }
    
    private func setConstraints() {
        photoFrameView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoFrameView.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -frameThickness).isActive = true
        photoFrameView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: frameThickness).isActive = true
        photoFrameView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -frameThickness).isActive = true
        photoFrameView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: frameThickness).isActive = true
        
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
