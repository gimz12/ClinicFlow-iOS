import SwiftUI

struct SignUpView: View {
    @State private var fullName: String = ""
    @State private var patientID: String = ""
    @State private var phoneNumber: String = ""
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var agreeToTerms: Bool = false
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    private let primaryColor = Color(red: 0.13, green: 0.27, blue: 0.40)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Create Account")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Register as a new patient")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                    
                    // Full Name Field
                    FormField(
                        title: "FULL NAME",
                        placeholder: "Enter your full name",
                        text: $fullName
                    )
                    .padding(.bottom, 20)
                    
                    // Patient ID Field
                    FormField(
                        title: "PATIENT ID / REGISTRATION NUMBER",
                        placeholder: "Provided by clinic",
                        text: $patientID
                    )
                    .padding(.bottom, 20)
                    
                    // Phone Number Field
                    FormField(
                        title: "PHONE NUMBER",
                        placeholder: "+1 (555) 000-0000",
                        text: $phoneNumber,
                        keyboardType: .phonePad
                    )
                    .padding(.bottom, 20)
                    
                    // Email Address Field
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 4) {
                            Text("EMAIL ADDRESS")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.primary)
                                .tracking(0.5)
                            
                            Text("(Optional)")
                                .font(.system(size: 13))
                                .foregroundColor(.secondary)
                        }
                        
                        TextField("your.email@example.com", text: $emailAddress)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding(.bottom, 20)
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("PASSWORD")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .tracking(0.5)
                        
                        HStack {
                            if showPassword {
                                TextField("Create a password", text: $password)
                            } else {
                                SecureField("Create a password", text: $password)
                            }
                            
                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        // Password Requirements
                        VStack(alignment: .leading, spacing: 4) {
                            PasswordRequirement(text: "At least 8 characters", isMet: password.count >= 8)
                            PasswordRequirement(text: "Include numbers and letters", isMet: containsLettersAndNumbers(password))
                        }
                        .padding(.top, 4)
                    }
                    .padding(.bottom, 20)
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CONFIRM PASSWORD")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.primary)
                            .tracking(0.5)
                        
                        HStack {
                            if showConfirmPassword {
                                TextField("Re-enter your password", text: $confirmPassword)
                            } else {
                                SecureField("Re-enter your password", text: $confirmPassword)
                            }
                            
                            Button {
                                showConfirmPassword.toggle()
                            } label: {
                                Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.bottom, 24)
                    
                    // Terms and Conditions
                    HStack(alignment: .top, spacing: 8) {
                        Button {
                            agreeToTerms.toggle()
                        } label: {
                            Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                                .foregroundColor(agreeToTerms ? primaryColor : .secondary)
                                .font(.system(size: 20))
                        }
                        
                        Text("I agree to the ")
                            .foregroundColor(.secondary) +
                        Text("Terms of Service")
                            .foregroundColor(primaryColor)
                            .fontWeight(.semibold) +
                        Text(" and ")
                            .foregroundColor(.secondary) +
                        Text("Privacy Policy")
                            .foregroundColor(primaryColor)
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 15))
                    .padding(.bottom, 24)
                    
                    // Create Account Button
                    Button {
                        handleCreateAccount()
                    } label: {
                        Text("Create Account")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(isFormValid ? primaryColor : primaryColor.opacity(0.5))
                            .cornerRadius(14)
                    }
                    .disabled(!isFormValid)
                    .padding(.bottom, 24)
                    
                    // Sign In Link
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .foregroundColor(.secondary)
                        Button("Sign In") {
                            dismiss()
                        }
                        .fontWeight(.semibold)
                        .foregroundColor(primaryColor)
                    }
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(primaryColor)
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !fullName.isEmpty &&
        !phoneNumber.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 8 &&
        containsLettersAndNumbers(password) &&
        agreeToTerms
    }
    
    private func containsLettersAndNumbers(_ text: String) -> Bool {
        let hasLetter = text.range(of: "[a-zA-Z]", options: .regularExpression) != nil
        let hasNumber = text.range(of: "[0-9]", options: .regularExpression) != nil
        return hasLetter && hasNumber
    }
    
    private func handleCreateAccount() {
        // Handle account creation logic
        print("Creating account for: \(fullName)")
    }
}

// MARK: - Form Field Component
struct FormField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.primary)
                .tracking(0.5)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .keyboardType(keyboardType)
                .autocorrectionDisabled(false)
        }
    }
}

// MARK: - Password Requirement Component
struct PasswordRequirement: View {
    let text: String
    let isMet: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Text("•")
                .foregroundColor(isMet ? .green : .secondary)
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(isMet ? .green : .secondary)
        }
    }
}

#Preview {
    SignUpView()
}
