//
//  NewsfeedAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class NewsfeedAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NewsfeedRequestable.self) { r in
            NewsfeedRequestManager(requestManager: r.resolve(AbstractRequestManager.self))
        }
        
        container.register(NewsfeedInput.self) { r, output in
            NewsfeedPresenter(
                output: output,
                requestManager: r.resolve(NewsfeedRequestable.self)
            )
        }
    }
}
