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
    
    let photoFrameView: UIView = UIView(frame: .zero)
    
    let topMetalView: MetalView = MetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())
    let leftMetalView: MetalView = MetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())
    let rightMetalView: MetalView = MetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())
    let bottomMetalView: MetalView = MetalView(frame: .zero, device: MTLCreateSystemDefaultDevice())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configueViews()
        setConstraints()
    }
    
    private func configueViews() {
        view.addSubview(photoFrameView)
        view.addSubview(topMetalView)
        view.addSubview(leftMetalView)
        view.addSubview(rightMetalView)
        view.addSubview(bottomMetalView)
        view.addSubview(photoImageView)
    }
    
    private func setConstraints() {
        photoFrameView.translatesAutoresizingMaskIntoConstraints = false
        topMetalView.translatesAutoresizingMaskIntoConstraints = false
        leftMetalView.translatesAutoresizingMaskIntoConstraints = false
        rightMetalView.translatesAutoresizingMaskIntoConstraints = false
        bottomMetalView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        photoFrameView.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: -frameThickness).isActive = true
        photoFrameView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: frameThickness).isActive = true
        photoFrameView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: -frameThickness).isActive = true
        photoFrameView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: frameThickness).isActive = true
        
        topMetalView.topAnchor.constraint(equalTo: photoFrameView.topAnchor).isActive = true
        topMetalView.leadingAnchor.constraint(equalTo: photoFrameView.leadingAnchor).isActive = true
        topMetalView.trailingAnchor.constraint(equalTo: photoFrameView.trailingAnchor).isActive = true
        topMetalView.bottomAnchor.constraint(equalTo: photoImageView.topAnchor).isActive = true
        
        leftMetalView.topAnchor.constraint(equalTo: topMetalView.bottomAnchor).isActive = true
        leftMetalView.leadingAnchor.constraint(equalTo: photoFrameView.leadingAnchor).isActive = true
        leftMetalView.trailingAnchor.constraint(equalTo: photoImageView.leadingAnchor).isActive = true
        leftMetalView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        
        rightMetalView.topAnchor.constraint(equalTo: photoImageView.topAnchor).isActive = true
        rightMetalView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor).isActive = true
        rightMetalView.trailingAnchor.constraint(equalTo: photoFrameView.trailingAnchor).isActive = true
        rightMetalView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        
        bottomMetalView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        bottomMetalView.leadingAnchor.constraint(equalTo: photoFrameView.leadingAnchor).isActive = true
        bottomMetalView.trailingAnchor.constraint(equalTo: photoFrameView.trailingAnchor).isActive = true
        bottomMetalView.bottomAnchor.constraint(equalTo: photoFrameView.bottomAnchor).isActive = true
        
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
