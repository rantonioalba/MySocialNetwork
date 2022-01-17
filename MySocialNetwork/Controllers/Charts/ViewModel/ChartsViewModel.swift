//
//  ChartsViewModel.swift
//  MySocialNetwork
//
//  Created by Roberto Antonio on 09/01/22.
//

import Foundation
import Charts

class ChartsViewModel : NSObject {
    private var surveyObject : SurveyObject!
    var legendEntries : [LegendEntry] = []
    
    var numberOfQuestions: Int {
        get {
            if let surveyObject = surveyObject {
                return surveyObject.questions?.count ?? 0
            } else {
                return 0
            }
        }
    }
    
    func questionTitleAtIndexPath(indexPath:IndexPath) -> String {
        if let surveyObject = surveyObject {
            if surveyObject.questions?.count ?? 0 > 0 {
                return surveyObject.questions?[indexPath.row].text ?? ""
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    func questionTotalAtIndexPath(indexPath:IndexPath) -> Int {
        if let surveyObject = surveyObject {
            if surveyObject.questions?.count ?? 0 > 0 {
                return surveyObject.questions?[indexPath.row].total ?? 0
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    
    
    func getCharts(callback:@escaping(_ response:Bool)->Void, completionError:@escaping (_ errorDescription:String) -> Void)  {
            
        SurveyService.fetch { (object : SurveyObject) in
            self.surveyObject = object
            
            callback(true)
            
        } completionError: { error in
            completionError(error)
        }
    }
    
    func chartAtIndexPath(indexPath:IndexPath) -> PieChartData  {
        var dataEntries : [ChartDataEntry] = []
        
        
        let question = surveyObject.questions![indexPath.row]
        
        var colors:[UIColor] = []
        
        for item in surveyObject.colors! {
            let color = hexStringToUIColor(hex: item)
            colors.append(color)
        }
        
        var index = 0
        for item in question.chartData! {
            
            let value = Double(item.percetnage!)
            
            let dataEntry = PieChartDataEntry(value: value, label: item.text, data: item.text as AnyObject)
            dataEntries.append(dataEntry)
            
            
            
            let legendEntry = LegendEntry(label: "\(item.text!) \(item.percetnage!)%", form: .square, formSize: 0, formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths: nil, formColor: colors[index])
//            legendEntry.label = "\(item.text!) \(item.percetnage!)%"
            
            
            legendEntries.append(legendEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
       
        
        
        
        pieChartDataSet.drawValuesEnabled = true
        pieChartDataSet.colors = colors
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
          
        return pieChartData
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
