//
//  CompilationRouter.swift
//  MilliArt
//
//  Created by Ivan Gorshkov on 01.12.2021.
//  
//

import UIKit

final class ExhibitionsRouter {
}

extension ExhibitionsRouter: ExhibitionsRouterInput {
    func itemSelected(with view: ExhibitionsViewInput?, and id: Int) {
        guard let view = view as? UIViewController else { return }
        let itemDesc = ItemDescContainer.assemble(with: ItemDescContext(id: id))
        view.navigationController?.pushViewController(itemDesc.viewController, animated: true)
    }
    
    func openDescription(with view: ExhibitionsViewInput?, with exhibition: ExhibitionsResponse?) {
        guard let view = view as? UIViewController, let exhibition = exhibition else { return }
        let descr = DescriptionContainer.assemble(with: DescriptionContext(entity: DescriptionEntity(with: exhibition)))
        view.present(descr.viewController, animated: true, completion: nil)
    }
}
