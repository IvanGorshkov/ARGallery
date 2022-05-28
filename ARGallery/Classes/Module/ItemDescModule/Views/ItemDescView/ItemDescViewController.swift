//
//  ItemDescViewController.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.1021.
//  
//

import UIKit
import NVActivityIndicatorView

final class ItemDescViewController: UIViewController {
	private let output: ItemDescViewOutput
    internal var tableView =  UITableView()
    private var activityIndicatorView: NVActivityIndicatorView!

    init(output: ItemDescViewOutput) {
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
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        output.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraintTableView()
    }

    private func setUp() {
        setUpBase()
        setUpTableView()
        setUpIndicator()
        addNavigationButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBase()
        self.navigationItem.title = TitlesConstants.PaintingNavTitle
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

    private func setUpBase() {
        self.view.backgroundColor = ColorConstants.MainBackGroundColor
        self.navigationController?.navigationBar.topItem?.title = TitlesConstants.BackNavTitle
        self.title = TitlesConstants.PaintingNavTitle
    }

    private func setUpTableView() {
        setUpTableViewBase()
        registerCells()
    }

    private func setUpTableViewBase() {
            self.view.addSubview(tableView)
            tableView.backgroundColor = .clear
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsSelection = false
            tableView.tableHeaderView = UIView()
    }

    private func registerCells() {
        tableView.register(ItemNameCell.self, forCellReuseIdentifier: ItemNameCell.cellIdentifier)
        tableView.register(ItemSliderCell.self, forCellReuseIdentifier: ItemSliderCell.cellIdentifier)
        tableView.register(AboutDescCell.self, forCellReuseIdentifier: AboutDescCell.cellIdentifier)
        tableView.register(SpecificationsDescCell.self, forCellReuseIdentifier: SpecificationsDescCell.cellIdentifier)
        tableView.register(ButtonsDescCell.self, forCellReuseIdentifier: ButtonsDescCell.cellIdentifier)
    }
    
    private func addNavigationButton() {
        let button = UIBarButtonItem(
            image: .init(systemName: "arrowshape.turn.up.right.fill"),
            style: .plain, target: self,
            action: #selector(clickShare)
        )
        button.tintColor = ColorConstants.MainPurpleColor
        navigationItem.rightBarButtonItem = button
    }
    
    @objc
    private func clickShare() {
        output.clickShare()
    }
}

extension ItemDescViewController: ItemDescViewInput {
    func updateForSections() {
        activityIndicatorView.stopAnimating()
        output.sectionDelegate = self
        self.tableView.reloadData()
    }
}

extension ItemDescViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCountCells()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: output.getCellIdentifier(at: indexPath.row),
            for: indexPath) as? BaseCell else {
                return UITableViewCell()
            }
        cell.model = output.getCell(at: indexPath.row)
        return cell
    }
}

extension ItemDescViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(output.getCellHeight(at: indexPath.row))
    }
}

extension ItemDescViewController: ItemDescCellViewOutput {
    func clickFav(isSelected: Bool) {
        output.clickFav(isSelected: isSelected)
    }
    
    func clickAR() {
        self.output.goToAR()
    }

    func openFullScreen(silder: UIView) {
        output.openFullScreen(slider: silder)
    }
}
