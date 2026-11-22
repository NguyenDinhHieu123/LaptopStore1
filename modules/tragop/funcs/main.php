<?php

if (!defined('NV_IS_MOD_TRAGOP')) {
    die('Stop!!!');
}

$page_title = 'Dự toán trả góp Laptop';
$message = '';

if ($nv_Request->isset_request('submit_tragop', 'post')) {
    $customer_name = $nv_Request->get_title('customer_name', 'post', '');
    $customer_phone = $nv_Request->get_title('customer_phone', 'post', '');
    $laptop_name = $nv_Request->get_title('laptop_name', 'post', '');
    $laptop_price = $nv_Request->get_int('laptop_price', 'post', 0);
    $prepay_percent = $nv_Request->get_int('prepay_percent', 'post', 30);
    $months = $nv_Request->get_int('months', 'post', 12);
    $monthly_payment = $nv_Request->get_int('monthly_payment_hidden', 'post', 0);

    if (!empty($customer_name) && !empty($customer_phone) && $laptop_price > 0) {
        $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_orders 
                (customer_name, customer_phone, laptop_name, laptop_price, prepay_percent, months, monthly_payment, created_at) 
                VALUES (:customer_name, :customer_phone, :laptop_name, :laptop_price, :prepay_percent, :months, :monthly_payment, " . NV_CURRENTTIME . ")";
        
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':customer_name', $customer_name, PDO::PARAM_STR);
        $stmt->bindParam(':customer_phone', $customer_phone, PDO::PARAM_STR);
        $stmt->bindParam(':laptop_name', $laptop_name, PDO::PARAM_STR);
        $stmt->bindParam(':laptop_price', $laptop_price, PDO::PARAM_INT);
        $stmt->bindParam(':prepay_percent', $prepay_percent, PDO::PARAM_INT);
        $stmt->bindParam(':months', $months, PDO::PARAM_INT);
        $stmt->bindParam(':monthly_payment', $monthly_payment, PDO::PARAM_INT);
        
        if ($stmt->execute()) {
            $message = 'Đăng ký tư vấn trả góp thành công! Cửa hàng sẽ liên hệ với bạn qua số ' . $customer_phone . ' trong 15 phút.';
        }
    } else {
        $message = 'Vui lòng nhập đầy đủ Họ tên, Số điện thoại và Giá trị Laptop.';
    }
}

$contents = nv_theme_tragop_main($message);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
