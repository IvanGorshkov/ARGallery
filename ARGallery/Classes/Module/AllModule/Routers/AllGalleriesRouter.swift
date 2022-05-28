//
//  AllCompilationsRouter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import UIKit

final class AllGalleriesRouter {
}

extension AllGalleriesRouter: AllRouterInput {
    func itemSelected(with view: AllViewInput?, title: String, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let exhibitions = GalleriesContainer.assemble(with: GalleriesContext( id: id, title: title))
        view.navigationController?.pushViewController(exhibitions.viewController, animated: true)
    }
}
