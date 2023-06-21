//
//  Router.swift
//  
//
//  Created by ykkd on 2023/06/15.
//

import SwiftUI

public protocol Router {
    associatedtype Content: View

    var hostingController: UIHostingController<Content>? { get set }

    func dismiss(_ animated: Bool)

    func pop(_ animated: Bool)

    func popToRoot(_ animated: Bool)
}

extension Router {

    public func dismiss(_ animated: Bool = true) {
        self.hostingController?.dismiss(animated: animated)
    }

    public func pop(_ animated: Bool = true) {
        self.hostingController?.navigationController?.popViewController(animated: animated)
    }

    public func popToRoot(_ animated: Bool = true) {
        self.hostingController?.navigationController?.popToRootViewController(animated: animated)
    }
    
    public mutating func setHostingVC<T: View>(_ vc: UIHostingController<T>) {
        let vc = vc as! UIHostingController<Content>
        self.hostingController = vc
    }
}
