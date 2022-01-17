//
//  QuestionViewCell.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import UIKit
import Charts

class QuestionViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureCell(at indexPath:IndexPath, viewModel:ChartsViewModel)  {
        pieChart.drawEntryLabelsEnabled = false
        pieChart.drawHoleEnabled = true
        pieChart.data = viewModel.chartAtIndexPath(indexPath: indexPath)
        
        self.lblTitle.text = viewModel.questionTitleAtIndexPath(indexPath: indexPath)
    }
    
    
}
