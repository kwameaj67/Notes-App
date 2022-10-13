//
//  Date+Ext.swift
//  Notes-Clone
//
//  Created by Kwame Agyenim - Boateng on 13/10/2022.
//

import UIKit

extension Date {
    func getDate() -> Date{
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        if Calendar.current.isDateInToday(date){
            formatter.dateFormat = "h:mm:a"
        }else{
            formatter.dateFormat = "MMM d, yyyy"
        }
      
        return date
    }
}
