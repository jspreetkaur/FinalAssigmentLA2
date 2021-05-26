//
//  AddNewVC.swift
//  A2_FA_iOS_Jaspreet_C0812273
//
//  Created by Jaspreet Kaur on 25/05/21.
//

import UIKit
import CoreData
class AddNewVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var providerTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var despTxtV: UITextView!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var addButton: UIBarButtonItem!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var product : Product?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        despTxtV.layer.cornerRadius = 5
        despTxtV.layer.borderWidth = 0.7
        despTxtV.layer.borderColor = UIColor.lightGray.cgColor
        
        if let produ = product{
            self.nameTF.text = produ.productName
            self.providerTF.text = produ.productProvider
            self.priceTF.text = "\(produ.productPrice)"
            self.despTxtV.text = produ.productDescription
            self.idTF.text = produ.productId
            self.title  = (produ.productName)?.capitalized
            self.addButton.title = "Update"
        }
    }
    
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        self.saveDataToLocal()
    }
    
    func saveDataToLocal(){
        let item = Product(context: self.context)
        let productName = nameTF.text ?? ""
        let productId = idTF.text ?? ""
        let productProvider = providerTF.text ?? ""
        let productPrice = Double(priceTF.text ?? "0") ?? 0.0
        let productDescription = despTxtV.text ?? ""
        
        item.setValue(productName, forKey: "productName")
        item.setValue(productId, forKey: "productId")
        item.setValue(productProvider, forKey: "productProvider")
        item.setValue(productPrice, forKey: "productPrice")
        item.setValue(productDescription, forKey: "productDescription")
        
        if let product = self.product{
            self.context.delete(product)
        }
        
        do{
            try context.save()
            self.navigationController?.popViewController(animated: true)
        }catch let error {
            print(error.localizedDescription)
        }
    }


}
