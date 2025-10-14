import Foundation
import FirebaseFirestore
import FirebaseAuth

class HomeViewViewModel: ObservableObject {
    @Published var currentUsername: String = ""
    @Published var firstName: String = ""
    @Published var checkOutDate: TimeInterval? = nil
    @Published var user: [String: Any]? = nil
    @Published var hotel: [String: Any]? = nil
    @Published var isLoading = false
    @Published var hotelId: String? = nil
    @Published var checkOutDate2: Date? = nil
    @Published var hotelImage: String = ""
    @Published var hotelName : String=""
    @Published var roomId: String?  = ""
    @Published var email : String=""

    private var userListener: ListenerRegistration?
    private var hotelListener: ListenerRegistration?

    func fetchUserAndHotel() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        isLoading = true
        
        
        userListener = db.collection("users").document(userId).addSnapshotListener { [weak self] userDoc, error in
            guard let self = self else { return }
            self.isLoading = false

            if let error = error {
                print("Kullanıcı verisi alınamadı: \(error.localizedDescription)")
                return
            }

            guard let userDoc = userDoc, userDoc.exists,
                  let userData = userDoc.data() else {
                print("Kullanıcı bulunamadı.")
                return
            }

            DispatchQueue.main.async {
                self.user = userData
                
                if let name = userData["name"] as? String {
                    self.currentUsername = name
                    let parts = name.split(separator: " ")
                    self.firstName = parts.first.map { String($0) } ?? name
                }

                if let hotelId = userData["currentHotelId"] as? String, !hotelId.isEmpty {
                    self.listenToHotel(hotelId: hotelId)
                } else {
                    self.hotel = nil
                }

                if let endTimestamp = userData["reservationEndDate"] as? Double, endTimestamp != 0 {
                    self.checkOutDate2 = Date(timeIntervalSince1970: endTimestamp)
                } else {
                    self.checkOutDate2 = nil
                }
                if let roomId = userData["currentRoomId"] as? String, !roomId.isEmpty {
                    self.roomId = roomId
                } else {
                    self.roomId = nil
                }
                if let email = userData["email"] as? String, !email.isEmpty {
                    self.email = email
                } else {
                   
                }
                
            }
        }
    }

    
    func listenToHotel(hotelId: String) {
        let db = Firestore.firestore()

       
        hotelListener?.remove()

        hotelListener = db.collection("hotels").document(hotelId).addSnapshotListener { [weak self] hotelDoc, error in
            guard let self = self else { return }

            if let error = error {
                print("Otel verisi alınamadı: \(error.localizedDescription)")
                return
            }

            guard let hotelDoc = hotelDoc, hotelDoc.exists else {
                self.hotel = nil
                return
            }

            DispatchQueue.main.async {
                self.hotelId = hotelId
                self.hotel = hotelDoc.data()
                
                if let imageUrls = hotelDoc.data()?["imageName"] as? [String] {
                    let hotelImagesArray: [String] = imageUrls
                      
                    if hotelImagesArray.indices.contains(0) {
                        self.hotelImage = hotelImagesArray[0]
                    }else{
                        self.hotelImage = ""
                    }
                  
                  } else {
                      self.hotelImage = ""
                  }
                if let hotelName = hotelDoc.data()?["name"] as? String {
                    self.hotelName = hotelName
                 
                  } else {
                      self.hotelName = ""
                  }
            }
        }
    }

    func stopListening() {
        userListener?.remove()
        hotelListener?.remove()
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
