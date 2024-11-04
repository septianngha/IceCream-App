//
//  AddViewController.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit
import FirebaseFirestore

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewProcuct: UITableView!
    
    var products: [Product] = []
    var selectedProducts: Set<Product> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewProcuct.delegate = self
        tableViewProcuct.dataSource = self
        registerCell()
        fetchData()
    }
    
    // MARK: - Register for Custom Table Cell
    func registerCell() {
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableViewProcuct.register(nib, forCellReuseIdentifier: "ProductCell")
        
        tableViewProcuct.rowHeight = 96.0
    }
    
    // MARK: - Fetch data dari firestore
    func fetchData() {
        
        let db = Firestore.firestore()
        db.collection("products").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }
            self.products = documents.compactMap { doc -> Product? in
                let data = doc.data()
                guard let name = data["name"] as? String,
                      let price = data["price"] as? Double,
                      let imageURL = data["imageURL"] as? String else {
                    return nil
                }
                return Product(name: name, price: price, imageURL: imageURL)
            }
            
            self.tableViewProcuct.reloadData()
        }
    }
    
    
    // MARK: - TableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewProcuct.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let productData = products[indexPath.row]
        cell.nameProduct.text = productData.name
        cell.priceProduct.text = String(productData.price)
        
        let noImage = "https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"
        let imageString = productData.imageURL
        let urlImage = URL(string: imageString.isEmpty ? noImage : imageString) ?? URL(string: noImage)!
        cell.imageViewProduct.downloaded(from: urlImage, contentMode: .scaleToFill)
        
        
        // Menampilkan checkmark jika produk dipilih
        if selectedProducts.contains(productData) {
            cell.accessoryType = .checkmark // Menampilkan checkmark
        } else {
            cell.accessoryType = .none // Menghapus checkmark
        }
        
        return cell
    }
    
    
    // MARK: - TableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProduct = products[indexPath.row]

        // Jika produk sudah dipilih, hapus dari set; jika tidak, tambahkan
        if selectedProducts.contains(selectedProduct) {
            selectedProducts.remove(selectedProduct) // Unselect
        } else {
            selectedProducts.insert(selectedProduct) // Select
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    // MARK: - AddButtonTapped for Saving Transaction to Firestore
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard !selectedProducts.isEmpty else {
            print("No product selected")
            self.dismiss(animated: true, completion: nil)
            return
        }
        saveTransactions()
    }
    
    func saveTransactions() {
        let db = Firestore.firestore()
        
        // Membuat array untuk produk
        var productsArray: [[String: Any]] = []
        
        // Menambahkan produk yang dipilih ke dalam array
        for product in selectedProducts {
            let productData: [String: Any] = [
                "name": product.name,
                "price": product.price,
                "imageURL": product.imageURL
            ]
            productsArray.append(productData) // Menambahkan produk ke array
        }
        
        // Membuat data untuk dokumen baru
        let transactionData: [String: Any] = [
            "products": productsArray, // Menyimpan array produk
            "createdAt": Timestamp(date: Date())
        ]
        
        // Menyimpan data ke Firestore
        db.collection("transactions").addDocument(data: transactionData) { error in
            if let error = error {
                print("Error saving transaction: \(error.localizedDescription)")
            } else {
                print("Transaction saved successfully!")
                NotificationCenter.default.post(name: .transactionDataChange, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }


    
    
}
