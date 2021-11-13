//
//  PhotosViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit
import OAuthSwift
import RxCocoa
import RxSwift
import DTPhotoViewerController

class PhotosViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pictureTake: UIButton!
    
    let cellIdentifier = "PictureCell"
    
    var viewModel: PhotosViewModel!
    var imagePicker: UIImagePickerController!
    let refreshControl = UIRefreshControl()
    let disposeBag = DisposeBag()
    
    var pdfData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pictureTake.layer.cornerRadius = 8
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(loadDate(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let columns = CGFloat(3)
            let spacing = CGFloat(1)
            
            let width = (collectionView.bounds.width - (columns * spacing)) / columns
            layout.itemSize = CGSize(width: width, height: width)
            
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
        }
    }
    
    func bindViewModel() {
        viewModel.photos.bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier)) { (index, photo, cell) in
            
            if let cell = cell as? PictureCell {
                let provider = JIRAImageProvider(url: photo.thumb)
                var isPDF = false;
                if (self.viewModel.issue.fields?.attachment!.count ?? 0 > index) {
                    isPDF = (self.viewModel.issue.fields?.attachment?[index].mimeType.debugDescription)!.lowercased().contains("pdf")
                }
                if isPDF {
                    cell.nameArea.isHidden = false
                    cell.picture.image = UIImage.init(named: "pdf_icon")
                    cell.nameLabel.text = self.viewModel.issue.fields?.attachment?[index].filename
                    provider.data { result in
                    switch result {
                        case .success(let data):
                            self.pdfData = data
                        case .failure(let error):
                                self.pdfData = nil
                            print(error);
                            }
                        
                    }
                } else {
                    guard let imageURL = URL(string: photo.thumb) else { return }

                            // just not to cause a deadlock in UI!
                        DispatchQueue.global().async {
                            guard let imageData = try? Data(contentsOf: imageURL) else { return }

                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                cell.picture.image = image
                            }
                        }
//                    cell.picture.kf.setImage(with: provider)
                    cell.nameArea.isHidden = true
                }
            }
        }.disposed(by: disposeBag)
        
        viewModel.showLoader
        .bind(to: refreshControl.rx.isRefreshing)
        .disposed(by: disposeBag)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        imagePicker = .init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let camAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(camAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        if ( UI_USER_INTERFACE_IDIOM() == .pad ){

            if let currentPopoverpresentioncontroller = alertController.popoverPresentationController{
                currentPopoverpresentioncontroller.permittedArrowDirections = []
                currentPopoverpresentioncontroller.sourceRect = CGRect(x: (self.view.bounds.midX), y: (self.view.bounds.midY), width: 0, height: 0)
                currentPopoverpresentioncontroller.sourceView = self.view
                self.present(alertController, animated: true, completion: nil)
            }
        }else{
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @objc func loadDate(_ sender: Any) {
        viewModel.fetchIssue(issueId: viewModel.issue.id ?? "") { (newIssue) in
            self.viewModel.issue = newIssue
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var isPDF = false;
        if (self.viewModel.issue.fields?.attachment!.count ?? 0 > indexPath.row) {
            isPDF = (self.viewModel.issue.fields?.attachment?[indexPath.row].mimeType.debugDescription)!.lowercased().contains("pdf")
        }
        if isPDF {
            let pdfLink = viewModel.issue.fields?.attachment?[indexPath.row].content
//            let pdfVC = PDFViewerCV()
//            pdfVC.pdfLink = pdfLink!
//            pdfVC.pdfData = self.pdfData
            
            let pdfVC = PDFLoadViewController(nibName: "PDFLoadViewController", bundle: nil)
            pdfVC.pdfLink = pdfLink!
            pdfVC.modalPresentationStyle = .fullScreen
            present(pdfVC, animated: true)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! PictureCell
            
            let viewController = PhotoVController(referencedView: cell.picture, image: cell.picture.image)
            viewController.dataSource = self
            viewController.scrollView.isScrollEnabled = false
            present(viewController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                (viewController.scrollView as! UICollectionView).scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: {
            guard let image = info[.editedImage] as? UIImage else { return }
            
            let alertController = UIAlertController(title: "Save in Gallery", message: "Do you want to save this photo to gallery and upload it later?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Upload Now", style: .default) { action in
                self.viewModel.upload(image: image)
            }
            let noAction = UIAlertAction(title: "Upload Later", style: .default) { action in
                alertController.dismiss(animated: true, completion: nil)
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true)
        })
        
    }
}

extension PhotosViewController: DTPhotoViewerControllerDataSource {
    
    func numberOfItems(in photoViewerController: DTPhotoViewerController) -> Int {
        return collectionView.numberOfItems(inSection: 0)
    }
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, referencedViewForPhotoAt index: Int) -> UIView? {
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = self.collectionView?.cellForItem(at: indexPath) as? PictureCell {
            return cell.picture
        }
            
        return nil
    }
    
    func photoViewerController(_ photoViewerController: DTPhotoViewerController, configurePhotoAt index: Int, withImageView imageView: UIImageView) {
        
        let photo = try? viewModel.photos.value()[index].original

		guard let url = URL(string: photo ?? "") else {
			return
		}
		
		var image: UIImage? = nil
		if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? PictureCell {
			image = cell.picture.image
		}

		imageView.kf.setImage(with: url, placeholder: image, options: [.requestModifier(ImageDownloadTokenManager())]) { (result) in
			print(result)
		}
    }
    
    
}
