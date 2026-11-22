<!-- BEGIN: main -->
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title"><strong>CÔNG CỤ DỰ TOÁN TRẢ GÓP LAPTOP</strong></h3>
    </div>
    <div class="panel-body">
        <!-- BEGIN: message -->
        <div class="alert alert-success"><strong>{MESSAGE}</strong></div>
        <!-- END: message -->

        <form action="{FORM_ACTION}" method="post" class="form-horizontal">
            
            <!-- PHẦN KHẢO SÁT KHẢ NĂNG TÀI CHÍNH (GIỮ NGUYÊN FORM 2 CỘT) -->
            <div class="form-group">
                <label class="col-sm-4 control-label">Đối tượng khách hàng:</label>
                <div class="col-sm-8">
                    <select id="user_job" class="form-control">
                        <option value="office">Nhân viên văn phòng / Người đi làm</option>
                        <option value="student">Sinh viên (Có thu nhập làm thêm / Gia đình hỗ trợ)</option>
                        <option value="freelance">Kinh doanh tự do / Freelancer</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Thu nhập hàng tháng (VNĐ):</label>
                <div class="col-sm-8">
                    <input type="number" id="monthly_income" class="form-control" value="15000000" min="1000000" step="500000">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Chi phí sinh hoạt/tháng (VNĐ):</label>
                <div class="col-sm-8">
                    <input type="number" id="monthly_expense" class="form-control" value="7000000" min="0" step="500000">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Tiền mặt sẵn có trả trước (VNĐ):</label>
                <div class="col-sm-8">
                    <input type="number" id="available_cash" class="form-control" value="6000000" min="0" step="500000">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-8">
                    <button type="button" class="btn btn-info" onclick="phanTichTaiChinh()">
                        Phân tích thu nhập & Đề xuất gói trả góp
                    </button>
                </div>
            </div>

            <!-- KHUNG KẾT QUẢ TƯ VẤN CÓ CĂN CỨ -->
            <div class="form-group" id="advice_wrapper" style="display: none;">
                <div class="col-sm-offset-4 col-sm-8">
                    <div id="financial_advice_box" class="alert alert-info" style="margin-bottom: 0; line-height: 1.6;"></div>
                </div>
            </div>

            <hr>

            <!-- PHẦN BẢNG TÍNH TRẢ GÓP BAN ĐẦU -->
            <div class="form-group">
                <label class="col-sm-4 control-label">Tên mẫu Laptop muốn mua:</label>
                <div class="col-sm-8">
                    <input type="text" name="laptop_name" class="form-control" placeholder="Ví dụ: Asus ROG Strix G16" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Giá bán Laptop (VNĐ):</label>
                <div class="col-sm-8">
                    <input type="number" id="laptop_price" name="laptop_price" class="form-control" value="20000000" min="1000000" step="100000" oninput="tinhTraGop()" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Tỷ lệ trả trước (%):</label>
                <div class="col-sm-8">
                    <select id="prepay_percent" name="prepay_percent" class="form-control" onchange="tinhTraGop()">
                        <option value="20">Trả trước 20%</option>
                        <option value="30" selected>Trả trước 30%</option>
                        <option value="40">Trả trước 40%</option>
                        <option value="50">Trả trước 50%</option>
                        <option value="70">Trả trước 70%</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Kỳ hạn vay (Tháng):</label>
                <div class="col-sm-8">
                    <select id="months" name="months" class="form-control" onchange="tinhTraGop()">
                        <option value="6">6 tháng</option>
                        <option value="9">9 tháng</option>
                        <option value="12" selected>12 tháng</option>
                        <option value="18">18 tháng</option>
                        <option value="24">24 tháng</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Gói lãi suất:</label>
                <div class="col-sm-8">
                    <select id="interest_rate" class="form-control" onchange="tinhTraGop()">
                        <option value="0">Trả góp 0% qua Thẻ tín dụng</option>
                        <option value="0.015">Công ty tài chính (Lãi suất 1.5%/tháng)</option>
                    </select>
                </div>
            </div>

            <div class="well">
                <p><strong>Số tiền cần trả trước:</strong> <span id="txt_prepay" class="text-danger" style="font-weight:bold;">0 VNĐ</span></p>
                <p><strong>Số tiền còn lại vay trả góp:</strong> <span id="txt_loan">0 VNĐ</span></p>
                <p style="font-size: 16px;"><strong>Số tiền góp hàng tháng:</strong> <span id="txt_monthly" class="text-success" style="font-weight:bold;">0 VNĐ</span></p>
                <input type="hidden" id="monthly_payment_hidden" name="monthly_payment_hidden" value="0">
            </div>

            <hr>
            <h4>Thông tin nhận tư vấn hồ sơ</h4>
            <div class="form-group">
                <label class="col-sm-4 control-label">Họ và tên khách hàng:</label>
                <div class="col-sm-8">
                    <input type="text" name="customer_name" class="form-control" placeholder="Nhập họ tên của bạn" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-4 control-label">Số điện thoại liên hệ:</label>
                <div class="col-sm-8">
                    <input type="text" name="customer_phone" class="form-control" placeholder="Nhập số điện thoại" required>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-8">
                    <button type="submit" name="submit_tragop" value="1" class="btn btn-primary">Gửi hồ sơ đăng ký trả góp</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
function formatMoney(amount) {
    return Math.round(amount).toLocaleString('vi-VN') + ' VNĐ';
}

function phanTichTaiChinh() {
    var price = parseFloat(document.getElementById('laptop_price').value) || 0;
    var income = parseFloat(document.getElementById('monthly_income').value) || 0;
    var expense = parseFloat(document.getElementById('monthly_expense').value) || 0;
    var cash = parseFloat(document.getElementById('available_cash').value) || 0;
    var job = document.getElementById('user_job').value;

    var disposable = income - expense;
    var adviceWrapper = document.getElementById('advice_wrapper');
    var adviceBox = document.getElementById('financial_advice_box');
    adviceWrapper.style.display = 'block';

    if (disposable <= 0) {
        adviceBox.className = 'alert alert-danger';
        adviceBox.innerHTML = '<strong>Cảnh báo tài chính:</strong> Chi phí hàng tháng của bạn đang lớn hơn hoặc bằng thu nhập. Bạn chưa nên mua trả góp lúc này hoặc cần tăng số tiền trả trước.';
        return;
    }

    var cashPercent = (cash / price) * 100;
    var suggestedPercent = 20;
    if (cashPercent >= 70) suggestedPercent = 70;
    else if (cashPercent >= 50) suggestedPercent = 50;
    else if (cashPercent >= 40) suggestedPercent = 40;
    else if (cashPercent >= 30) suggestedPercent = 30;
    document.getElementById('prepay_percent').value = suggestedPercent;

    var safeMonthlyLimit = disposable * 0.30;
    var loanAmount = price * (1 - suggestedPercent / 100);
    var rate = parseFloat(document.getElementById('interest_rate').value) || 0;

    var monthOptions = new Array(6, 9, 12, 18, 24);
    var suggestedMonth = 24;
    var isSafe = false;

    for (var i = 0; i < monthOptions.length; i++) {
        var m = monthOptions[i];
        var monthlyPay = (loanAmount / m) + (loanAmount * rate);
        if (monthlyPay <= safeMonthlyLimit) {
            suggestedMonth = m;
            isSafe = true;
            break;
        }
    }
    document.getElementById('months').value = suggestedMonth;

    tinhTraGop();

    var finalMonthly = parseFloat(document.getElementById('monthly_payment_hidden').value);
    var jobNote = (job === 'student') ? 'Với Sinh viên, cần chuẩn bị CCCD và thẻ sinh viên (hoặc người thân đứng tên).' : 'Hồ sơ chỉ cần CCCD gắn chip duyệt tự động trong 15 phút.';

    if (isSafe) {
        adviceBox.className = 'alert alert-success';
        adviceBox.innerHTML = '<strong>Đề xuất tối ưu cho bạn:</strong><br>'
            + '• Thu nhập dư: <strong>' + formatMoney(disposable) + '/tháng</strong> (Ngưỡng góp an toàn 30%: <strong>' + formatMoney(safeMonthlyLimit) + '/tháng</strong>).<br>'
            + '• Hệ thống tự động chọn gói <strong>trả trước ' + suggestedPercent + '%</strong> trong <strong>' + suggestedMonth + ' tháng</strong> (góp <strong>' + formatMoney(finalMonthly) + '/tháng</strong>).<br>'
            + '• <em>Thủ tục:</em> ' + jobNote;
    } else {
        adviceBox.className = 'alert alert-warning';
    }
}