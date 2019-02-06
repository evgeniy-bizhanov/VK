//
//  AbstractCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 25/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    
    /// Executing at finish flow
    var onFinishFlow: (() -> Void)? { get set }
    
    /// Starts flow
    func start()
    
    init(parameters: [String: Any]?)
    init()
}

class AbstractCoordinator: Coordinator {

    private var coordiantors: [Coordinator] = []
    var onFinishFlow: (() -> Void)?

    func start() {}
    
    @discardableResult func navigateTo<T: Coordinator>(_ coordinatorType: T.Type, parameters: [String: Any]? = nil) -> T {
        
        let coordinator = createCoordinator(coordinatorType, parameters: parameters)
        coordinator.start()
        
        return coordinator
    }

    func removeDependency(_ coordinator: Coordinator) {
        
        guard coordiantors.isEmpty == false else { return }

        for (index, element) in coordiantors.reversed().enumerated() where element === coordinator {
            coordiantors.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
    required init(parameters: [String: Any]?) {}
    required init() {}
}


// MARK: - Fileprivate

extension AbstractCoordinator {
    fileprivate func createCoordinator<T: Coordinator>(_ coordinatorType: T.Type, parameters: [String: Any]? = nil) -> T {
        
        if let existing = coordiantors.first(where: { type(of: $0) == coordinatorType }) as? T {
            return existing
        }
        
        let coordinator = T(parameters: parameters)
        
        coordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        
        coordiantors.append(coordinator)
        
        return coordinator
    }
}
