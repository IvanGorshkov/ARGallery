//
//  DescriptionViewController.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 24.03.2022.
//  
//

import UIKit

final class DescriptionViewController: UIViewController {
	private let output: DescriptionViewOutput
    internal var tableView =  UITableView()

    init(output: DescriptionViewOutput) {
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

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addConstraintTableView()
    }

    private func setUp() {
        setUpBase()
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBase()
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
    }
}

extension DescriptionViewController: DescriptionViewInput {
    func updateForSections() {
        output.sectionDelegate = self
        self.tableView.reloadData()
    }
}

extension DescriptionViewController: UITableViewDataSource {
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

extension DescriptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(output.getCellHeight(at: indexPath.row))
    }
}

extension DescriptionViewController: ItemDescCellViewOutput {
    func clickFav(isSelected: Bool) {

    }
    
    func clickAR() {
        self.output.goToAR()
    }

    func openFullScreen(silder: UIView) {
        output.openFullScreen(slider: silder)
    }
}
