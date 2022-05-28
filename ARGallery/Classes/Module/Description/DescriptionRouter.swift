//
//  DescriptionRouter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 24.03.2022.
//  
//

import UIKit

final class DescriptionRouter: StartToARDelegate {
    private var vc: DescriptionViewInput?
    private var id: Int?
}

extension DescriptionRouter: DescriptionRouterInput {
    func openFullScreen(from vc: DescriptionViewInput?, silder: UIView?) {
         guard let view = vc as? DescriptionViewController, let silder = silder as? ImageSlideshow  else { return }
        silder.presentFullScreenController(from: view)
    }
    func tapToStart() {
         guard let view = vc as? DescriptionViewController else { return }
        let ar = ARGalleryContainer.assemble(with: ARGalleryContext(id: id ?? 0))
        let navController = UINavigationController(rootViewController: ar.viewController)
        view.dismiss(animated: false)
        view.present(navController, animated:true, completion: nil)
    }
    
    func openAR(from vc: DescriptionViewInput?, id: Int) {
        self.vc = vc
        self.id = id
        guard let view = vc as? DescriptionViewController else { return }
        let resolver = OnboardingResolverImpl()
        resolver.storageName = "ARGallery"
        resolver.needToShow { isNeeded in
            if isNeeded {
                let vc = OnboardingViewController()
                vc.delegate = self
                vc.presenter = OnboardingPresenterARGallery()
                let navController = UINavigationController(rootViewController: vc)
                view.present(navController, animated:true, completion: nil)
            } else {
                guard let view = vc as? DescriptionViewController else { return }
               let ar = ARGalleryContainer.assemble(with: ARGalleryContext(id: id ?? 0))
               let navController = UINavigationController(rootViewController: ar.viewController)
               view.present(navController, animated:true, completion: nil)
            }
        }
    }
}
