import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var isLoginDisabled: Bool = true
    @State private var loginError: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        //@Environment(NavigationCoordinator.self) var coordinator: NavigationCoordinator
        VStack() {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)
            VStack(alignment: .leading){
                // Email TextField
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .border(Color.red, width: emailError.isEmpty ? 0 : 1)
                    .onChange(of: email) {
                        emailError = validateEmail($0)
                        checkFormValidity()
                    }
                
                if !emailError.isEmpty {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, -10)
                }
                
                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .border(Color.red, width: passwordError.isEmpty ? 0 : 1)
                    .onChange(of: password) {
                        passwordError = validatePassword($0)
                        checkFormValidity()
                    }
                
                if !passwordError.isEmpty {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, -10)
                }
            }
            // Login Button
            Button(action: {
                loginError = ""
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        // Handle the error and display to the user
                        loginError = error.localizedDescription
                        return
                    }
                    if let user = authResult?.user {
                        isLoggedIn = true
                       // coordinator.push("screen1")
                    }
                }
                
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(isLoginDisabled ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(isLoginDisabled)
            .padding(.top, 30)
            .navigationDestination(isPresented: self.$isLoggedIn) {
                HomeUIView()
            }
            // Show error if registration fails
            if !loginError.isEmpty {
                Text(loginError)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
    
    // Validation for email
    func validateEmail(_ email: String) -> String {
        if email.isEmpty {
            return "Email cannot be empty"
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) ? "" : "Invalid email format"
    }
    
    // Validation for password
    func validatePassword(_ password: String) -> String {
        if password.isEmpty {
            return "Password cannot be empty"
        }
        return password.count >= 6 ? "" : "Password must be at least 6 characters long"
    }
    
    // Check if the form is valid
    func checkFormValidity() {
        if emailError.isEmpty && passwordError.isEmpty && !email.isEmpty && !password.isEmpty {
            isLoginDisabled = false
        } else {
            isLoginDisabled = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

