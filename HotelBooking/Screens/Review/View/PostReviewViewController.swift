////
////  PostReviewViewController.swift
////  HotelBooking
////
////  Created by ToqSoft on 04/07/25.
////
//


import UIKit
import AVFoundation
import UniformTypeIdentifiers
import PhotosUI

class PostReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate{

    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var writecommentTextView: UITextView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var uploadPhotosView: UIView!
  
    var selectedImages: [UIImage] = []
    var hasUploadedVideo = false
    var currentHorizontalStack: UIStackView?
    let maxItemsPerRow = 3
    let categoriesArray: [String] = ["Overall","Amenities", "Food & Drinks", "Location", "Service", "Value for Money", "Cleanliness"]

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        currentHorizontalStack = horizontalStackView
        for category in categoriesArray {
            let newButton = createButton(title: category)
            addItem(newButton)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
 
    func addItem(_ button: UIButton) {
        if currentHorizontalStack == nil || currentHorizontalStack!.arrangedSubviews.count >= maxItemsPerRow {
            let newHorizontalStack = UIStackView()
            newHorizontalStack.axis = .horizontal
            newHorizontalStack.spacing = 8
            newHorizontalStack.distribution = .fillProportionally
            
            newHorizontalStack.alignment = .fill
            newHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
            
            verticalStackView.addArrangedSubview(newHorizontalStack)
            currentHorizontalStack = newHorizontalStack
        }
        currentHorizontalStack?.addArrangedSubview(button)
    }

    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(clonedButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }

    @objc func clonedButtonTapped(_ sender: UIButton) {
        print("Tapped: \(sender.title(for: .normal) ?? "")")
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
        } else {
            sender.backgroundColor = .clear
            sender.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    @IBAction func backArrowButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addPhotosButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera(forPhoto: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Image from Gallery", style: .default, handler: { _ in
            self.openGallery(forPhoto: true)
        }))

        alert.addAction(UIAlertAction(title: "Choose Video from Gallery", style: .default, handler: { _ in
            self.openGallery(forPhoto: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // For iPad support
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }

        present(alert, animated: true)
    }
    
    func openCamera(forPhoto: Bool) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.mediaTypes =  ["public.image"]
        present(picker, animated: true)
    }

    func openGallery(forPhoto: Bool) {
        if forPhoto {
            // Use PHPicker for multi-image selection
            var config = PHPickerConfiguration()
            config.selectionLimit = 5 - selectedImages.count
            config.filter = .images
            
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true)
        } else {
            guard !hasUploadedVideo else {
                showAlert("Only one video can be uploaded.")
                return
            }
            let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.movie])
            picker.delegate = self
            present(picker, animated: true)
        }
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            addImageToStack(image)
        } else if let videoURL = info[.mediaURL] as? URL {
            let thumbnail = generateThumbnailFromVideo(url: videoURL)
            addImageToStack(thumbnail)
        }
        picker.dismiss(animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }

        // Check file size (in MB)
        do {
            let resourceValues = try url.resourceValues(forKeys: [.fileSizeKey])
            let sizeInBytes = resourceValues.fileSize ?? 0
            let sizeInMB = Double(sizeInBytes) / (1024 * 1024)

            if sizeInMB > 20 {
                showAlert(title:"Add Photo" , message: "Video must be ≤ 20 MB")
                return
            }

            let thumbnail = generateThumbnailFromVideo(url: url)
            addImageToStack(thumbnail)
            hasUploadedVideo = true

        } catch {
            print("Error reading file size: \(error)")
            showAlert("Couldn't read file.")
        }
    }


    func addImageToStack(_ image: UIImage?) {
        uploadPhotosView.isHidden = true
        guard let img = image else { return }
        let imageView = UIImageView(image: img)
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        imageStackView.addArrangedSubview(imageView)
    }

    func generateThumbnailFromVideo(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true

        let time = CMTime(seconds: 1, preferredTimescale: 60)
        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print("Failed to generate thumbnail: \(error)")
            return nil
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension PostReviewViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        if results.isEmpty { return }

        DispatchQueue.main.async {
//            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }

        let group = DispatchGroup()

        for result in results {
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                defer { group.leave() }

                if let image = reading as? UIImage,
                   let compressedData = self.compressImageTo10KB(image),
                   let finalImage = UIImage(data: compressedData) {

                    DispatchQueue.main.async {
                        self.selectedImages.append(finalImage)
                        self.addImageToStack(finalImage)
                    }

                } else {
                    DispatchQueue.main.async {
                        self.showAlert("Image cannot be compressed under 20 KB.")
                    }
                }
            }
        }

        group.notify(queue: .main) {
//            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }

    
    func compressImageTo10KB(_ image: UIImage) -> Data? {
        let maxFileSize = 20 * 1024 // 20 KB
        var compression: CGFloat = 1.0
        let minCompression: CGFloat = 0.1

        // Try reducing compression quality
        while compression >= minCompression {
            if let data = image.jpegData(compressionQuality: compression), data.count <= maxFileSize {
                return data
            }
            compression -= 0.1
        }

        // If still too large, reduce resolution
        var resizedImage = image
        var resizeScale: CGFloat = 0.9

        while resizeScale > 0.1 {
            let newSize = CGSize(width: image.size.width * resizeScale, height: image.size.height * resizeScale)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: CGRect(origin: .zero, size: newSize))
            resizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
            UIGraphicsEndImageContext()

            compression = 1.0
            while compression >= minCompression {
                if let data = resizedImage.jpegData(compressionQuality: compression), data.count <= maxFileSize {
                    return data
                }
                compression -= 0.1
            }

            resizeScale -= 0.1
        }

        return nil // Couldn't compress under 10 KB
    }

}
