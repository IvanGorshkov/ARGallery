//
//  OnboardingViewController.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 08.05.2022.
//

import UIKit
protocol StartToARDelegate {
    func tapToStart()
}

final class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    var btnGetStarted = UIButton()
    var delegate: StartToARDelegate?
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    var presenter: OnboardingPresenter?

    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }
    
    private func addConstraints() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(btnGetStarted)
        
        self.pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.btnGetStarted.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10).isActive = true
        self.scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 2 + 20).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        
        self.btnGetStarted.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.btnGetStarted.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.btnGetStarted.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
        self.view.layoutIfNeeded()
        self.navigationController?.navigationBar.topItem?.title = TitlesConstants.BackNavTitle
        self.navigationItem.title = "Обучение"
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        btnGetStarted.setTitle("Начать", for: .normal)
        btnGetStarted.setTitleColor(ColorConstants.MainPurpleColor, for: .normal)
        view.backgroundColor = ColorConstants.MainBackGroundColor
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let model = presenter?.getValue()
        for index in 0..<(model?.titles.count ?? 0) {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: model?.imgs[index] ?? ""))
            imageView.frame = CGRect(x:0,y:0,width:view.frame.width,height:200)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 100)
          
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.text = model?.titles[index]
            txt1.textColor = .black
            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:160))
            txt2.textAlignment = .center
            txt2.numberOfLines = 4
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.text = model?.descs[index]
            txt2.sizeToFit()
            txt2.center.x = scrollView.center.x
            txt2.textColor = .black
            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
            pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        }

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(model?.titles.count ?? 0), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = model?.titles.count ?? 0
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .lightGray
        btnGetStarted.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    @objc
    func tap(_ sender: Any) {
        delegate?.tapToStart()
    }
    
    //indicator
    @objc
    func pageChanged(_ sender: Any) {
        scrollView.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl.currentPage)), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView.contentOffset.x)/scrollWidth
        pageControl.currentPage = Int(page)
    }

}
