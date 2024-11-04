//
//  EditViewController.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit
import FirebaseFirestore

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewProcuct: UITableView!
    
    var transactionDetail: TransactionDetail!
    var selectedProducts: [ProductDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewProcuct.delegate = self
        tableViewProcuct.dataSource = self
        registerCell()

        selectedProducts = transactionDetail.products
    }
    
    // MARK: - Register for Custom Table Cell
    func registerCell() {
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableViewProcuct.register(nib, forCellReuseIdentifier: "ProductCell")
        
        tableViewProcuct.rowHeight = 96.0
    }
    
    
    // MARK: - TableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionDetail.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewProcuct.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let productData = transactionDetail.products[indexPath.row]
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
        
        let selectedProduct = transactionDetail.products[indexPath.row]

        if let index = selectedProducts.firstIndex(where: { $0.name == selectedProduct.name }) {
            selectedProducts.remove(at: index)  // Hapus jika sudah dipilih
        } else {
            selectedProducts.append(selectedProduct)  // Tambah jika belum dipilih
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    // MARK: - UpdateButtonTapped
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        updateTransactions()
    }
    
    func updateTransactions() {
        let db = Firestore.firestore()
                
        // Buat array data produk untuk Firestore
        let productData = selectedProducts.map { product in
            return [
                "name": product.name,
                "price": product.price,
                "imageURL": product.imageURL
            ]
        }
        
        // Update transaksi di Firestore
        db.collection("transactions").document(transactionDetail.id).updateData([
            "products": productData,
            "updatedAt": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error updating transaction: \(error.localizedDescription)")
            } else {
                print("Transaction updated successfully!")
                NotificationCenter.default.post(name: .transactionDataChange, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    
    // MARK: - DeleteButtonTapped
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        deleteTransactions()
    }
    
    func deleteTransactions() {
        let db = Firestore.firestore()
        
        db.collection("transactions").document(transactionDetail.id).delete { error in
            if let error = error {
                print("Error removing document: \(error.localizedDescription)")
            } else {
                print("Document successfully removed!")
                NotificationCenter.default.post(name: .transactionDataChange, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}
