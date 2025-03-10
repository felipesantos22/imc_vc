//
//  TableViewController.swift
//  imc
//
//  Created by Felipe Santos on 01/03/25.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var listIMC: [Imc] = []
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Define a cor no backgroundView (caso o contentView não cubra tudo)
        /*let bgView = UIView()
        bgView.backgroundColor = UIColor(named: "splashcolor")
        backgroundView = bgView*/
        
        view.backgroundColor = UIColor(named: "splashcolor")
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.title = "IMC"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        // Inicializa o contexto Core Data corretamente
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Erro ao acessar AppDelegate")
        }
        context = appDelegate.persistentContainer.viewContext
        
        fetchIMC()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func fetchIMC(){
        let fetchRequest: NSFetchRequest<Imc> = Imc.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            listIMC = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Erro ao buscar dados: \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listIMC.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let imc = listIMC[indexPath.row]
        cell.configure(with: imc)
        return cell
    }
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let imcToDelete = listIMC[indexPath.row]
            
            // Remove do Core Data
            context.delete(imcToDelete)
            
            // Remove da lista antes de salvar
            listIMC.remove(at: indexPath.row)
            
            do {
                try context.save() // Salva a remoção no banco de dados
                tableView.deleteRows(at: [indexPath], with: .fade) // Anima a remoção da célula
            } catch let error as NSError {
                print("Erro ao salvar: \(error), \(error.userInfo)")
            }
        }
    }
    
    
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
