//
//  ViewController.swift
//  NASA-Meteors
//
//  Created by Mohammed Azeem Azeez on 05/03/2020.
//  Copyright © 2020 Blue Mango Global. All rights reserved.
//


import WebKit
//import FoldingCell
import UIKit
import MapKit
@_exported import Alamofire

fileprivate struct C {
  struct CellHeight {
    static let close: CGFloat = 165 // equal or greater foregroundView height
    static let open: CGFloat = 400 // equal or greater containerView height
  }
}
class MainVC: UITableViewController, MKMapViewDelegate {
// array string declaration
var meteors = [Meteors]()
var meteorId = [String]()
var meteorName = [String]()
var meteorYear = [String]()
var meteorNameType = [String]()
var meteorRecclass = [String]()
var meteorMass = [String]()
   
var meteorlong = [String]()
var meteorlat = [String]()
var meteorsId = [String]()
var coordinatesArray = [Any]()
 // filter section
var searching = false
var searchedString = [String]()
var searchController = UISearchController(searchResultsController: nil)
var setterQueue = DispatchQueue(label: "MainVC")
// progress loader / indicator
var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
  @IBOutlet weak var nasaLeftImage: UIImageView!
 

    enum Const {
        static let closeCellHeight: CGFloat = 165
        static let openCellHeight: CGFloat = 400
        static let rowsCount = 1000
    }

//    var cellHeights: [CGFloat] = []
     var cellHeights = (0..<1000).map { _ in C.CellHeight.close }
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let boardGif = UIImage.gifImageWithName("nasaGif")
        nasaLeftImage.image = boardGif
        tableView.backgroundView = UIImageView(image: UIImage(named: "earth"))
        meteorLandingsAPI()
       
    }
   func meteorLandingsAPI(){
    let urlRequest = "https://data.nasa.gov/resource/y77d-th95.json"
     indicator.startAnimating()
        AF.request(urlRequest).response { response in
            guard
               let data = response.data,
               let json = String(data: data, encoding: .utf8)
               
            else { return }
            print("json:", json)
            do {
                
                
                let response = try JSONDecoder().decode([Meteors].self, from: data)
               let coordinates = response.compactMap { $0.geoLocation?.coordinates }
                print((coordinates))
                self.coordinatesArray.append(contentsOf: coordinates as [Any])
                self.meteors = try JSONDecoder().decode([Meteors].self, from: data)
                for info in self.meteors {
                    let checkYear = info.year ?? "0000"
                    let year4 = String(checkYear.prefix(4))
                    print(year4)
                    if Int(year4)! >= 1900  {
                        self.meteorId.append(info.id ?? "Not Available")
                        self.meteorName.append(info.name ?? "Not Available")
                         self.meteorYear.append(info.year ?? "Not Available")
                        self.meteorNameType.append(info.nametype ?? "Not Available")
                        self.meteorRecclass.append(info.recclass ?? "Not Available")
                        self.meteorMass.append(info.mass ?? "Not Available")
                        self.meteorlat.append(info.reclat ?? "Not Available")
                       self.meteorlong.append(info.reclat ?? "Not Available")
                        self.indicator.stopAnimating()
                       self.tableView.reloadData()
                    }
                }
            } catch {
                self.indicator.stopAnimating()
                let Alert = alert()
                Alert.msgNS(message: "\(error)", title: "Error!")
            }
        }
    }
    // MARK: Helpers
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // MARK: Actions
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        // Configure the `UISearchController`.
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        searchController.searchBar.delegate = self
//        tableView.tableHeaderView = searchController.searchBar
        
    }
}

// MARK: - TableView

extension MainVC {

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
       return meteors.count
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }

        cell.number = indexPath.row
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
      
        cell.meteorNameLabel.text = meteors[indexPath.row].name
        cell.meteorId.text = meteors[indexPath.row].id
        cell.meteorYear.text = meteors[indexPath.row].year
        cell.nameTypeLabel.text = meteors[indexPath.row].nametype
        cell.recclassLabel.text = meteors[indexPath.row].recclass
        cell.masslabel.text = meteors[indexPath.row].mass
        cell.meteorsId.text = meteors[indexPath.row].id
        cell.latlongLabel.text = "Latitude : \(meteors[indexPath.row].reclat ?? "Not Available"), Longitude : \(meteors[indexPath.row].reclon ?? "Not Available")"
        cell.geometryLabel.text = "\(coordinatesArray[indexPath.row])"
        let location = "\(coordinatesArray[indexPath.row])"
        let strlong = location.strstr(needle: ",", beforeNeedle: true)
        let newStartIndex = strlong!.chopPrefix()
        let finallongitude = newStartIndex.toDouble()
        let strlat = location.strstr(needle: " ")
        let newEndIndex = strlat!.chopSuffix()
        let finallatitude = newEndIndex.toDouble()
        let cord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(finallatitude!,finallongitude!)
        let span = MKCoordinateSpan(latitudeDelta: 2.00, longitudeDelta: 2.00)
        let region = MKCoordinateRegion(center: cord,span:span)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = cord
        cell.mapView.addAnnotation(dropPin)
       //move to the specific area!t
        cell.mapView.setRegion(region, animated: true)
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()

            // fix https://github.com/Ramotion/folding-cell/issues/169
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
   
}

extension MainVC: UISearchBarDelegate {
 
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchController.isActive = false
            setterQueue.sync {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
                    self.meteors = []
            }
       }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          
            indicator.startAnimating()
        }
       
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            //searchBar.isHidden = true
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }}
       
}
extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return
        }
       
       if searchString == "" {
            self.setterQueue.sync {
                self.meteors = []
             
             }
        } else {
            self.setterQueue.sync {
                  DispatchQueue.main.async {
                   
                    self.indicator.stopAnimating()
                  //  self.meteors = [searchedString,
                        self.tableView.reloadData()
                    }}
             
            }
        }
        
    }
    


