//
//  MainViewController.swift
//  MilliArt
//
//  Created by Alekhin Sergey on 28.10.2021.
//  
//

import UIKit
import NVActivityIndicatorView

final class MainViewController: UIViewController {
	private let output: MainViewOutput
    internal var tableView =  UITableView()
    private var activityIndicatorView: NVActivityIndicatorView!
    
    init(output: MainViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setUp()
        output.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraintTableView()
    }

    private func setUp() {
        setNavigationPicture()
        setUpTableView()
        setUpIndicator()
        
        self.view.backgroundColor = ColorConstants.MainBackGroundColor
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    private func setUpTableView() {
        setUpTableViewBase()
        registerCells()
    }

    private func setUpIndicator() {
        var frameCenter = view.center
        frameCenter.x -= 25
        frameCenter.y -= 25
        activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(origin: frameCenter, size: CGSize(width: 50, height: 50)),
            type: .ballScale,
            color: ColorConstants.MainPurpleColor)
    }
    
    private func setUpTableViewBase() {
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableHeaderView = UIView()
        tableView.separatorStyle = .none
    }

    private func registerCells() {
        tableView.register(HeaderCellView.self, forCellReuseIdentifier: HeaderCellView.cellIdentifier)
        tableView.register(HCollectionViewTableViewCell.self, forCellReuseIdentifier: HCollectionViewTableViewCell.cellIdentifier)
        tableView.register(VCollectionViewTableViewCell.self, forCellReuseIdentifier: VCollectionViewTableViewCell.cellIdentifier)
    }


    private func setNavigationPicture() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "MainTabBar")
        imageView.image = image
        navigationItem.titleView = imageView
    }

    @objc
    private func favoriteButtonAction() {
    }
}

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
        output.sectionDelegate = self
        activityIndicatorView.stopAnimating()
    }
}

extension MainViewController: TableViewCellOutput {
    func clickOnAuthor(with id: Int) {
        output.clickOnExebition(with: id)
    }
    
    func clickOnCompilation(with id: Int) {
        output.clickOnMuseum(with: id)
    }
    
    func clickOnArt(with id: Int) {
        output.clickOnArt(with: id)
    }
    
    func clickAllCompilation() {
        output.goToAllCompilation()
    }

    func clickAllAuthor() {
        output.goToAllAuthor()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCountCells()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: output.getCellIdentifier(at: indexPath.row), for: indexPath)
                as? BaseCell else {
                    return UITableViewCell()
                }
        cell.model = output.getCell(at: indexPath.row)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(output.getCellHeight(at: indexPath.row))
    }
}
