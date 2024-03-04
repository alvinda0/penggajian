<?php

// Koneksi ke database
$koneksi = new mysqli("localhost", "root", "", "penggajian");

// Fungsi untuk menangani request login
function login($nip, $password)
{
    global $koneksi;
    $query = "SELECT * FROM Users WHERE nip = '$nip' AND password = '$password'";
    $result = $koneksi->query($query);
    if ($result->num_rows > 0) {
        return true;
    } else {
        return false;
    }
}

// Fungsi untuk menangani request register
function register($nip, $password, $role)
{
    global $koneksi;
    $query = "INSERT INTO Users (nip, password, role) VALUES ('$nip', '$password', '$role')";
    return $koneksi->query($query);
}

// Fungsi untuk menangani request CRUD pada tabel PayrollKaryawan
function handlePayrollRequest($method, $data)
{
    global $koneksi;
    if ($method == "GET") {
        // Mendapatkan parameter dari URL
        $divisi = isset($_GET['divisi']) ? $_GET['divisi'] : null;
        $nip = isset($_GET['nip']) ? $_GET['nip'] : null;

        if ($divisi !== null) {
            // Mengambil data karyawan berdasarkan divisi
            $query = "SELECT * FROM PayrollKaryawan WHERE divisi = '$divisi'";
        } elseif ($nip !== null) {
            // Mengambil data karyawan berdasarkan NIP
            $query = "SELECT * FROM PayrollKaryawan WHERE nip = '$nip'";
        } else {
            // Mengambil semua data karyawan
            $query = "SELECT * FROM PayrollKaryawan";
        }

        $result = $koneksi->query($query);
        $payroll_data = array();
        while ($row = $result->fetch_assoc()) {
            $payroll_data[] = $row;
        }
        echo json_encode($payroll_data);
    } elseif ($method == "POST") {
        // Mendapatkan data dari body request
        $nip = $data['nip'];
        $nama = $data['nama'];
        $divisi = $data['divisi'];
        // Melakukan operasi INSERT data baru ke tabel PayrollKaryawan
        $query = "INSERT INTO PayrollKaryawan (nip, nama, divisi) VALUES ('$nip', '$nama', '$divisi')";
        if ($koneksi->query($query)) {
            echo json_encode(array("status" => "success", "message" => "Data inserted successfully"));
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to insert data"));
        }
    } elseif ($method == "PUT") {
        // Mendapatkan data dari body request
        $nip = $data['nip'];
        $nama = $data['nama'];
        $divisi = $data['divisi'];
        // Melakukan operasi UPDATE data ke tabel PayrollKaryawan
        $query = "UPDATE PayrollKaryawan SET nama = '$nama', divisi = '$divisi' WHERE nip = '$nip'";
        if ($koneksi->query($query)) {
            echo json_encode(array("status" => "success", "message" => "Data updated successfully"));
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to update data"));
        }
    } elseif ($method == "DELETE") {
        // Mendapatkan parameter dari body request
        $nip = $data['nip'];
        // Melakukan operasi DELETE data dari tabel PayrollKaryawan berdasarkan NIP
        $query = "DELETE FROM PayrollKaryawan WHERE nip = '$nip'";
        if ($koneksi->query($query)) {
            echo json_encode(array("status" => "success", "message" => "Data deleted successfully"));
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to delete data"));
        }
    }
}



// Handler untuk request HTTP
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Handler untuk request login
    if ($_POST["action"] == "login") {
        $nip = $_POST["nip"];
        $password = $_POST["password"];
        if (login($nip, $password)) {
            // Login berhasil
            echo json_encode(array("status" => "success", "message" => "Login successful"));
        } else {
            // Login gagal
            echo json_encode(array("status" => "error", "message" => "Invalid credentials"));
        }
    } elseif ($_POST["action"] == "register") {
        // Handler untuk request register
        $nip = $_POST["nip"];
        $password = $_POST["password"];
        $role = $_POST["role"];
        if (register($nip, $password, $role)) {
            // Registrasi berhasil
            echo json_encode(array("status" => "success", "message" => "Registration successful"));
        } else {
            // Registrasi gagal
            echo json_encode(array("status" => "error", "message" => "Registration failed"));
        }
    }
} elseif ($_SERVER["REQUEST_METHOD"] == "GET" || $_SERVER["REQUEST_METHOD"] == "POST" || $_SERVER["REQUEST_METHOD"] == "PUT" || $_SERVER["REQUEST_METHOD"] == "DELETE") {
    // Handler untuk request CRUD pada tabel PayrollKaryawan
    $request_method = $_SERVER["REQUEST_METHOD"];
    $request_data = json_decode(file_get_contents("php://input"), true);
    handlePayrollRequest($request_method, $request_data);
}
?>