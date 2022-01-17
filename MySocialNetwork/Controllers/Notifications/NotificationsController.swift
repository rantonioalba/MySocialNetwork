//
//  NotificationsController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 10/01/22.
//

import UIKit

class NotificationsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Notifications"
        
        self.tabBarItem.title = ""
        self.navigationController?.tabBarItem.title = ""
        
        self.tableView.register(UINib(nibName: "NotificationsCell", bundle: .main), forCellReuseIdentifier: "cellID")
        
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

extension NotificationsController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NotificationsCell
        
        return cell
    }
}
