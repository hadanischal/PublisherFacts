//
//  FeedsViewController.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    let segueIdentifier = "toDetailViewController"
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 2
    private let refreshControl = UIRefreshControl()
    fileprivate var service: FeedsService! = FeedsService()
    let dataSource = FeedsDataSource()
    lazy var viewModel: FeedsViewModelProtocol = {
        let viewModel = FeedsViewModel(withService: service, withDataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.collectionView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        self.viewModel.title.bindAndFire({ [weak self] in
            self?.title = $0
        })
        self.setupUIRefreshControl()
        self.serviceCall()

    }

    func setupUIRefreshControl() {
        refreshControl.addTarget(self, action: #selector(serviceCall), for: UIControl.Event.valueChanged)
        self.collectionView.addSubview(refreshControl)

    }
    @objc func serviceCall() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.viewModel.fetchServiceCall { result in
                switch result {
                case .success :
                    break
                case .failure :
                    break
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        refreshControl.endRefreshing()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            if let controller = segue.destination as? DetailViewController {
                let data = viewModel.selectedData
                controller.data = data
            }
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FeedsViewController: UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionView.backgroundColor = ThemeColor.collectionViewBackgroundColor
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItemAt(indexPath: indexPath)
        self.performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 21
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: UISCROLLVIEW DELEGATE
extension FeedsViewController {
    // MARK: - Lazy Loading of cells
    func loadImagesForOnscreenRows() {
        self.collectionView.reloadData()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}
