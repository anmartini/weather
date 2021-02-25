//
//  ContentView.swift
//  weathER
//
//  Created by Andrea Martini on 25/02/21.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var regionalDays = [RegionalDay]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(regionalDays, id: \.self) { regionalDay in
                    VStack {
                        RegionalDayView(regionalDay: regionalDay)
                        Divider()
                    }.padding(.vertical)
                }
            }.navigationTitle("Meteo Arpae")
        }
        .onAppear() {
            self.loadData()
        }
    }
    
    func loadData() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request("https://meteo.kyntos.it/api/daily/region/days/1").responseDecodable(of: RegionalDay.self, decoder: decoder) { response in
            regionalDays.append(response.value!)
            regionalDays = regionalDays.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
        }
        
        AF.request("https://meteo.kyntos.it/api/daily/region/days/2").responseDecodable(of: RegionalDay.self, decoder: decoder) { response in
            regionalDays.append(response.value!)
            regionalDays = regionalDays.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
        }
        
        AF.request("https://meteo.kyntos.it/api/daily/region/days/3").responseDecodable(of: RegionalDay.self, decoder: decoder) { response in
            regionalDays.append(response.value!)
            regionalDays = regionalDays.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
      
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemGreen
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .systemGreen
        compactAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .systemGreen
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        scrollEdgeAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
