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

            <!-- BƯỚC 1: KHẢO SÁT KHẢ NĂNG TÀI CHÍNH + SẢN PHẨM -->
            <div class="form-group">
                <label class="col-sm-8 control-label">Đối tượng khách hàng:</label>
                <div class="col-sm-16">
                    <select id="user_job" class="form-control">
                        <option value="office">Nhân viên văn phòng / Người đi làm</option>
                        <option value="student">Sinh viên (Có thu nhập làm thêm / Gia đình hỗ trợ)</option>
                        <option value="freelance">Kinh doanh tự do / Freelancer</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Thu nhập hàng tháng (VNĐ):</label>
                <div class="col-sm-16">
                    <input type="number" id="monthly_income" class="form-control" value="15000000" min="1000000" step="500000">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Chi phí sinh hoạt/tháng (VNĐ):</label>
                <div class="col-sm-16">
                    <input type="number" id="monthly_expense" class="form-control" value="7000000" min="0" step="500000">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Tiền mặt sẵn có trả trước (VNĐ):</label>
                <div class="col-sm-16">
                    <input type="number" id="available_cash" class="form-control" value="6000000" min="0" step="500000">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Sản phẩm muốn mua:</label>
                <div class="col-sm-16">
                    <input type="text" id="product_name" class="form-control" list="product_list" autocomplete="off" placeholder="Nhập để tìm, ví dụ: ASUS ROG Strix G16" oninput="onProductChange()" onchange="onProductChange()" onkeydown="if (event.keyCode === 13) { event.preventDefault(); }">
                    <datalist id="product_list"></datalist>
                    <span class="help-block" id="product_hint" style="margin-bottom: 0;"></span>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Giá sản phẩm (VNĐ):</label>
                <div class="col-sm-16">
                    <input type="number" id="product_price" class="form-control" min="1000000" step="100000" placeholder="Tự động hiển thị khi chọn sản phẩm" oninput="onPriceChange()">
                    <span class="help-block" id="price_hint" style="margin-bottom: 0;"></span>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-8 col-sm-16">
                    <button type="button" class="btn btn-info" onclick="phanTichTaiChinh()">
                        Phân tích thu nhập & Đề xuất gói trả góp
                    </button>
                </div>
            </div>

            <!-- KẾT QUẢ PHÂN TÍCH & ĐỀ XUẤT -->
            <div class="form-group" id="advice_wrapper" style="display: none;">
                <div class="col-sm-offset-8 col-sm-16">
                    <div id="financial_advice_box" class="alert alert-info" style="margin-bottom: 0; line-height: 1.6;"></div>
                </div>
            </div>

            <hr>

            <!-- BƯỚC 2: THÔNG TIN TRẢ GÓP (tự điền theo gói được chọn, khách có thể chỉnh) -->
            <h4 id="plan_section">Thông tin gói trả góp</h4>

            <div class="form-group">
                <label class="col-sm-8 control-label">Tên mẫu Laptop:</label>
                <div class="col-sm-16">
                    <input type="text" name="laptop_name" id="laptop_name" class="form-control" placeholder="Chọn sản phẩm ở phần phía trên" readonly required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Giá bán Laptop (VNĐ):</label>
                <div class="col-sm-16">
                    <input type="number" id="laptop_price" name="laptop_price" class="form-control" value="" readonly required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Tỷ lệ trả trước (%):</label>
                <div class="col-sm-16">
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
                <label class="col-sm-8 control-label">Kỳ hạn vay (Tháng):</label>
                <div class="col-sm-16">
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
                <label class="col-sm-8 control-label">Gói lãi suất:</label>
                <div class="col-sm-16">
                    <select id="interest_rate" name="interest_rate" class="form-control" onchange="tinhTraGop()">
                        <option value="0">Trả góp 0% qua Thẻ tín dụng</option>
                        <option value="0.015">Công ty tài chính (Lãi suất 1.5%/tháng)</option>
                    </select>
                </div>
            </div>

            <div class="well">
                <p><strong>Số tiền cần trả trước:</strong> <span id="txt_prepay" class="text-danger" style="font-weight:bold;">0 VNĐ</span></p>
                <p><strong>Số tiền còn lại vay trả góp:</strong> <span id="txt_loan">0 VNĐ</span></p>
                <p style="font-size: 16px; margin-bottom: 0;"><strong>Số tiền góp hàng tháng:</strong> <span id="txt_monthly" class="text-success" style="font-weight:bold;">0 VNĐ</span></p>
                <input type="hidden" id="monthly_payment_hidden" name="monthly_payment_hidden" value="0">
            </div>

            <hr>
            <h4>Thông tin nhận tư vấn hồ sơ</h4>
            <div class="form-group">
                <label class="col-sm-8 control-label">Họ và tên khách hàng:</label>
                <div class="col-sm-16">
                    <input type="text" name="customer_name" class="form-control" placeholder="Nhập họ tên của bạn" required>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-8 control-label">Số điện thoại liên hệ:</label>
                <div class="col-sm-16">
                    <input type="text" name="customer_phone" class="form-control" placeholder="Nhập số điện thoại" required>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-8 col-sm-16">
                    <button type="submit" name="submit_tragop" value="1" class="btn btn-primary">Gửi hồ sơ đăng ký trả góp</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
/* ===== 1. DANH SÁCH SẢN PHẨM (dữ liệu mẫu theo trang Sản phẩm; có thể thay bằng dữ liệu từ DB) ===== */
var PRODUCTS = [
    { name: 'MacBook Pro 14 M3 Pro (18GB / 512GB SSD)', price: 47990000 },
    { name: 'ASUS Vivobook 15 OLED (i5-13500H / 16GB / 512GB)', price: 16990000 },
    { name: 'MSI Katana 15 (i7-13620H / 16GB / 512GB / RTX 4050)', price: 25990000 },
    { name: 'HP Pavilion 15 (i5-1335U / 16GB / 512GB / 15.6 FHD)', price: 15490000 },
    { name: 'Lenovo Legion 5 Pro (Ryzen 7 7745HX / 16GB / 1TB / RTX 4060)', price: 34990000 },
    { name: 'Dell XPS 13 Plus 9320 (i7-1360P / 16GB / 512GB OLED)', price: 38500000 },
    { name: 'MacBook Air M3 13 inch 2024 (8GB / 256GB SSD)', price: 26490000 },
    { name: 'Acer Nitro 5 Tiger (i5-12500H / 16GB / 512GB / RTX 3050)', price: 18990000 },
    { name: 'ASUS ROG Strix G16 (i7-13650HX / 16GB / 512GB / RTX 4060)', price: 32990000 }
];

/* ===== 2. THAM SỐ TÀI CHÍNH (chỉnh tại đây cho khớp chính sách thật của cửa hàng/đối tác) ===== */
var CFG = {
    prepayOptions: [20, 30, 40, 50, 70],
    monthOptions: [6, 9, 12, 18, 24],
    zeroRateMaxMonths: 12,   // Thẻ tín dụng 0% thường chỉ áp dụng tối đa 12 tháng
    financeRate: 0.015,      // Công ty tài chính: 1.5%/tháng tính trên dư nợ gốc ban đầu
    maxDtiOfIncome: 0.30,    // Tổng khoản góp không vượt 30% thu nhập
    comfortRatio: 0.8        // Ưu tiên gói có khoản góp <= 80% ngưỡng an toàn để còn dư địa
};
/* haircut: tỷ lệ thu nhập được tính (thu nhập không ổn định thì tính thấp hơn)
   share: phần tối đa của "thu nhập dư" được dùng để trả góp */
var JOBS = {
    office:    { haircut: 1.0, share: 0.5, note: 'Hồ sơ chỉ cần CCCD gắn chip, duyệt tự động trong 15 phút.' },
    student:   { haircut: 0.9, share: 0.4, note: 'Với sinh viên, cần chuẩn bị CCCD và thẻ sinh viên (hoặc người thân đứng tên). Gói 0% qua thẻ tín dụng chỉ áp dụng nếu bạn đã có thẻ.' },
    freelance: { haircut: 0.7, share: 0.4, note: 'Với người kinh doanh tự do, nên chuẩn bị CCCD kèm sao kê ngân hàng 3-6 tháng hoặc giấy tờ chứng minh thu nhập.' }
};

var lastPlans = {};
var productMatched = false;

function el(id) { return document.getElementById(id); }

function formatMoney(amount) {
    return Math.round(amount).toLocaleString('vi-VN') + ' VNĐ';
}

/* ===== 3. GỢI Ý SẢN PHẨM + HIỂN THỊ GIÁ ===== */
(function initProductList() {
    var dl = el('product_list');
    for (var i = 0; i < PRODUCTS.length; i++) {
        var opt = document.createElement('option');
        opt.value = PRODUCTS[i].name;
        opt.text = formatMoney(PRODUCTS[i].price);
        dl.appendChild(opt);
    }
})();

function findProduct(name) {
    name = (name || '').replace(/^\s+|\s+$/g, '').toLowerCase();
    for (var i = 0; i < PRODUCTS.length; i++) {
        if (PRODUCTS[i].name.toLowerCase() === name) return PRODUCTS[i];
    }
    return null;
}

function onProductChange() {
    var name = el('product_name').value;
    var p = findProduct(name);
    var priceEl = el('product_price');

    if (p) {
        priceEl.value = p.price;
        priceEl.readOnly = true;
        productMatched = true;
        el('product_hint').innerHTML = '';
    } else {
        if (productMatched) priceEl.value = '';
        priceEl.readOnly = false;
        productMatched = false;
        el('product_hint').innerHTML = name.length > 0 ? 'Không có trong danh sách gợi ý. Bạn có thể nhập giá thủ công ở ô bên dưới.' : '';
    }
    onPriceChange();
}

function onPriceChange() {
    var price = parseFloat(el('product_price').value) || 0;
    el('price_hint').innerHTML = price > 0 ? '= <strong>' + formatMoney(price) + '</strong>' : '';
    el('advice_wrapper').style.display = 'none';
    syncProduct();
}

function syncProduct() {
    el('laptop_name').value = el('product_name').value;
    el('laptop_price').value = el('product_price').value;
    tinhTraGop();
}

/* ===== 4. TÍNH TIỀN GÓP CHO FORM BÊN DƯỚI ===== */
function tinhTraGop() {
    var price = parseFloat(el('laptop_price').value) || 0;
    var pct = parseFloat(el('prepay_percent').value) || 0;
    var months = parseInt(el('months').value, 10) || 1;
    var rate = parseFloat(el('interest_rate').value) || 0;

    var prepay = price * pct / 100;
    var loan = price - prepay;
    var monthly = loan / months + loan * rate;

    el('txt_prepay').innerHTML = formatMoney(prepay);
    el('txt_loan').innerHTML = formatMoney(loan);
    el('txt_monthly').innerHTML = formatMoney(monthly);
    el('monthly_payment_hidden').value = Math.round(monthly);
}

/* ===== 5. LOGIC TƯ VẤN TÀI CHÍNH ===== */
function buildPlans(price, cash, limit) {
    var plans = [];
    var rates = [0, CFG.financeRate];
    for (var r = 0; r < rates.length; r++) {
        for (var a = 0; a < CFG.prepayOptions.length; a++) {
            for (var b = 0; b < CFG.monthOptions.length; b++) {
                var rate = rates[r];
                var pct = CFG.prepayOptions[a];
                var m = CFG.monthOptions[b];
                if (rate === 0 && m > CFG.zeroRateMaxMonths) continue;

                var prepay = price * pct / 100;
                if (prepay > cash) continue;

                var loan = price - prepay;
                var monthly = loan / m + loan * rate;
                plans.push({
                    rate: rate, pct: pct, months: m,
                    prepay: prepay, loan: loan, monthly: monthly,
                    interest: loan * rate * m,
                    safe: monthly <= limit,
                    comfy: monthly <= limit * CFG.comfortRatio
                });
            }
        }
    }
    return plans;
}

function pickBest(plans, rate) {
    var pool = [];
    var i;
    for (i = 0; i < plans.length; i++) {
        if (plans[i].rate === rate && plans[i].safe) pool.push(plans[i]);
    }
    if (pool.length === 0) return null;

    var comfy = [];
    for (i = 0; i < pool.length; i++) {
        if (pool[i].comfy) comfy.push(pool[i]);
    }
    if (comfy.length > 0) pool = comfy;

    // Ít lãi nhất -> kỳ hạn ngắn nhất -> trả trước thấp nhất (giữ lại tiền mặt)
    pool.sort(function (x, y) {
        return (x.interest - y.interest) || (x.months - y.months) || (x.pct - y.pct);
    });
    return pool[0];
}

function maxAffordablePrice(cash, limit) {
    var best = 0;
    var rates = [0, CFG.financeRate];
    for (var r = 0; r < rates.length; r++) {
        for (var a = 0; a < CFG.prepayOptions.length; a++) {
            for (var b = 0; b < CFG.monthOptions.length; b++) {
                var rate = rates[r];
                var p = CFG.prepayOptions[a] / 100;
                var m = CFG.monthOptions[b];
                if (rate === 0 && m > CFG.zeroRateMaxMonths) continue;
                var byCash = cash / p;
                var byLimit = limit / ((1 - p) * (1 / m + rate));
                var price = Math.min(byCash, byLimit);
                if (price > best) best = price;
            }
        }
    }
    return Math.floor(best / 100000) * 100000;
}

function planRow(plan, label, key, isRecommended) {
    return '<tr' + (isRecommended ? ' class="success"' : '') + '>'
        + '<td>' + label + (isRecommended ? ' <span class="label label-success">Khuyến nghị</span>' : '') + '</td>'
        + '<td>' + plan.pct + '% (' + formatMoney(plan.prepay) + ')</td>'
        + '<td>' + plan.months + ' tháng</td>'
        + '<td><strong>' + formatMoney(plan.monthly) + '</strong></td>'
        + '<td>' + (plan.interest > 0 ? formatMoney(plan.interest) : '0 VNĐ') + '</td>'
        + '<td><button type="button" class="btn btn-xs btn-success" onclick="chonGoi(\'' + key + '\')">Chọn gói này</button></td>'
        + '</tr>';
}

function applyPlan(plan) {
    el('prepay_percent').value = plan.pct;
    el('months').value = plan.months;
    el('interest_rate').value = String(plan.rate);
    tinhTraGop();
}

function chonGoi(key) {
    if (lastPlans[key]) {
        applyPlan(lastPlans[key]);
        el('plan_section').scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

function phanTichTaiChinh() {
    var income = parseFloat(el('monthly_income').value) || 0;
    var expense = parseFloat(el('monthly_expense').value) || 0;
    var cash = parseFloat(el('available_cash').value) || 0;
    var price = parseFloat(el('product_price').value) || 0;
    var jobKey = el('user_job').value;
    var job = JOBS[jobKey] || JOBS.office;

    var box = el('financial_advice_box');
    el('advice_wrapper').style.display = 'block';
    lastPlans = {};

    // Bước 0: kiểm tra dữ liệu đầu vào
    if (price <= 0) {
        box.className = 'alert alert-warning';
        box.innerHTML = '<strong>Chưa có sản phẩm:</strong> Vui lòng chọn sản phẩm trong danh sách gợi ý (hoặc nhập giá) trước khi phân tích.';
        return;
    }
    syncProduct();

    // Bước 1: khả năng chi trả
    var effectiveIncome = income * job.haircut;
    var disposable = effectiveIncome - expense;
    if (disposable <= 0) {
        box.className = 'alert alert-danger';
        box.innerHTML = '<strong>Cảnh báo tài chính:</strong> Chi phí hàng tháng đang lớn hơn hoặc bằng thu nhập được ghi nhận'
            + (job.haircut < 1 ? ' (thu nhập của nhóm này chỉ được tính ' + Math.round(job.haircut * 100) + '% vì chưa ổn định)' : '')
            + '. Bạn chưa nên mua trả góp lúc này.';
        return;
    }
    var limit = Math.min(disposable * job.share, income * CFG.maxDtiOfIncome);

    var summary = '• Thu nhập dư sau chi phí: <strong>' + formatMoney(disposable) + '/tháng</strong>.<br>'
        + '• Khoản góp an toàn tối đa: <strong>' + formatMoney(limit) + '/tháng</strong> '
        + '(không quá ' + Math.round(job.share * 100) + '% thu nhập dư và ' + Math.round(CFG.maxDtiOfIncome * 100) + '% thu nhập).<br>';

    // Bước 2: thử mọi gói hợp lệ
    var plans = buildPlans(price, cash, limit);

    if (plans.length === 0) {
        var minPrepay = price * CFG.prepayOptions[0] / 100;
        box.className = 'alert alert-warning';
        box.innerHTML = '<strong>Chưa đủ tiền trả trước:</strong><br>' + summary
            + '• Gói trả góp yêu cầu trả trước tối thiểu <strong>' + CFG.prepayOptions[0] + '% = ' + formatMoney(minPrepay) + '</strong>, '
            + 'bạn đang có ' + formatMoney(cash) + ' (thiếu <strong>' + formatMoney(minPrepay - cash) + '</strong>).<br>'
            + '• Bạn có thể bổ sung tiền trả trước, hoặc chọn sản phẩm có giá tối đa khoảng <strong>' + formatMoney(maxAffordablePrice(cash, limit)) + '</strong>.';
        return;
    }

    var bestZero = pickBest(plans, 0);
    var bestFin = pickBest(plans, CFG.financeRate);

    if (!bestZero && !bestFin) {
        var minMonthly = plans[0].monthly;
        for (var i = 1; i < plans.length; i++) {
            if (plans[i].monthly < minMonthly) minMonthly = plans[i].monthly;
        }
        box.className = 'alert alert-warning';
        box.innerHTML = '<strong>Khoản góp vượt khả năng chi trả:</strong><br>' + summary
            + '• Với số tiền trả trước hiện có, khoản góp thấp nhất vẫn là <strong>' + formatMoney(minMonthly) + '/tháng</strong>.<br>'
            + '• Gợi ý: chọn sản phẩm có giá tối đa khoảng <strong>' + formatMoney(maxAffordablePrice(cash, limit)) + '</strong>, '
            + 'hoặc tăng tiền trả trước / nhờ người thân đồng đứng tên hồ sơ.';
        return;
    }

    // Bước 3: chọn gói khuyến nghị (ưu tiên ít lãi nhất)
    var recommended = bestZero || bestFin;
    var recKey = bestZero ? 'zero' : 'fin';
    if (bestZero) lastPlans.zero = bestZero;
    if (bestFin) lastPlans.fin = bestFin;
    applyPlan(recommended);

    var rows = '';
    if (bestZero) rows += planRow(bestZero, 'Thẻ tín dụng 0%', 'zero', recKey === 'zero');
    if (bestFin) rows += planRow(bestFin, 'Công ty tài chính (' + (CFG.financeRate * 100) + '%/tháng)', 'fin', recKey === 'fin');

    var note = bestZero
        ? 'Gói 0% tiết kiệm chi phí nhất nhưng cần có thẻ tín dụng. Nếu chưa có thẻ, hãy chọn gói công ty tài chính.'
        : 'Với số tiền trả trước và khả năng chi trả hiện tại, chỉ gói công ty tài chính phù hợp.';

    box.className = 'alert alert-success';
    box.innerHTML = '<strong>Đề xuất tối ưu cho bạn:</strong><br>' + summary
        + '<div class="table-responsive" style="margin: 8px 0;"><table class="table table-bordered table-condensed" style="background:#fff; margin-bottom:0;">'
        + '<thead><tr><th>Hình thức</th><th>Trả trước</th><th>Kỳ hạn</th><th>Góp/tháng</th><th>Tổng lãi</th><th></th></tr></thead>'
        + '<tbody>' + rows + '</tbody></table></div>'
        + '• ' + note + '<br>'
        + '• <em>Thủ tục:</em> ' + job.note + '<br>'
        + '• Gói khuyến nghị đã được điền sẵn ở phần "Thông tin gói trả góp" bên dưới, bạn có thể đổi gói rồi điền họ tên, số điện thoại để gửi cho cửa hàng.';
}
</script>
<!-- END: main -->
