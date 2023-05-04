//
//  ViewController.swift
//  Core Database
//
//  Created by Choudhary Dipika on 06/04/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addDataButton(_ sender: UIButton) {
        if let x = idTextField.text, let y = Int(x)
        {
            addData(id: y, name: nameTextField.text!)
        }
    }
    
    
    @IBAction func deleteDataButton(_ sender: UIButton) {
        if let x = idTextField.text, let y = Int(x)
        {
            deleteData(id: y)
        }
    }
    
    @IBAction func getDataButton(_ sender: UIButton) {
        getData()
    }
    
    func addData(id:Int,name:String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Students", in: manageContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: manageContext)
        user.setValue(id, forKey: "id")
        user.setValue(name, forKey: "name")
        print(user)
    }
    
    func getData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = Students.fetchRequest()
        
        do
        {
            let result = try manageContext.fetch(fetchRequest)
            for data in result
            {
                print(data.name as! String, data.id)
            }
            print("Data Get\n")
        }
        catch
        {
            print("Data not get\n")
        }
    }
    
    func updateData()
    {
        
    }
    
    func deleteData(id:Int)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do
        {
            let test = try manageContext.fetch(fetchRequest)
            let objToDelete = test[0] as! NSManagedObject
            manageContext.delete(objToDelete)
            appDelegate.saveContext()
            print("Data Deleted")
        }
        catch
        {
            print(error)
        }
    }
    
}

