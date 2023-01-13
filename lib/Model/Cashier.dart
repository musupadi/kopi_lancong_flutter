import 'package:flutter/material.dart';

final String tableNotes = 'apos';

class CashierFields{

  static final List<String> values = [id,nama,jumlah,harga];
  static final String id = 'id';
  static final String id_product = 'id_product';
  static final String nama = 'nama';
  static final String jumlah = 'jumlah';
  static final String harga = 'harga';
  static final String gambar = 'gambar';
}

class Cashier {
  final int? id;
  final int id_product;
  final String nama;
  final int jumlah;
  final int harga;
  final String gambar;

  const Cashier({
    this.id,
    required this.id_product,
    required this.nama,
    required this.jumlah,
    required this.harga,
    required this.gambar
  });

  Cashier copy({
    int ? id,
    String ? nama,
    int ? jumlah,
    int ? harga,
    String ? gambar,
  })=> Cashier(
    id: id ?? this.id,
    id_product: this.id_product,
    nama: nama ?? this.nama,
    jumlah: jumlah ?? this.jumlah,
    harga: harga ?? this.harga,
    gambar: this.gambar
  );

  Map<String, Object?> toJson() => {
    CashierFields.id: id,
    CashierFields.id_product: id_product,
    CashierFields.nama: nama,
    CashierFields.jumlah: jumlah,
    CashierFields.harga: harga,
    CashierFields.gambar: gambar,
  };

  static Cashier fromJson(Map<String, Object?> json)=> Cashier(
      id : json[CashierFields.id] as int?,
      id_product: json[CashierFields.id_product] as int,
      nama : json[CashierFields.nama] as String,
      jumlah : json[CashierFields.jumlah] as int,
      harga : json[CashierFields.harga] as int,
      gambar: json[CashierFields.gambar] as String
  );
}