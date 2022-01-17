//
//  ChartsController.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import UIKit
import Alamofire
import Charts

class ChartsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ChartsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "QuestionViewCell", bundle: .main), forCellReuseIdentifier: "cellID")
        self.tableView.rowHeight = 256
        
        viewModel.getCharts { response in
            
            self.tableView.reloadData()
            
        } completionError: { error in
            
        }
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

extension ChartsController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfQuestions
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! QuestionViewCell
        
//        cell.pieChart.usePercentValuesEnabled = false
        
        cell.configureCell(at: indexPath, viewModel: self.viewModel)
        
//        cell.pieChart.drawEntryLabelsEnabled = false
//        cell.pieChart.drawHoleEnabled = true
//        cell.pieChart.data = viewModel.chartAtIndexPath(indexPath: indexPath)
        
        
//        cell.pieChart.legend.setCustom(entries: self.viewModel.legendEntries)
        
        return cell
    }
    

}
