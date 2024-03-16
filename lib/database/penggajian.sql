-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 16 Mar 2024 pada 07.36
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
(32, '2024-03-01', 'Budi Hartono', '2001001', 'SPV', 'Tetap', 10000000.00, 2000000.00, 500000.00, 150000.00, 100000.00, 50000.00, 20000.00, 300000.00, 12500000.00, 170000.00, 12330000.00, 'Marketing', 18),
(33, '2024-03-01', 'Dewi Kusuma', '2001002', 'Lider', 'Tetap', 12000000.00, 2500000.00, 600000.00, 160000.00, 120000.00, 60000.00, 22000.00, 350000.00, 14000000.00, 180000.00, 13020000.00, 'Marketing', 19),
(34, '2024-03-01', 'Eko Pratama', '2001003', 'Staff', 'Kontrak', 9000000.00, 1800000.00, 400000.00, 120000.00, 90000.00, 40000.00, 18000.00, 280000.00, 10500000.00, 150000.00, 9612000.00, 'Marketing', 20),
(35, '2024-03-01', 'Fitri Yulianti', '2001004', 'Staff', 'Kontrak', 8500000.00, 1700000.00, 380000.00, 110000.00, 85000.00, 38000.00, 17000.00, 270000.00, 10000000.00, 140000.00, 9140000.00, 'Marketing', 21),
(36, '2024-03-01', 'Hadi Santoso', '2001005', 'SPV', 'Tetap', 11000000.00, 2200000.00, 480000.00, 140000.00, 110000.00, 48000.00, 20000.00, 320000.00, 13200000.00, 160000.00, 11840000.00, 'Marketing', 22),
(37, '2024-03-01', 'Arif Suryanto', '2001006', 'SPV', 'Tetap', 13000000.00, 2200000.00, 500000.00, 150000.00, 100000.00, 50000.00, 20000.00, 300000.00, 13500000.00, 170000.00, 13330000.00, 'IT', 23),
(38, '2024-03-01', 'Diana Rahayu', '2001007', 'Lider', 'Tetap', 14000000.00, 2500000.00, 600000.00, 160000.00, 120000.00, 60000.00, 22000.00, 350000.00, 14500000.00, 180000.00, 14320000.00, 'IT', 24),
(39, '2024-03-01', 'Edi Prasetyo', '2001008', 'Staff', 'Kontrak', 9500000.00, 1800000.00, 400000.00, 120000.00, 90000.00, 40000.00, 18000.00, 280000.00, 11200000.00, 150000.00, 11050000.00, 'IT', 25),
(40, '2024-03-01', 'Fitria Nurul', '2001009', 'Staff', 'Kontrak', 8700000.00, 1700000.00, 380000.00, 110000.00, 85000.00, 38000.00, 17000.00, 270000.00, 10200000.00, 140000.00, 10060000.00, 'IT', 26),
(41, '2024-03-01', 'Hendra Setiawan', '2001010', 'SPV', 'Tetap', 12000000.00, 2200000.00, 480000.00, 140000.00, 110000.00, 48000.00, 20000.00, 320000.00, 12400000.00, 160000.00, 12240000.00, 'IT', 27),
(42, '2024-03-01', 'Ani Cahyani', '2001011', 'Supervisor', 'Tetap', 12000000.00, 2200000.00, 500000.00, 150000.00, 100000.00, 50000.00, 20000.00, 300000.00, 12500000.00, 170000.00, 12330000.00, 'Customer Care', 28),
(43, '2024-03-01', 'Bambang Sutrisno', '2001012', 'Operator', 'Tetap', 10000000.00, 2000000.00, 600000.00, 160000.00, 120000.00, 60000.00, 22000.00, 350000.00, 10500000.00, 180000.00, 10320000.00, 'Customer Care', 29),
(44, '2024-03-01', 'Citra Ramadhani', '2001013', 'Customer Service', 'Kontrak', 8000000.00, 1800000.00, 400000.00, 120000.00, 90000.00, 40000.00, 18000.00, 280000.00, 9800000.00, 150000.00, 9650000.00, 'Customer Care', 30),
(45, '2024-03-01', 'Dedi Nugroho', '2001014', 'Operator', 'Kontrak', 7000000.00, 1700000.00, 380000.00, 110000.00, 85000.00, 38000.00, 17000.00, 270000.00, 8500000.00, 140000.00, 8360000.00, 'Customer Care', 31),
(46, '2024-03-01', 'Eva Sulistiani', '2001015', 'Customer Service', 'Tetap', 11000000.00, 2200000.00, 480000.00, 140000.00, 110000.00, 48000.00, 20000.00, 320000.00, 11500000.00, 160000.00, 11340000.00, 'Customer Care', 32),
(47, '2024-03-01', 'Faisal Rahman', '2001016', 'Analyst', 'Tetap', 12000000.00, 2200000.00, 500000.00, 150000.00, 100000.00, 50000.00, 20000.00, 300000.00, 12500000.00, 170000.00, 12330000.00, 'Data Analis', 38),
(48, '2024-03-01', 'Gita Wijaya', '2001017', 'Data Scientist', 'Tetap', 15000000.00, 2500000.00, 600000.00, 160000.00, 120000.00, 60000.00, 22000.00, 350000.00, 15500000.00, 180000.00, 15320000.00, 'Data Analis', 39),
(49, '2024-03-01', 'Hendra Gunawan', '2001018', 'Analyst', 'Kontrak', 10000000.00, 1800000.00, 400000.00, 120000.00, 90000.00, 40000.00, 18000.00, 280000.00, 11800000.00, 150000.00, 11650000.00, 'Data Analis', 40),
(50, '2024-03-01', 'Ika Pratiwi', '2001019', 'Data Analyst', 'Kontrak', 8500000.00, 1700000.00, 380000.00, 110000.00, 85000.00, 38000.00, 17000.00, 270000.00, 9500000.00, 140000.00, 9360000.00, 'Data Analis', 41),
(51, '2024-03-01', 'Joko Siswanto', '2001020', 'Analyst', 'Tetap', 11000000.00, 2200000.00, 480000.00, 140000.00, 110000.00, 48000.00, 20000.00, 320000.00, 11500000.00, 160000.00, 11340000.00, 'Data Analis', 42);

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
(18, '100001', 'pass1', 'user', 'Keuangan User 1', 'user1@example.com', '123-456-7891'),
(19, '100002', 'pass2', 'user', 'Keuangan User 2', 'user2@example.com', '123-456-7892'),
(20, '100003', 'pass3', 'user', 'Keuangan User 3', 'user3@example.com', '123-456-7893'),
(21, '100004', 'pass4', 'user', 'Keuangan User 4', 'user4@example.com', '123-456-7894'),
(22, '100005', 'pass5', 'user', 'Keuangan User 5', 'user5@example.com', '123-456-7895'),
(23, '200001', 'pass1', 'user', 'IT User 1', 'it_user1@example.com', '123-456-7896'),
(24, '200002', 'pass2', 'user', 'IT User 2', 'it_user2@example.com', '123-456-7897'),
(25, '200003', 'pass3', 'user', 'IT User 3', 'it_user3@example.com', '123-456-7898'),
(26, '200004', 'pass4', 'user', 'IT User 4', 'it_user4@example.com', '123-456-7899'),
(27, '200005', 'pass5', 'user', 'IT User 5', 'it_user5@example.com', '123-456-7900'),
(28, '300001', 'pass1', 'user', 'Budi Hartono', 'budi.hartono@example.com', '123-456-7901'),
(29, '300002', 'pass2', 'user', 'Siti Aisyah', 'siti.aisyah@example.com', '123-456-7902'),
(30, '300003', 'pass3', 'user', 'Agus Salim', 'agus.salim@example.com', '123-456-7903'),
(31, '300004', 'pass4', 'user', 'Dewi Sartika', 'dewi.sartika@example.com', '123-456-7904'),
(32, '300005', 'pass5', 'user', 'Ratna Sari', 'ratna.sari@example.com', '123-456-7905'),
(38, '2001001', 'pass1', 'user', 'Ari Wibowo', 'ari.wibowo@example.com', '123-456-7896'),
(39, '2001002', 'pass2', 'user', 'Dewi Kusuma', 'dewi.kusuma@example.com', '123-456-7897'),
(40, '2001003', 'pass3', 'user', 'Eko Pratama', 'eko.pratama@example.com', '123-456-7898'),
(41, '2001004', 'pass4', 'user', 'Fitri Yulianti', 'fitri.yulianti@example.com', '123-456-7899'),
(42, '2001005', 'pass5', 'user', 'Hadi Santoso', 'hadi.santoso@example.com', '123-456-7900'),
(43, '0', '0', 'admin', 'Admin HRD', 'admin.hrd@example.com', '123-456-7902');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT untuk tabel `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

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
