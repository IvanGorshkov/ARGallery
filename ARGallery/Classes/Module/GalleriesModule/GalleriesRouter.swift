//
//  GalleriesRouter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import UIKit

final class GalleriesRouter {
}

extension GalleriesRouter: GalleriesRouterInput {
    func openDescription(with view: GalleriesViewInput?, with gallary: GalleriesResponse?) {
        guard let view = view as? UIViewController, let gallary = gallary else { return }
        let descr = DescriptionContainer.assemble(with: DescriptionContext(entity: DescriptionEntity(with: gallary)))
        view.present(descr.viewController, animated: true, completion: nil)
    }
    
    func itemSelected(with view: GalleriesViewInput?, and id: Int, title: String) {
        guard let view = view as? UIViewController else { return }
        let exhibitions = ExhibitionsContainer.assemble(with: ExhibitionsContext( id: id, title: title))
        view.navigationController?.pushViewController(exhibitions.viewController, animated: true)
    }
}
