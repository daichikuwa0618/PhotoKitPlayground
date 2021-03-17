//
//  ViewController.swift
//  PhotoKitPlayground
//
//  Created by Daichi Hayashi on 2021/03/17.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    private var imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()

        let picker = generatePhotoPicker()
        picker.delegate = self

        present(picker, animated: true)
    }

    private func generatePhotoPicker() -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0

        let picker = PHPickerViewController(configuration: configuration)

        return picker
    }

    private func setupImageView() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    }
}

