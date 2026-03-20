import SwiftUI

struct InvoiceEmailView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var email: String = ""

    private let navy = Color(red: 0.13, green: 0.27, blue: 0.40)

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                VStack(spacing: 16) {
                    Text("Email Invoice")
                        .font(.system(size: 20, weight: .bold))

                    Text("Send a copy of the invoice to your email.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)

                    TextField("Email address", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 16)

                    Button(action: { dismiss() }) {
                        Text("Send Email")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(navy)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 16)

                    Spacer()
                }
                .padding(.top, 24)
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

            Text("Email")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Text(" ")
                .frame(width: 42)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationStack {
        InvoiceEmailView()
    }
}
