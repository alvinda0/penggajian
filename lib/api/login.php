<?php

// Koneksi ke database (ganti dengan koneksi sesuai database Anda)
$servername = "localhost";
$username = "root";
$password = "";
$database = "penggajian";

$conn = new mysqli($servername, $username, $password, $database);

// Cek koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mendapatkan data dari permintaan POST
$nip = $_POST['nip'];
$password = $_POST['password'];

// Query untuk memeriksa kredensial pengguna
$sql = "SELECT * FROM users WHERE nip='$nip' AND password='$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Kredensial benar, kirim respons berhasil
    $row = $result->fetch_assoc();
    $response = array(
        "status" => "success",
        "message" => "Login berhasil",
        "user_id" => $row['user_id'],
        "role" => $row['role']
    );
} else {
    // Kredensial salah, kirim respons gagal
    $response = array(
        "status" => "error",
        "message" => "Login gagal. NIP atau password salah."
    );
}

// Mengirim respons sebagai JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
$conn->close();

?>