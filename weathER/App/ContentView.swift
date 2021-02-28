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
        DailyWeatherRequest.request(for: "1") { response in
            regionalDays.append(response.value!)
            regionalDays = regionalDays.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
        }
        DailyWeatherRequest.request(for: "2") { response in
            regionalDays.append(response.value!)
            regionalDays = regionalDays.sorted(by: { $0.day.compare($1.day) == .orderedAscending })
        }
        DailyWeatherRequest.request(for: "3") { response in
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
