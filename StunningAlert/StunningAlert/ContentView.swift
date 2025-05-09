//
//  ContentView.swift
//  StunningAlert
//
//  Created by Thanh Lâm on 9/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var alertType: AlertType? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Alert Custom Stunning =))")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding()
                Button {
                    withAnimation {
                        alertType = .success
                    }
                } label: {
                    Text("Complete Success")
                        .padding(.vertical, 12)
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .green))
                .padding(.horizontal, 40)
                .presentationCornerRadius(8)
                Button {
                    withAnimation {
                        alertType = .error
                    }
                } label: {
                    Text("Fix Error")
                        .padding(.vertical, 12)
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .red))
                .padding(.horizontal, 40)
                .presentationCornerRadius(8)
                Button {
                    withAnimation {
                        alertType = .question
                    }
                } label: {
                    Text("Ask the question")
                        .padding(.vertical, 12)
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .blue))
                .padding(.horizontal, 40)
                .presentationCornerRadius(8)
                Button {
                    withAnimation {
                        alertType = .network
                    }
                } label: {
                    Text("Check Connecting Network")
                        .padding(.vertical, 12)
                }
                .buttonStyle(CustomButtonStyle(backgroundColor: .gray))
                .padding(.horizontal, 40)
                .presentationCornerRadius(8)
            }
            .navigationTitle("Alert Test")
            .navigationBarTitleDisplayMode(.inline)
        }
        .overlay {
            if alertType != nil, let alertType = alertType {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    switch alertType {
                    case .success:
                        CustomAlertView(type: .success,
                                        title: "Success",
                                        message: "This is message Success",
                                        buttonText: "OK") {
                            withAnimation {
                                self.alertType = nil
                            }
                        }
                    case .error:
                        CustomAlertView(type: .error,
                                        title: "Error",
                                        message: "Fix this error",
                                        buttonText: "OK") {
                            withAnimation {
                                self.alertType = nil
                            }
                        }
                    case .question:
                        CustomAlertView(type: .question,
                                        title: "Question",
                                        message: "Please Answer the question",
                                        buttonText: "OK") {
                            withAnimation {
                                self.alertType = nil
                            }
                        }
                    case .network:
                        CustomAlertView(type: .network,
                                        title: "Network",
                                        message: "Connecting Network",
                                        buttonText: "OK") {
                            withAnimation {
                                self.alertType = nil
                            }
                        }
                    }
                }
                .gesture(
                    TapGesture()
                        .onEnded({
                            withAnimation {
                                self.alertType = nil
                            }
                        })
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
