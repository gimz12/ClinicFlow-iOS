import SwiftUI

struct AuthInputSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.primary)
                .tracking(0.5)

            content
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .foregroundColor(.primary)
        }
        .padding(.bottom, 24)
    }
}

struct AuthHeaderIcon: View {
    let symbolName: String
    let tint: Color
    var background: Color = Color(.systemGray6)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .fill(background)
                .frame(width: 92, height: 92)

            Image(systemName: symbolName)
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(tint)
        }
    }
}
