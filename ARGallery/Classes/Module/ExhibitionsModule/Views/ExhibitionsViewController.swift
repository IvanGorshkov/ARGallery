//
//  CompilationViewController.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import UIKit
import AVFoundation
import NVActivityIndicatorView

final class ExhibitionsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    private let output: ExhibitionsViewOutput
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    private var activityIndicatorView: NVActivityIndicatorView!
    let searchBar = UISearchBar()
    private lazy var waitTyping: WaitTyping = WaitTyping()
    internal var emptySearchView = EmptyCartView(titleText: "По вашему запросу ничего не найдено", subtitleText: "Попробуйте ввести что-то другое")
    
    init(output: ExhibitionsViewOutput) {
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
        addConstraintsCollectionView()
        reloadLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpBase()
    }
    
    private func setUp() {
        self.emptySearchView.isHidden = true
        setUpBase()
        setUpcollectionViewBase()
        setUpIndicator()
        addNavigationButton()
        setUpSearchBar()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func setUpSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "поиск..."
        self.searchBar.setupSearchBar(
            background: ColorConstants.MainBackGroundColor,
            inputText: ColorConstants.BlackColor,
            placeholderText: ColorConstants.LightGrey
        )
    }
    
    @objc
    private func favoriteButtonAction() {
        output.openDescription()
    }
    
    private func addNavigationButton() {
        let button = UIBarButtonItem(image: .init(named: "i"), style: .plain, target: self, action: #selector(favoriteButtonAction))
        button.tintColor = ColorConstants.MainPurpleColor
        navigationItem.rightBarButtonItem = button
    }
    
    private func setUpcollectionViewBase() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        collectionView.register(VCollectionViewCell.self, forCellWithReuseIdentifier: VCollectionViewCell.cellIdentifier)
    }
    
    private func setUpBase() {
        [searchBar, collectionView, emptySearchView].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        self.view.backgroundColor = ColorConstants.MainBackGroundColor
        self.navigationController?.navigationBar.topItem?.title = TitlesConstants.BackNavTitle
        self.navigationItem.title = output.getTitle()
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
    
    private func reloadLayout() {
        let layout = MosaicViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ExhibitionsViewController: ExhibitionsViewInput {
    func reloadData() {
        activityIndicatorView.stopAnimating()
        if output.getCountCells() == 0 {
            self.emptySearchView.isHidden = false
            self.collectionView.isHidden = true
        } else {
            self.emptySearchView.isHidden = true
            self.collectionView.isHidden = false
            collectionView.reloadData()
            print(output.getCountCells())
            reloadLayout()
        }
    }
}

extension ExhibitionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getCountCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: output.getCellIdentifier(at: indexPath.row), for: indexPath)
                as? VCollectionViewCell else {
                    return UICollectionViewCell()
                }
        cell.configure(model: output.getCell(at: indexPath.row), complition: {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.itemSelected(id: indexPath.row)
    }
}

// MARK: MosaicLayoutDelegate
extension ExhibitionsViewController: MosaicLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForImageAtIndexPath indexPath: IndexPath,
        withWidth width: CGFloat,
        complition: (CGFloat) -> Void) {
            let item = output.getCell(at: indexPath.row)
            guard let model = item as? VerticalViewModel else { return }
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio:
                                    CGSize(
                                        width: CGFloat(model.frameWidth),
                                        height: CGFloat(model.frameHeight)
                                    ), insideRect: boundingRect)
            complition(rect.height)
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForDescriptionAtIndexPath indexPath: IndexPath,
        withWidth width: CGFloat) -> CGFloat {
        let item = output.getCell(at: indexPath.row)
        guard let model = item as? VerticalViewModel else { return 0 }
        let descriptionHeight = heightForText(model.name, width: width-24)
        let height = 4 + 17 + 4 + descriptionHeight
        return height
    }
    
    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let rect = NSString(string: text).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return ceil(rect.height)
    }
}


extension ExhibitionsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        waitTyping.perform(after: 0.5) {
            self.output.enterText(text: searchText)
        }
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.output.enterText(text: "")
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
