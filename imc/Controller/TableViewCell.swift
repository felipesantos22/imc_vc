//
//  TableViewCell.swift
//  imc
//
//  Created by Felipe Santos on 01/03/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // Criando labels para exibir os dados
    let weightHeightLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Define a cor no contentView
        contentView.backgroundColor = UIColor(named: "splashcolor")
        
        cellFormater()
    }
    
    
    func cellFormater() {
        
        // Configurando o rótulo de peso e altura
        weightHeightLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        weightHeightLabel.textColor = .black
        weightHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurando o rótulo da data
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicionando os rótulos à célula
        contentView.addSubview(weightHeightLabel)
        contentView.addSubview(dateLabel)
        
        // Definindo constraints para alinhamento correto
        NSLayoutConstraint.activate([
            weightHeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weightHeightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            dateLabel.leadingAnchor.constraint(equalTo: weightHeightLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: weightHeightLabel.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Método para configurar os dados da célula
    func configure(with imc: Imc) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        weightHeightLabel.text = "Resultado: \(String(format: "%.2f", imc.result))"
        dateLabel.text = formatter.string(from: imc.timestamp ?? Date())
    }
}
