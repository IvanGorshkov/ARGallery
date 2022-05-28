//
//  ItemDescRouter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 28.10.2021.
//  
//

import UIKit

final class ItemDescRouter {
    private var vc: ItemDescViewInput?
    private var arModel: PaintingARModel?
}

extension ItemDescRouter: ItemDescRouterInput, StartToARDelegate {
    func tapToStart() {
        guard let view = vc as? UIViewController, let arModel = arModel else { return }
        let itemDesc = ARContainer.assemble(with: ARContext(arModel: arModel))
        
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
        
        let VCCount = view.navigationController!.viewControllers.count
        view.navigationController?.viewControllers.removeSubrange(VCCount-2..<VCCount - 1)
    }
    
    func goToAR(from vc: ItemDescViewInput?, arModel: PaintingARModel?) {
        self.vc = vc
        guard let view = vc as? UIViewController else { return }
        self.arModel = arModel
        let resolver = OnboardingResolverImpl()
        resolver.storageName = "ARHome"
        resolver.needToShow { isNeeded in
            if isNeeded {
                let vc = OnboardingViewController()
                vc.delegate = self
                vc.presenter = OnboardingPresenterARHome()
                view.navigationController?.pushViewController(vc, animated: true)
            } else {
                tapToStart()
            }
        }
    }

    func openFullScreen(from vc: ItemDescViewInput?, silder: UIView?) {
         guard let view = vc as? ItemDescViewController, let silder = silder as? ImageSlideshow  else { return }
        silder.presentFullScreenController(from: view)
    }
    
    func sharePaint(from vc: ItemDescViewInput?, items: [Any]) {
        guard let view = vc as? UIViewController else { return }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        view.present(ac, animated: true)
    }
}

extension UINavigationController{
public func removePreviousController(total: Int){
    let totalViewControllers = self.viewControllers.count
    self.viewControllers.removeSubrange(totalViewControllers-total..<totalViewControllers - 1)
}}
