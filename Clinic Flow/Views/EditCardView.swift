import SwiftUI

struct EditCardView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var cardName: String = "John Patient"
    @State private var cardNumber: String = "**** **** **** 1234"
    @State private var expiry: String = "12/26"

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    fieldCard(label: "Cardholder Name", text: $cardName)
                    fieldCard(label: "Card Number", text: $cardNumber)
                    fieldCard(label: "Expiry", text: $expiry)

                    Button(action: { dismiss() }) {
                        Text("Save Changes")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(navy)
                            .cornerRadius(14)
                    }
                    .padding(.top, 12)

                    Spacer()
                }
                .padding(16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(navy)
            }

            Spacer()

            Text("Edit Card")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }

    private func fieldCard(label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
            TextField(label, text: text)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}

#Preview {
    NavigationStack {
        EditCardView()
    }
}
