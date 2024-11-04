//
//  HomeViewController.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {

    var transactions: [TransactionDetail] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .transactionDataChange, object: nil)
        
        navigationItem.hidesBackButton = true
        registerCell()
        fetchTransactions()
    }
    
    // MARK: - NotificationCenter for Reload Data after Dismiss View
    @objc func reloadData() {
        // Logika untuk memuat ulang data
        print("Data refreshed!")
        fetchTransactions()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .transactionDataChange, object: nil)
    }
    
    
    // MARK: - Register for Custom Table Cell
    func registerCell() {
        
        let nib = UINib(nibName: "TransactionsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TransactionCell")
        
        tableView.rowHeight = 96.0
    }
    
    
    // MARK: - Fetch transactions from Firestore
    func fetchTransactions() {
        let db = Firestore.firestore()
        db.collection("transactions")
            .order(by: "createdAt", descending: false) // Urutkan dari yang paling lama ke yang terbaru
            .getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching transactions: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }
                self.transactions = documents.compactMap { doc -> TransactionDetail? in
                let data = doc.data()
                // Menghitung jumlah produk dan total harga
                if let products = data["products"] as? [[String: Any]] {
                    let productCount = products.count
                    let totalPrice = products.compactMap { $0["price"] as? Double }.reduce(0, +)
                    //return Transaction(id: doc.documentID, productCount: productCount, totalPrice: totalPrice)
                    
                    let productList = products.compactMap { productData -> ProductDetail? in
                        guard let name = productData["name"] as? String,
                              let price = productData["price"] as? Double,
                              let imageURL = productData["imageURL"] as? String else { return nil }
                        return ProductDetail(name: name, price: price, imageURL: imageURL)
                    }
                    
                    let timestamp = data["createdAt"] as? Timestamp
                    let createdAt = timestamp?.dateValue() ?? Date()
                    
                    return TransactionDetail(id: doc.documentID, productCount: productCount, totalPrice: totalPrice, products: productList, createdAt: createdAt)
                }
                return nil
            }
            self.tableView.reloadData() // Memperbarui tampilan tabel
            self.scrollToBottom() // Scroll ke baris terakhir setelah memuat data
        }
    }
    
    func scrollToBottom() {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if lastRowIndex >= 0 {
            let indexPath = IndexPath(row: lastRowIndex, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }


    // MARK: - UITableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }
        
        let transaction = transactions[indexPath.row]
        
        cell.numberOfItemsLabel.text = String(transaction.productCount)
        cell.pricesOfItemsLabel.text = String(transaction.totalPrice)
        
        return cell
    }
    
    
    // MARK: - TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTransaction = transactions[indexPath.row]
        performSegue(withIdentifier: Constans.homeToEdit, sender: selectedTransaction)
        
        // Mengatur agar hover bisa dianimasikan
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constans.homeToEdit,
           let editVC = segue.destination as? EditViewController,
           let transaction = sender as? TransactionDetail {
            editVC.transactionDetail = transaction
        }
    }
    
    
    // MARK: - Logout Button Tapped
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}


