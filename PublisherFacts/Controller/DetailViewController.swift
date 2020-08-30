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
    var currentDeviceOrientation: UIDeviceOrientation = .unknown
    fileprivate let imageHelper = ImageHelper()
    var data: ListModel!

    let datsSource = DetailViewDataSource()
    let dataSource = DetailViewDataSource()
    lazy var viewModel: DetailViewModelProtocol = {
        let viewModel = DetailViewModel(withListModel: data, withDataSource: dataSource)
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.dataSource
        self.setupViewModel()
        self.setupUI()
    }

    func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func setupViewModel() {
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        self.viewModel.title.bindAndFire({ [weak self] in
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
