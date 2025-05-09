//
//  CustomAlertView.swift
//  StunningAlert
//
//  Created by Thanh Lâm on 9/5/25.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .presentationCornerRadius(8)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}

struct CustomAlertView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let type: AlertType
    let title: String
    let message: String
    let buttonText: String?
    let buttonAction: (() -> Void)?
    let buttons: [(title: String,
                   type: ActionButtonType,
                   action: () ->Void)]?
    
    init(
        type: AlertType,
        title: String,
        message: String,
        buttonText: String? = "",
        buttonAction: (() -> Void)? = nil,
        buttons: [(title: String, type: ActionButtonType, action: () -> Void)]? = nil) {
            self.type = type
            self.title = title
            self.message = message
            self.buttonText = buttonText
            self.buttonAction = buttonAction
            self.buttons = buttons
        }
    
    private func actionButtonColor(for type: ActionButtonType) -> Color {
        switch type {
        case .posotiveButton:
            return colorScheme == .dark ? Color.green.opacity(0.5) : Color.green
        case .defaultButton:
            return colorScheme == .dark ? Color.red.opacity(0.5) : Color.red
        case .destructiveButton:
            return colorScheme == .dark ? Color.gray.opacity(0.5) : Color.gray
        case .cancelDismissButton:
            return colorScheme == .dark ? Color.pink.opacity(0.5) : Color.pink
        }
    }
    
    private var iconName: String {
        switch type {
        case .success:
            return "checkmark"
        case .error:
            return "xmark"
        case .question:
            return "questionmark"
        case .network:
            return "wifi.slash"
        }
    }
    
    private var iconColor: Color {
        switch type {
        default: return .white
        }
    }
    
    private var buttonColor: Color {
        switch type {
        case .success:
            return colorScheme == .dark ? Color.green.opacity(0.5) : Color.green
        case .error:
            return colorScheme == .dark ? Color.red.opacity(0.5) : Color.red
        case .question:
            return colorScheme == .dark ? Color.yellow.opacity(0.5) : Color.yellow
        case .network:
            return colorScheme == .dark ? Color.blue.opacity(0.5) : Color.blue
        }
    }
    
    private var buttonBackgroundColor: Color {
        switch type {
        case .success:
            return .green
        case .error:
            return .red
        case .question:
            return .yellow
        case .network:
            return .blue
        }
    }
    
    private var backgroundColor: Color {
        return colorScheme == .dark ? .black : .white
    }
    
    private var textColor: Color {
        return colorScheme == .dark ? .white : .black
    }
    
    private var messageTextColor: Color {
        return colorScheme == .dark ? .gray.opacity(0.7) : .gray
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(buttonBackgroundColor)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: iconName)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(iconColor)
                    }
            }
            .offset(y: 30)
            .zIndex(1)
            //Alert Content
            VStack(spacing: 12) {
                Spacer()
                    .frame(height: 30)
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(textColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 7)
                Text(message)
                    .font(.system(size: 16))
                    .foregroundStyle(messageTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                if let button = buttons {
                    HStack {
                        ForEach(button.sorted(by: {
                            if $0.type == .cancelDismissButton {return true}
                            if $1.type == .cancelDismissButton {return false}
                            return false
                        }), id: \.title) { button in
                            Button(action: button.action) {
                                Text(button.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(actionButtonColor(for: button.type))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .presentationCornerRadius(8)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
                if let buttonAction = buttonAction, let buttonText = buttonText {
                    Button(action: buttonAction) {
                        Text(buttonText)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(buttonColor)
                            .presentationCornerRadius(8)
//                            .cornerRadius(18)
                    }
                    .buttonStyle(CustomButtonStyle(backgroundColor: buttonColor))
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
            }
            .background(
                ZStack {
                    if colorScheme == .dark {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 1.0)
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(backgroundColor)
                    }
                }
            )
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.5)
            .ignoresSafeArea()
        CustomAlertView(type: .success,
                        title: "Success",
                        message: "Check Message Success",
                        buttonText: "OKE") {
            print("Button CHECK OKE")
        }
    }
}
