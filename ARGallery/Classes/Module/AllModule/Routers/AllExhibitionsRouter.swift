//
//  AllAuthorsRouter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 05.11.2021.
//  
//

import UIKit

final class AllExhibitionsRouter {
}

extension AllExhibitionsRouter: AllRouterInput {
    func itemSelected(with view: AllViewInput?, title: String, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let exhibitions = ExhibitionsContainer.assemble(with: ExhibitionsContext( id: id, title: title))
        view.navigationController?.pushViewController(exhibitions.viewController, animated: true)
    }
}
