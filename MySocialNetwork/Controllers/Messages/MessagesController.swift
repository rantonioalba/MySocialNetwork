//
//  MessagesController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import UIKit

class MessagesController: UIViewController {

    var viewModel : MessagesViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Inbox"
        self.tabBarItem.title = ""
        self.navigationController?.tabBarItem.title = ""
        self.view.backgroundColor = .cyan
        self.tableView.register(UINib(nibName: "MessagesCell", bundle: .main), forCellReuseIdentifier: "cellID")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_left"), style: .plain, target: self, action: nil)
        
        self.tableView.rowHeight = 50
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

extension MessagesController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! MessagesCell
        
        cell.configureCell(at: indexPath, viewModel: viewModel)
        return cell
    }
    
    
}
