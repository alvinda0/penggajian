-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 03 Mar 2024 pada 16.03
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penggajian`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `PayrollKaryawan`
--

CREATE TABLE `PayrollKaryawan` (
  `id` int(11) NOT NULL,
  `bulan_tahun` date DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `gaji_pokok` decimal(10,2) DEFAULT NULL,
  `tunjangan_jabatan` decimal(10,2) DEFAULT NULL,
  `konsumsi` decimal(10,2) DEFAULT NULL,
  `tunjangan_harian` decimal(10,2) DEFAULT NULL,
  `potongan_bpjs` decimal(10,2) DEFAULT NULL,
  `jht` decimal(10,2) DEFAULT NULL,
  `pensiun` decimal(10,2) DEFAULT NULL,
  `pph21` decimal(10,2) DEFAULT NULL,
  `total_pendapatan` decimal(10,2) DEFAULT NULL,
  `total_potongan` decimal(10,2) DEFAULT NULL,
  `jumlah_bersih` decimal(10,2) DEFAULT NULL,
  `divisi` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `PayrollKaryawan`
--

INSERT INTO `PayrollKaryawan` (`id`, `bulan_tahun`, `nama`, `nip`, `jabatan`, `status`, `gaji_pokok`, `tunjangan_jabatan`, `konsumsi`, `tunjangan_harian`, `potongan_bpjs`, `jht`, `pensiun`, `pph21`, `total_pendapatan`, `total_potongan`, `jumlah_bersih`, `divisi`, `user_id`) VALUES
(12, '2024-02-27', 'John Doe', '1234567890', 'Manager', 'Aktif', 5000000.00, 1000000.00, 200000.00, 50000.00, 200000.00, 100000.00, 100000.00, 500000.00, 6500000.00, 400000.00, 6100000.00, 'Keuangan', 1),
(14, '2024-02-28', 'Jane Smith', '0987654321', 'Supervisor', 'Aktif', 4500000.00, 800000.00, 150000.00, 40000.00, 150000.00, 90000.00, 90000.00, 400000.00, 5800000.00, 350000.00, 5450000.00, 'Produksi', 2),
(15, '2024-02-29', 'Michael Johnson', '1357924680', 'Staff', 'Aktif', 4000000.00, 700000.00, 120000.00, 30000.00, 120000.00, 80000.00, 80000.00, 350000.00, 5200000.00, 300000.00, 4900000.00, 'Pemasaran', 3),
(16, '2024-03-01', 'Emily Brown', '2468013579', 'Analyst', 'Aktif', 5500000.00, 900000.00, 180000.00, 60000.00, 180000.00, 110000.00, 110000.00, 600000.00, 7200000.00, 450000.00, 6750000.00, 'IT', 4),
(29, '2024-03-27', 'Alvinda', '1234567890', 'Manager', 'Aktif', 5000000.00, 1000000.00, 200000.00, 50000.00, 200000.00, 100000.00, 100000.00, 500000.00, 6500000.00, 400000.00, 5100000.00, 'Keuangan', 5),
(30, '2024-03-27', 'Alvinda', '1234567890', 'Manager', 'Aktif', 5000000.00, 1000000.00, 200000.00, 50000.00, 200000.00, 100000.00, 100000.00, 500000.00, 6500000.00, 400000.00, 5100000.00, 'Keuangan', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `nip` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `Users`
--

INSERT INTO `Users` (`user_id`, `nip`, `password`, `role`, `name`, `email`, `phone`) VALUES
(1, '1234', 'alvin123', 'user', NULL, NULL, NULL),
(2, '123456', 'alvin123', 'user', NULL, NULL, NULL),
(3, '0000', 'admin123', 'admin', NULL, NULL, NULL),
(4, '0001', 'admin123', 'user', NULL, NULL, NULL),
(5, '111', 'admin123', 'user', NULL, NULL, NULL),
(6, '1112', 'admin123', 'user', NULL, NULL, NULL),
(7, '1113', 'admin123', 'user', NULL, NULL, NULL),
(10, '101', 'admin123', 'user', 'doli', 'siti@gmail.com', '0987654321'),
(11, '0112', 'dila123', 'user', 'dila', 'dila@gmail.com', '098-65488'),
(12, '0987111', 'dian123', 'admin', 'dian', 'dian@', '0865'),
(13, '0987112', 'dian123', 'user', 'dian s', 'dian@', '0865'),
(14, '09871100', 'dias123', 'user', 'dias', 'dian@', '0865'),
(15, '1', '1', 'user', NULL, NULL, NULL),
(16, '0', '0', 'admin', NULL, NULL, NULL),
(17, '7', '7', 'user', 'a', 'd', '9');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `PayrollKaryawan`
--
ALTER TABLE `PayrollKaryawan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `nip` (`nip`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `PayrollKaryawan`
--
ALTER TABLE `PayrollKaryawan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `PayrollKaryawan`
--
ALTER TABLE `PayrollKaryawan`
  ADD CONSTRAINT `payrollkaryawan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
