import Foundation
import UIKit

class AppDetailsDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView
    var rating: Rating
    
    init(tableView: UITableView, rating: Rating) {
        self.tableView = tableView
        self.rating = rating
        
        super.init()
        
        self.tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.row) {
        case 0:
            return buildCell(from: "DetailsCellSmall", displays: "Version", and: rating.latestVersion, at: indexPath)
        case 1:
            return buildCell(from: "DetailsCellSmall", displays: "Rating", and: String(rating.overallAverageRating), at: indexPath)
        case 2:
            return buildCell(from: "DetailsCellSmall", displays: "Rating Count", and: String(rating.overallRatingCount), at: indexPath)
        case 3:
            return buildCell(from: "DetailsCellLarge", displays: "Release Notes", and: rating.releaseNotes, at: indexPath )
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return 4}
    
    private func buildCell(from identifier: String, displays key: String, and value: String, at indexPath: IndexPath) -> UITableViewCell {
        switch (identifier) {
        case "DetailsCellSmall":
            let cell = Bundle.main.loadNibNamed("DetailsCellSmall", owner: nil, options: nil)?.first! as! DetailsCellSmall
            cell.present(key: key, value: value)
            return cell
        case "DetailsCellLarge":
            let cell = Bundle.main.loadNibNamed("DetailsCellLarge", owner: nil, options: nil)?.first! as! DetailsCellLarge
            cell.present(key: key, value: value)
            return cell
        default:
            return UITableViewCell()
        }
    }


}
