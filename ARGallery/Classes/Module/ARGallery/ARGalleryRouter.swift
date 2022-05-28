//
//  ARGalleryRouter.swift
//  ARGallery
//
//  Created by Ivan Gorshkov on 02.04.2022.
//  
//

import UIKit

final class ARGalleryRouter {
}

extension ARGalleryRouter: ARGalleryRouterInput {
    func itemSelected(with view: ARGalleryViewInput?, id: Int) {
        guard let view = view as? UIViewController else { return }
        let itemDesc = ItemDescContainer.assemble(with: ItemDescContext(id: id))
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
    }
    
}
