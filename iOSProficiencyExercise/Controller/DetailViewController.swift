//
//  DetailViewController.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/25/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit


final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    fileprivate let portraitReuseIdentifier = "PortraitTableViewCell"
    fileprivate let landscapeReuseIdentifier = "LandscapeTableViewCell"
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!
    
    private let kLazyLoadCollectionCellImage = 1
    private let kLazyLoadCollectionCellText = 2
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate let imageManager = ImageManager()
    
    // data
    var data: ListModel!
    
}

extension DetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = data.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// MARK: - UITableViewDataSource

extension DetailViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as! LandscapeTableViewCell
        cell.descriptionLabel.text = data.description
        updateImageForCell(cell, inTableView: tableView, imageURL:data.imageRef, atIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
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


extension DetailViewController {
    
    func updateImageForCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath) {
        // clean image first
        let imageView = cell.viewWithTag(kLazyLoadCollectionCellImage) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        // load image.
        imageManager.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
    func loadImagesForOnscreenRows() {
            let visiblePaths = tableView.indexPathsForVisibleRows ?? [IndexPath]()
            for indexPath in visiblePaths {
                let cell = tableView(self.tableView, cellForRowAt: indexPath)
                updateImageForCell(cell, inTableView: tableView, imageURL: data.imageRef, atIndexPath: indexPath)
            }
        }
    
    // MARK: - When decelerated or ended dragging, we must update visible rows
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }

    
}
