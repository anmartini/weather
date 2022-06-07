//
//  ZoneView.swift
//  weathER
//
//  Created by Andrea Martini on 01/03/21.
//

import SharedModels
import SwiftUI

struct ZoneView: View {
    let zone: Zone

    var body: some View {
        List {
            HStack {
                Text("T max")
                Spacer()
                Text("\(zone.forecast!.temperature.max) °C")
            }
            HStack {
                Text("T min")
                Spacer()
                Text("\(zone.forecast!.temperature.min) °C")
            }
            HStack {
                Text("Vento")
                Spacer()
                Text("\(zone.forecast!.wind) km/h")
            }
            HStack {
                Text("Pioggia")
                Spacer()
                Text("\(zone.forecast?.rain ?? "0") mm")
            }
        }
        .navigationTitle(zone.name.capitalizedFirstLetter)
    }
}

struct ZoneView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneView(
            zone: Zone(
                code: "BO",
                name: "Bologna",
                forecast: ZoneForecast(
                    rain: nil,
                    wind: 18,
                    temperature: Temperature(min: 1, max: 14)
                ),
                times: []
            ))
    }
}
