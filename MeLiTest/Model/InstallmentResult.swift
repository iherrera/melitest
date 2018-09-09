struct InstallmentResult: Codable {
    let issuer: CardIssuer
    let payer_costs: [Installment]
    let payment_method_id: String
    let payment_type_id: String
}
