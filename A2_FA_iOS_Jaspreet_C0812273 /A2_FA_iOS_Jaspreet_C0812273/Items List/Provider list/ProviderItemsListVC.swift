//
//  ProvideItemsListVC.swift
//  A2_FA_iOS_Jaspreet_C0812273
//
//  Created by Jaspreet Kaur on 26/05/21.
//

import UIKit


class ProviderItemsListVC: UIViewController {

    var provider: Provider?
    var items = [Product]()
    @IBOutlet weak var providerProductListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let provider = self.provider{
            self.title = provider.name?.capitalized
            items = provider.products
            self.providerProductListTableView.reloadData()
        }
    }
    
   
   

}

extension ProviderItemsListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCell") as! ProviderCell
        cell.productNameLabel.text = self.items[indexPath.row].productName
        return cell
    }
    
    
}
