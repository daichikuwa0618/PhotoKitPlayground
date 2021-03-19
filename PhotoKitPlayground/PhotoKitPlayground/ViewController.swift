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
        let photoLibrary: PHPhotoLibrary = .shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
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

        guard let firstResult = results.first else { return }

        // 以下、どちらを使っても imageView に選択した画像が反映される。
        assignImage(from: firstResult.assetIdentifier)
//        assignImage(from: firstResult.itemProvider)
    }

    /// `assetIdentifier` から UIImage を取得して、 imageView に反映させる
    private func assignImage(from id: String?) {
        guard let id = id,
              let firstObject = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil).firstObject else { return }

        PHImageManager().requestImage(for: firstObject,
                                      targetSize: imageView.frame.size,
                                      contentMode: .aspectFit,
                                      options: nil) { [weak self] (image, info) in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }

    /// `itemProvider` から UIImage を取得して、 imageView に反映させる
    private func assignImage(from provider: NSItemProvider) {
        guard provider.canLoadObject(ofClass: UIImage.self) else { return }

        provider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
            DispatchQueue.main.async {
                self?.imageView.image = image as? UIImage
            }
        }
    }
}

