//
//  ViewController.swift
//  TableStory
//
//  Created by Suber, Allister on 3/17/25.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Vagabond", neighborhood: "Downtown", desc: "This store is an amazing place for sourcing vintage often for a very good price, the atmosphere is hectic but the finds are worth it.", lat: 29.885136941576324, long: -97.9399711588629, imageName: "image1"),
    Item(name: "Love-Buzz", neighborhood: "Hyde Park", desc: "Love-Buzz offers a unique vintage shopping experience with amazing curated sections that make it super easy to find what styles you are looking for!", lat: 29.8830, long: -97.9410, imageName: "image2"),
    Item(name: "Old-Soul Exchange", neighborhood: "Mueller", desc: "Old-Sould Exchange is a funky little vintage shop filled with nostalgic treasures from a different time, the owner is awesome and the atmosphere is extremely friendly.", lat: 29.8832, long: -97.9408, imageName: "image3"),
    Item(name: "Uptown Cheapskate", neighborhood: "UT", desc: "Uptown Cheapskate is a truly hidden gem for vintage in the San Marcos area, it can be hit or miss but the hits make it so worth it.", lat: 29.8826, long: -97.9404, imageName: "image4"),
    Item(name: "Goodwill", neighborhood: "Hyde Park", desc: "Goodwill is an old classic but is still a staple for vintage finds in the San Marcos area, it isn't as good as the other locations but is still worth checking out.", lat: 29.8870, long: -97.9416, imageName: "image5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      //Add image references
                let image = UIImage(named: item.imageName)
                cell?.imageView?.image = image
                cell?.imageView?.layer.cornerRadius = 10
                cell?.imageView?.layer.borderWidth = 5
                cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
      
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
             
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //add this code in viewDidLoad function in the original ViewController, below the self statements

            //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 29.885136941576324, longitude: -97.9399711588629)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.05))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

              

    }


}

