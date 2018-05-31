//
//  DetailViewController.swift
//  iOSProficiencyExercise
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = data.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceDidRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.currentDeviceOrientation = UIDevice.current.orientation
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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

extension DetailViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            let cell = tableView.dequeueReusableCell(withIdentifier: portraitReuseIdentifier, for: indexPath) as! PortraitTableViewCell
            cell.descriptionLabel.text = data.description
            imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL:data.imageRef, atIndexPath: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as! LandscapeTableViewCell
            cell.descriptionLabel.text = data.description
            imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL:data.imageRef, atIndexPath: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
}

// MARK: - TableViewDelegate Setup
extension DetailViewController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

// MARK: - UIScrollViewDelegate
extension DetailViewController {
    func loadImagesForOnscreenRows() {
        let visiblePaths = tableView.indexPathsForVisibleRows ?? [IndexPath]()
        for indexPath in visiblePaths {
            let cell = tableView(self.tableView, cellForRowAt: indexPath)
            imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: data.imageRef, atIndexPath: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}
