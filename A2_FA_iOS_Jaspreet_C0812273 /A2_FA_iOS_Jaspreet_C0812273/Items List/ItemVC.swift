//
//  ItemVC.swift
//  A2_FA_iOS_Jaspreet_C0812273
//
//  Created by Jaspreet Kaur on 25/05/21.
//

import UIKit
struct Provider {
    var name: String?
    var products = [Product]()
}

class ItemVC: UIViewController {

    @IBOutlet weak var itemListTableView: UITableView!
    
    var items = [Product]()
    var filtredItems = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var providers = [Provider]()
    
    var filtredProviders = [Provider]()
    var isProvider = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableView.delegate = self
        self.itemListTableView.delegate = self

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchItems()
    }
    
    func fetchItems(){
        do{
            self.items = try context.fetch(Product.fetchCoreRequest())
            self.filtredItems = self.items
            self.itemListTableView.reloadData()
            
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addNewClicked(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "AddNewVC") as! AddNewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func productsSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            self.isProvider = true
            self.title = "Providers"
            let providers = self.items.map({$0.productProvider!}).uniqued()
            for provider in providers{
                let products = self.items.filter{$0.productProvider?.lowercased() == provider.lowercased()}
                let pro = Provider(name: provider, products: products)
                self.providers.append(pro)
            }
            self.filtredProviders = self.providers
        }else{
            self.title = "Products"
            providers = [Provider]()
            filtredProviders = [Provider]()
            self.isProvider = false
        }
        
        self.itemListTableView.reloadData()
    }
    

   

}

extension ItemVC:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isProvider{
            let vc = storyboard?.instantiateViewController(identifier: "ProviderItemsListVC") as! ProviderItemsListVC
            vc.provider = self.filtredProviders[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "AddNewVC") as! AddNewVC
            vc.product = self.filtredItems[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isProvider ? self.filtredProviders.count : self.filtredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
       
        if isProvider{
            let provider = self.filtredProviders[indexPath.row]
            cell.productView.isHidden = true
            cell.providerView.isHidden = false
            cell.providerNamelLabel.text = provider.name
            cell.productCount.text = "\(provider.products.count)"
        }else{
            let item = self.filtredItems[indexPath.row]
            cell.productView.isHidden = false
            cell.providerView.isHidden = true
            cell.productName.text = item.productName
            cell.providerName.text = item.productProvider
        }
       
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = self.filtredItems[indexPath.row]
            self.context.delete(item)
            do{
                try context.save()
            }catch let error {
                print(error.localizedDescription)
            }
            self.fetchItems()
            
            
            
            
            
        }
    }
    
    
}

extension ItemVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            self.filtredItems = self.items
            self.filtredProviders = self.providers
        }else{
            if isProvider{
                self.filtredProviders = self.providers.filter{$0.name!.lowercased().contains(searchText.lowercased())}
            }else{
                self.filtredItems = self.items.filter{$0.productName!.lowercased().contains(searchText.lowercased()) ||  $0.productDescription!.lowercased().contains(searchText.lowercased())}
            }
          
            
        }
        self.itemListTableView.reloadData()
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
