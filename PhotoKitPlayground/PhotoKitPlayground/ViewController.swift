//
//  ViewController.swift
//  PhotoKitPlayground
//
//  Created by Daichi Hayashi on 2021/03/17.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(results)
    }
}

