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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pictureTake.layer.cornerRadius = 8
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(loadDate(_:)), for: .valueChanged)
        //collectionView.refreshControl = refreshControl
        bindViewModel()
//        viewModel.showLoader
//        .bind(to: refreshControl.rx.isRefreshing)
//        .disposed(by: disposeBag)
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
                cell.picture.kf.setImage(with: provider)
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        imagePicker = .init()
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func loadDate(_ sender: Any) {
        viewModel.fetchIssue(issueId: viewModel.issue.id ?? "") { (newIssue) in
            
        }
    }
    
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PictureCell
        
        let viewController = DTPhotoViewerController(referencedView: cell.picture, image: cell.picture.image)
        viewController.dataSource = self
        present(viewController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {

            (viewController.scrollView as! UICollectionView).scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
        
    }
}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            viewModel.upload(image: image)
        }
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
        let provider = JIRAImageProvider(url: photo!)
        imageView.kf.indicatorType = .activity
        
        var image: UIImage? = nil
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? PictureCell {
            image = cell.picture.image
        }
        imageView.kf.setImage(with: provider, placeholder: image)
        
    }
    
    
}
