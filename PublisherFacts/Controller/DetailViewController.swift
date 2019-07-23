//
//  DetailViewController.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/25/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate let portraitReuseIdentifier = "PortraitTableViewCell"
    fileprivate let landscapeReuseIdentifier = "LandscapeTableViewCell"
    var currentDeviceOrientation: UIDeviceOrientation = .unknown
    fileprivate let imageHelper = ImageHelper()
    var data: ListModel!
    
    var viewModel: DetailViewModelProtocol? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
    }
    
    func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func setupViewModel() {
        self.viewModel = DetailViewModel(withListModel: data)
        self.viewModel?.title.bindAndFire({ [weak self] in
            self?.title = $0
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate), name: UIDevice.orientationDidChangeNotification, object: nil)
        self.currentDeviceOrientation = UIDevice.current.orientation
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        if UIDevice.current.isGeneratingDeviceOrientationNotifications {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
    }
    
    @objc func deviceDidRotate(notification: NSNotification) {
        self.currentDeviceOrientation = UIDevice.current.orientation
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1: PortraitTableViewCell?
        if UIDevice.current.orientation.isPortrait {
            cell1 = tableView.dequeueReusableCell(withIdentifier: portraitReuseIdentifier, for: indexPath) as? PortraitTableViewCell
        } else {
             cell1 = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as? PortraitTableViewCell
        }
        
        guard let cell = cell1 else {
            assertionFailure("PortraitTableViewCell not found")
            return UITableViewCell()
        }
        
        self.viewModel?.description.bindAndFire {
            cell.descriptionLabel.text = $0
        }
        
        self.viewModel?.imageHref.bindAndFire({ [weak self] imageUrl in
            if let imageUrl = imageUrl {
                self?.imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: imageUrl, atIndexPath: indexPath)
            }
        })
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

// MARK: - TableViewDelegate Setup
extension DetailViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - UIScrollViewDelegate
extension DetailViewController {
    func loadImagesForOnscreenRows() {
        let visiblePaths = tableView.indexPathsForVisibleRows ?? [IndexPath]()
        for indexPath in visiblePaths {
            let cell = tableView(self.tableView, cellForRowAt: indexPath)
            if let imageUrl = data.imageHref {
                imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: imageUrl, atIndexPath: indexPath)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}
