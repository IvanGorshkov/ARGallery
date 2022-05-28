//
//  AllViewController.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import UIKit
import AVFoundation
import NVActivityIndicatorView

final class AllViewController: UIViewController, UICollectionViewDelegateFlowLayout, SegmentedControlDelegate {
    func segmentedControlDidChange(index: Int) {
        segmentedControlDelegate?.segmentedControlDidChange(index: index)
    }
    
	private let output: AllViewOutput
    let searchBar = UISearchBar()
    var segmentedControlDelegate: SegmentedControlDelegate?
    internal var emptySearchView = EmptyCartView(titleText: "По вашему запросу ничего не найдено", subtitleText: "Попробуйте ввести что-то другое")
    
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    private var activityIndicatorView: NVActivityIndicatorView!
    private lazy var waitTyping: WaitTyping = WaitTyping()
    internal var interfaceSegmented: MUISegmentedControl?
    
    init(output: AllViewOutput, segmentedControlDelegate: SegmentedControlDelegate?) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        if let segmentedControlDelegate = segmentedControlDelegate {
            self.segmentedControlDelegate = segmentedControlDelegate
            interfaceSegmented = MUISegmentedControl()
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSegmentedControl() {
        interfaceSegmented?.setButtonTitles(buttonTitles: ["Все", "Идут", "Прошли"])
        interfaceSegmented?.selectorViewColor = ColorConstants.MainPurpleColor
        interfaceSegmented?.selectorTextColor =  ColorConstants.MainPurpleColor
        interfaceSegmented?.backgroundColor = .clear
        interfaceSegmented?.delegate = self
        if let interfaceSegmented = interfaceSegmented {
           view.addSubview(interfaceSegmented)
        }
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setUp()
        output.viewDidLoad()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = output.getTitle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addConstraintsCollectionView()
       //reloadLayout()
    }

    private func setUp() {
        self.emptySearchView.isHidden = true
        setUpBase()
        setUpcollectionViewBase()
        setUpIndicator()
        setUpSearchBar()
        setUpSegmentedControl()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func setUpcollectionViewBase() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        collectionView.register(AllCollectionViewCell.self, forCellWithReuseIdentifier: AllCollectionViewCell.cellIdentifier)
    }
    
    private func setUpBase() {
        [searchBar, collectionView, emptySearchView].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
        self.view.backgroundColor = ColorConstants.MainBackGroundColor
        self.navigationController?.navigationBar.topItem?.title = TitlesConstants.BackNavTitle
        self.title = output.getTitle()
    }

    func setUpSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "поиск..."
        self.searchBar.setupSearchBar(
            background: ColorConstants.MainBackGroundColor,
            inputText: ColorConstants.BlackColor,
            placeholderText: ColorConstants.LightGrey
        )
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

extension AllViewController: AllViewInput {

    
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

extension AllViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getCountCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllCollectionViewCell.cellIdentifier, for: indexPath)
                as? AllCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(model: output.getCell(at: indexPath.row)) {
            let myCell = collectionView.cellForItem(at: indexPath)
            return cell == myCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.itemSelected(id: indexPath.row)
    }
}

// MARK: MosaicLayoutDelegate
extension AllViewController: MosaicLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForImageAtIndexPath indexPath: IndexPath,
        withWidth width: CGFloat,
        complition: (CGFloat) -> Void) {
        let item = output.getCell(at: indexPath.row)
        guard let model = item as? HorizontalViewModel else { return }
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio:
                                CGSize(
                                    width: CGFloat(model.width),
                                    height: CGFloat(model.height)
                                ), insideRect: boundingRect)
        complition(rect.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let item = output.getCell(at: indexPath.row)
        guard let model = item as? HorizontalViewModel else { return 0 }
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

extension AllViewController: UISearchBarDelegate {
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
