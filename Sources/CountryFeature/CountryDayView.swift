//
//  CountryDayView.swift
//
//
//  Created by Roberto Casula on 07/04/21.
//

import SwiftUI
import SharedModels
import SharedExtensions
import SwiftUINavigation

struct CountryDayView: View {

    let countryDay: CountryDay
    @State var selectedZone: Zone?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text((countryDay.readableDay ?? "giorno").capitalizedFirstLetter)
                    .font(.title)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 5) {
                FakeHtmlView(countryDay.forecast)
            }
            HStack {
                Spacer()
                Text("Previsione del \(countryDay.readableUpdatedAt ?? "")")
                    .font(.footnote)
            }
            if !countryDay.zones.isEmpty {
                Text("Zone")
                    .font(.title2)
                ForEach(countryDay.zones, id: \.self) { zone in
                    HStack {
                        Text(zone.name.capitalizedFirstLetter)
                            .foregroundColor(zone.forecast == nil ? .secondary : nil)

                        Spacer()

                        if zone.forecast != nil {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .onTapGesture {
                        self.selectedZone = zone
                    }
                    .disabled(zone.forecast == nil)
                }
            }
        }
        .sheet(
            unwrapping: self.$selectedZone
        ) { $zone in
            NavigationView {
                ZoneView(zone: zone)
            }
        }
    }
}

struct CountryDayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                CountryDayView(
                    countryDay: .init(
                        day: Date(),
                        forecast: "<p>Sereno tutta la <b>giornata</b>.</p><p>Temperature massime pomeridiane comprese tra 14° sui rilievi e 19° in pianura.</p><p>Velocità massima del vento compresa tra 15 (sui rilievi) e 19 km/h (in pianura).</p>",
                        updatedAt: Date(),
                        zones: [
                            .init(
                                code: "P",
                                name: "pianura e capoluogo",
                                forecast: .init(
                                    rain: "rain", // nil
                                    wind: 32,
                                    temperature: .init(
                                        min: 15,
                                        max: 27
                                    )
                                ),
                                times: [
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "b005b016",
                                            text: .init(
                                                it: "tendenza ad attenuazione della nuvolosità",
                                                en: "decreasing cloudiness tendency"
                                            )
                                        )
                                    )
                                ]
                            ),
                            .init(
                                code: "C",
                                name: "collina",
                                forecast: .init(
                                    rain: "rain", // nil
                                    wind: 32,
                                    temperature: .init(
                                        min: 15,
                                        max: 27
                                    )
                                ),
                                times: [
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "b005b016",
                                            text: .init(
                                                it: "tendenza ad attenuazione della nuvolosità",
                                                en: "decreasing cloudiness tendency"
                                            )
                                        )
                                    )
                                ]
                            ),
                            .init(
                                code: "R",
                                name: "rilievi",
                                forecast: nil,
                                times: [
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "a003a003",
                                            text: .init(
                                                it: "sereno o poco nuvoloso",
                                                en: "partly cloudy"
                                            )
                                        )
                                    ),
                                    .init(
                                        weather: .init(
                                            value: "b005b016",
                                            text: .init(
                                                it: "tendenza ad attenuazione della nuvolosità",
                                                en: "decreasing cloudiness tendency"
                                            )
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                )
            }
        }
    }
}
