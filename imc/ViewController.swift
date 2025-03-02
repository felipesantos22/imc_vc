//
//  ViewController.swift
//  imc
//
//  Created by Felipe Santos on 01/03/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        imageLogo()
        inpuWeight()
        inputHeight()
        buttonCalc()
        result()
    }
    
    func imageLogo() {
        let imageView = UIImageView(image: UIImage(named: "imc")) // Criando um UIImageView com a imagem

        // Habilitando o uso de Auto Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicionando a imagem à view
        view.addSubview(imageView)
        
        // Configurando as constraints para posicionamento
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    
    
    func inpuWeight(){
        let textWeight = UITextField()
        textWeight.placeholder = "Peso (ex.: 69,2)"
        textWeight.keyboardType = .numberPad
        textWeight.borderStyle = .roundedRect
        textWeight.textAlignment = .center
        textWeight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textWeight)
        
        NSLayoutConstraint.activate([
            textWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textWeight.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            textWeight.widthAnchor.constraint(equalToConstant: 200),
            textWeight.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func inputHeight() {
        let textWeight = UITextField()
        textWeight.placeholder = "Altura (ex.: 1,70)"
        textWeight.keyboardType = .numberPad
        textWeight.borderStyle = .roundedRect
        textWeight.textAlignment = .center
        textWeight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textWeight)
        
        NSLayoutConstraint.activate([
            textWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textWeight.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            textWeight.widthAnchor.constraint(equalToConstant: 200),
            textWeight.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func buttonCalc() {
        let btnCalc = UIButton()
        
        // Define o título do botão corretamente
        btnCalc.setTitle("Calcular", for: .normal)
        
        // Define a cor do texto do botão
        btnCalc.setTitleColor(.black, for: .normal)
        
        // Define a cor de fundo do botão
        btnCalc.backgroundColor = .white
        
        // Configura a borda do botão
        btnCalc.layer.borderColor = UIColor.black.cgColor // Corrigido
        btnCalc.layer.borderWidth = 1 // Define a largura da borda
        btnCalc.layer.cornerRadius = 10 // Deixa os cantos arredondados
        
        // Permite a utilização de Auto Layout
        btnCalc.translatesAutoresizingMaskIntoConstraints = false
        
        // Adiciona o botão à view
        view.addSubview(btnCalc)
        
        // Configura as constraints para posicionar o botão corretamente
        NSLayoutConstraint.activate([
            btnCalc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnCalc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            btnCalc.widthAnchor.constraint(equalToConstant: 200),
            btnCalc.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func result() {
        let resultLabel = UILabel()
        
        // Define o texto do rótulo
        resultLabel.text = "RESULTADO"
        
        // Define a fonte e o tamanho do texto
        resultLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        // Define a cor do texto
        resultLabel.textColor = .black
        
        // Alinha o texto ao centro
        resultLabel.textAlignment = .center
        
        // Permite a utilização de Auto Layout
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Adiciona o rótulo à view
        view.addSubview(resultLabel)
        
        // Configura as constraints para posicionar o rótulo corretamente
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            resultLabel.widthAnchor.constraint(equalToConstant: 200),
            resultLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    
    
}

