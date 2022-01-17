//
//  HomeController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import UIKit

class HomeController: UIViewController {

    var viewModel : HomeViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_left"), style: .plain, target: self, action: nil)
        
        self.tableView.register(UINib(nibName: "HomeCell", bundle: .main), forCellReuseIdentifier: "cellID")
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! HomeCell
        
        cell.configureCell(at: indexPath, viewModel: viewModel)
        
        return cell
    }
    
}
