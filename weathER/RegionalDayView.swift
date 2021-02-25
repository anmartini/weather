//
//  RegionalDayView.swift
//  weathER
//
//  Created by Andrea Martini on 25/02/21.
//

import SwiftUI

struct RegionalDayView: View {
    let regionalDay: RegionalDay
    
    var body: some View {
        VStack {
            HStack {
                Text(regionalDay.readableDay ?? "GIORNO")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                Spacer()
            }
            VStack (alignment: .leading, spacing: 10) {
                Text(regionalDay.forecast.weather)
                Text("Temperature \(regionalDay.forecast.temperature)")
                Text("Venti \(regionalDay.forecast.wind)")
                Text("Mare \(regionalDay.forecast.sea)")
            }
            .padding()
            HStack {
                Spacer()
                Text("Previsione del \(regionalDay.readableUpdatedAt ?? "")")
                    .font(.footnote)
                    .padding(.horizontal)
            }
        }
    }
}

struct RegionalDayView_Previews: PreviewProvider {
    static var previews: some View {
        RegionalDayView(regionalDay: RegionalDay(
            day: Date(),
            forecast: Forecast(
                weather: "Cielo sereno o poco nuvoloso. Formazione di banchi di nebbia nella notte a cominciare dalla costa e dal ferrarese.",
                temperature: "massime prossime a 20 gradi; valori tra 15 e 17 gradi lungo la costa.",
                wind: "deboli e variabili con deboli brezze dal mare lungo la costa.",
                sea: "calmo."
            ),
            updatedAt: Date()
        ))
    }
}
