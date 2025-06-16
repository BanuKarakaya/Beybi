# 🍼 Beybi

**Beybi** is an iOS application designed for parents of babies transitioning to complementary feeding. It offers daily meal menus with baby-friendly recipes and allows users to keep emotional diaries about their parenting journey.

  ## ✨ Features
  - Daily updated meal suggestions tailored for babies
  - Emotional diary for recording parenting experiences
  - Smooth and modern user interface with custom interactions

  ## 🛠 Technologies & Implementations
  ### 💡 UI/UX Improvements
  - Advanced UI components such as nested multi-section `UICollectionView`s
  - Dynamic cell sizing and custom swipe actions for better interaction
  - Clean, user-friendly interface design

  ### 🔥 Firebase Integration
  - Initially used Firestore and Firebase Storage for data storage and retrieval  
  - **Note:** Firebase was later removed after migrating to a custom backend using **Go** and **PostgreSQL**, with APIs deployed on **Railway** for better control, performance, and maintainability


  ### 🧠 Memory Management
  - Applied best practices to prevent memory leaks and improve app performance

  ### 🌐 Network Optimization
  - Used `DispatchGroup` to efficiently manage multiple asynchronous network calls

  ### 📦 Core Data
  - Emotional diary entries are stored and managed using Core Data

  ### 🔁 Communication Mechanisms
  - Used `Delegates` and `NotificationCenter` for interaction between components

  ### 🧱 Architecture
  - Built with the **MVVM** (Model-View-ViewModel) pattern to ensure modularity, testability, and a clean structure

  ### 🧩 Development Principles
  - Implemented **Dependency Injection** to improve maintainability and modularity


## 📸 Screenshots 
<p float="left">
  <img src="https://github.com/user-attachments/assets/b481e2b5-649e-4a8f-b832-89be6396dad8" width="280" height="600" alt="Screenshot 5" />
  <img src="https://github.com/user-attachments/assets/4a92aa3c-004b-4e4e-8e1c-d1798b7bed0c" width="280" height="600" alt="Screenshot 3" />
  <img src="https://github.com/user-attachments/assets/8155313f-bc23-4390-85e5-05e922441b1a" width="280" height="600" alt="Screenshot 4" />
  <img src="https://github.com/user-attachments/assets/b425309b-6167-4026-a3c2-3f332d005e23" width="280" height="600" alt="Screenshot 2" />
  <img src="https://github.com/user-attachments/assets/a376e3c5-83af-490c-ae55-d82473497a49" width="280" height="600" alt="Screenshot 1" />
</p>


## 🧪 Project Status
This project is published on the App Store and represents a comprehensive learning experience by combining advanced iOS development techniques with real-world implementation.

## 📄 License
This project is licensed under the MIT License.
