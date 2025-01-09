//
//  NavigationBarUpdater.swift
//  workspace-playground
//
//  Created by Zimo Luo on 1/8/25.
//

import SwiftUI

struct NavigationBarUpdater: UIViewControllerRepresentable {
    let update: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            self.update() // Trigger the update
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
