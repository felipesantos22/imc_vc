//
//  SplashViewController.swift
//  imc
//
//  Created by Felipe Santos on 01/03/25.
//

import UIKit

/// ViewController responsável pela Splash Screen.
class SplashViewController: UIViewController {
    
    /// UIImageView para exibir o logo na tela de Splash.
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imc"))
        imageView.contentMode = .scaleAspectFit // Mantém a proporção da imagem
        imageView.translatesAutoresizingMaskIntoConstraints = false // Permite o uso de Auto Layout
        return imageView
    }()
    
    /// Método chamado quando a tela é carregada.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Configura os elementos visuais
        navigateToMainScreen() // Aguarda um tempo e troca de tela
    }
    
    /// Configura a interface do usuário, adicionando e posicionando a logo.
    private func setupUI() {
        view.backgroundColor = .darkGray // Define a cor de fundo da tela
        
        // Adiciona a imagem ao layout da ViewController
        view.addSubview(logoImageView)
        
        // Configura as constraints para centralizar a logo na tela
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func navigateToMainScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Aguarda 2 segundos
            
            // Obtém a referência da SceneDelegate
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let viewController = ViewController()
                let navigationController = UINavigationController(rootViewController: viewController)
                
                // Define a nova tela inicial
                sceneDelegate.window?.rootViewController = navigationController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
