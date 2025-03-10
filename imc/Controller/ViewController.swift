//
//  ViewController.swift
//  imc
//
//  Created by Felipe Santos on 01/03/25.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    var context: NSManagedObjectContext!
    
    // Campos para capturar o peso e a altura do usuário
    var textWeight: UITextField!
    var textHeight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "splashcolor")
        // Inicializa o contexto do Core Data
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Configura a interface gráfica
        imageLogo()      // Logo do aplicativo
        inputWeight()    // Campo de entrada para o peso
        inputHeight()    // Campo de entrada para a altura
        buttonCalc()     // Botão para calcular o IMC
        createButton()   // Botão para navegar entre telas
        // Configura o método para fazer o teclado sumir ao clicar na tela
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Função para adicionar a imagem do logo na tela
    func imageLogo() {
        let imageView = UIImageView(image: UIImage(named: "imc"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        // Adiciona as restrições de layout para centralizar a imagem
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    // Função para adicionar o campo de entrada do peso na tela
    func inputWeight() {
        textWeight = UITextField()
        textWeight.placeholder = "Peso (ex.: 69,2)"  // Texto de sugestão
        textWeight.keyboardType = .decimalPad        // Tipo de teclado para números decimais
        textWeight.borderStyle = .roundedRect        // Estilo da borda do campo
        textWeight.textAlignment = .center           // Alinha o texto ao centro
        textWeight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textWeight)
        // Adiciona as restrições de layout para posicionar o campo de peso
        NSLayoutConstraint.activate([
            textWeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textWeight.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            textWeight.widthAnchor.constraint(equalToConstant: 200),
            textWeight.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Função para adicionar o campo de entrada da altura na tela
    func inputHeight() {
        textHeight = UITextField()
        textHeight.placeholder = "Altura (ex.: 1,70)"  // Texto de sugestão
        textHeight.keyboardType = .decimalPad         // Tipo de teclado para números decimais
        textHeight.borderStyle = .roundedRect         // Estilo da borda do campo
        textHeight.textAlignment = .center            // Alinha o texto ao centro
        textHeight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textHeight)
        // Adiciona as restrições de layout para posicionar o campo de altura
        NSLayoutConstraint.activate([
            textHeight.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textHeight.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            textHeight.widthAnchor.constraint(equalToConstant: 200),
            textHeight.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Função para adicionar o botão de calcular IMC na tela
    func buttonCalc() {
        let btnCalc = UIButton()
        // Define o título e estilo do botão
        btnCalc.setTitle("Calcular", for: .normal)
        btnCalc.setTitleColor(.black, for: .normal)
        btnCalc.backgroundColor = .white
        btnCalc.layer.borderColor = UIColor.black.cgColor
        btnCalc.layer.borderWidth = 1
        btnCalc.layer.cornerRadius = 10
        // Configura Auto Layout
        btnCalc.translatesAutoresizingMaskIntoConstraints = false
        btnCalc.addTarget(self, action: #selector(calculateIMC), for: .touchUpInside)
        // Adiciona o botão à view
        view.addSubview(btnCalc)
        // Adiciona restrições de layout para o botão
        NSLayoutConstraint.activate([
            btnCalc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnCalc.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            btnCalc.widthAnchor.constraint(equalToConstant: 200),
            btnCalc.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Função chamada ao pressionar o botão "Calcular"
    @objc func calculateIMC() {
        // Obtém o peso e a altura dos campos de texto
        guard let weight = Double((textWeight.text ?? "").replacingOccurrences(of: ",", with: ".")),
              let height = Double((textHeight.text ?? "").replacingOccurrences(of: ",", with: ".")) else {
            
            // Lidar com erro se os valores não forem válidos
            showAlert(title: "Alerta", message: "Campo peso ou altura não preenchido ou inválido.")
            return
        }
        
        // Calcula o IMC
        let imc = weight / (height * height)
        
        // Salva o resultado no Core Data
        saveResult(weight: weight, height: height, result: imc)
        
        // Exibe o resultado na tela
        result(imc: imc)
    }
    
    
    // Função para salvar os dados de IMC no Core Data
    func saveResult(weight: Double, height: Double, result: Double) {
        let newIMC = Imc(context: context)
        // Atribui valores ao modelo de dados
        newIMC.weight = weight
        newIMC.height = height
        newIMC.result = result
        newIMC.timestamp = Date()  // Armazena a data atual
        // Tenta salvar no Core Data
        do {
            try context.save()
            print("Resultado salvo com sucesso!")
        } catch {
            print("Erro ao salvar no Core Data: \(error)")
        }
    }
    
    // Função para exibir o resultado do IMC na tela
    func result(imc: Double) {
        let resultLabel = UILabel()
        resultLabel.text = "Resultado: \(String(format: "%.2f", imc))"
        resultLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        resultLabel.tintColor = .black
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            resultLabel.widthAnchor.constraint(equalToConstant: 200),
            resultLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func navigateToNextScreen() {
        let nextVC = TableViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func createButton() {
        let button = UIButton(type: .system)
        button.setTitle("Histórico", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(navigateToNextScreen), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    @objc func dimissKeyboard() {
        view.endEditing(true)
    }
    
    
}

