//
//  coursesTableViewController.swift
//  URLSession Get
//
//  Created by Gold_Mock on 17.09.2021.
//

import UIKit

class coursesTableViewController: UITableViewController {
        
    private var courses = [Course]()
    
    private var courseName: String?
    private var courseURL: String?
    
    private let url = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as! descriptionViewController
        webVC.selectedCourse = courseName
        
        if let url = courseURL {
            webVC.courseURL = url
        }
    }
    
    // MARK: - Fetching data from URL
    
    func fetchData() {
        
        NetworkManager.fetchData(url: url) { (courses) in
            self.courses = courses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchDataWithAlamofire() {
        
        AlamofireNetworkRequest.sendRequest(url: url) { (courses) in
            self.courses = courses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! TableViewCell

        configureCell(cell: cell, for: indexPath)

        return cell
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        cell.nameOfCourceLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numOfCoursesLabel.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
            cell.lowestLabel.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let url = URL(string: course.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                cell.imageCellView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        
        courseURL = course.link
        courseName = course.name
        
        performSegue(withIdentifier: "Description", sender: self)
    }

}
