//
//  CommonConstants.swift
//  HuTi
//
//  Created by Nguyễn Thịnh on 10/03/2023.
//

import Foundation

struct CommonConstants {
    static let tableRowHeight = 130.0
    static let phoneNumber = "Số điện thoại"
    static let password = "Mật khẩu"
    static let confirmPassword = "Xác nhận mật khẩu"
    static let done = "Xong"
    static let cancel = "Thoát"
    static let edit = "Sửa"
    static let updateInfo = "Vui lòng cập nhật thông tin tài khoản!"
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let dateFormatAWSS3 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let networkError = "Lỗi kết nối mạng"
    static let firstSubtitle = "Hiện tại có"
    static let realEstate = "nhà đất"
    static let sell = "đang bán"
    static let forRent = "đang cho thuê"
    static let project = "dự án"
    static let pageSize = 5
    static let coordinate = [ProvinceCoordinate(name: "An Giang", lat: 10.5215836, long: 105.1258955),
                             ProvinceCoordinate(name: "Bà Rịa - Vũng Tàu", lat: 10.5417397, long: 107.2429976),
                             ProvinceCoordinate(name: "Bắc Giang", lat: 21.3014947, long: 106.6291304),
                             ProvinceCoordinate(name: "Bắc Kạn", lat: 22.1442685, long: 105.8345426),
                             ProvinceCoordinate(name: "Bạc Liêu", lat: 9.2940027, long: 105.7215663),
                             ProvinceCoordinate(name: "Bắc Ninh", lat: 21.1781766, long: 106.0710255),
                             ProvinceCoordinate(name: "Bến Tre", lat: 10.1081553, long: 106.4405872),
                             ProvinceCoordinate(name: "Bình Định", lat: 14.16653246, long: 108.9026830),
                             ProvinceCoordinate(name: "Bình Dương", lat: 11.3254024, long: 106.4770170),
                             ProvinceCoordinate(name: "Bình Phước", lat: 11.7511894, long: 106.7234639),
                             ProvinceCoordinate(name: "Bình Thuận", lat: 11.0903703, long: 108.072078),
                             ProvinceCoordinate(name: "Cà Mau", lat: 8.96240990, long: 105.1258955),
                             ProvinceCoordinate(name: "Cần Thơ", lat: 10.0653203, long: 105.5591218),
                             ProvinceCoordinate(name: "Cao Bằng", lat: 22.6666369, long: 106.2639852),
                             ProvinceCoordinate(name: "Đà Nẵng", lat: 16.0544563, long: 108.0717219),
                             ProvinceCoordinate(name: "Đắk Lắk", lat: 12.7100116, long: 108.2377519),
                             ProvinceCoordinate(name: "Đắk Nông", lat: 12.2646476, long: 107.6098060),
                             ProvinceCoordinate(name: "Điện Biên", lat: 21.8042309, long: 103.1076525),
                             ProvinceCoordinate(name: "Đồng Nai", lat: 11.0686305, long: 107.1675976),
                             ProvinceCoordinate(name: "Đồng Tháp", lat: 10.4937989, long: 105.6881788),
                             ProvinceCoordinate(name: "Gia Lai", lat: 13.8078943, long: 108.1093750),
                             ProvinceCoordinate(name: "Hà Giang", lat: 22.8025588, long: 104.9784494),
                             ProvinceCoordinate(name: "Hà Nam", lat: 20.5835196, long: 105.9229900),
                             ProvinceCoordinate(name: "Hà Nội", lat: 21.0031177, long: 105.8201408),
                             ProvinceCoordinate(name: "Hà Tĩnh", lat: 18.294377, long: 105.6745247),
                             ProvinceCoordinate(name: "Hải Dương", lat: 20.9385958, long: 106.3206861),
                             ProvinceCoordinate(name: "Hải Phòng", lat: 20.7976740, long: 106.5819789),
                             ProvinceCoordinate(name: "Hậu Giang", lat: 9.75789800, long: 105.6412527),
                             ProvinceCoordinate(name: "Hòa Bình", lat: 20.6861265, long: 105.3131185),
                             ProvinceCoordinate(name: "Hưng Yên", lat: 20.8525711, long: 106.0169971),
                             ProvinceCoordinate(name: "Khánh Hòa", lat: 12.2585098, long: 109.0526076),
                             ProvinceCoordinate(name: "Kiên Giang", lat: 9.82495870, long: 105.1258955),
                             ProvinceCoordinate(name: "Kon Tum", lat: 14.3497403, long: 108.0004606),
                             ProvinceCoordinate(name: "Lai Châu", lat: 22.3686613, long: 103.3119085),
                             ProvinceCoordinate(name: "Lâm Đồng", lat: 11.5752791, long: 108.1428669),
                             ProvinceCoordinate(name: "Lạng Sơn", lat: 21.8537080, long: 106.7615190),
                             ProvinceCoordinate(name: "Lào Cai", lat: 22.3380865, long: 104.1487055),
                             ProvinceCoordinate(name: "Long An", lat: 10.6955720, long: 106.2431205),
                             ProvinceCoordinate(name: "Nam Định", lat: 20.2791804, long: 106.2051484),
                             ProvinceCoordinate(name: "Nghệ An", lat: 19.2342489, long: 104.9200365),
                             ProvinceCoordinate(name: "Ninh Bình", lat: 20.2506149, long: 105.9744536),
                             ProvinceCoordinate(name: "Ninh Thuận", lat: 11.6738767, long: 108.8629572),
                             ProvinceCoordinate(name: "Phú Thọ", lat: 21.2684430, long: 105.2045573),
                             ProvinceCoordinate(name: "Phú Yên", lat: 13.0881861, long: 109.0928764),
                             ProvinceCoordinate(name: "Quảng Bình", lat: 17.6102715, long: 106.3487474),
                             ProvinceCoordinate(name: "Quảng Nam", lat: 15.5393538, long: 108.0191020),
                             ProvinceCoordinate(name: "Quảng Ngãi", lat: 15.0759838, long: 108.7125791),
                             ProvinceCoordinate(name: "Quảng Ninh", lat: 21.0063820, long: 107.2925144),
                             ProvinceCoordinate(name: "Quảng Trị", lat: 16.7403074, long: 107.1854679),
                             ProvinceCoordinate(name: "Sóc Trăng", lat: 9.60036880, long: 105.9599539),
                             ProvinceCoordinate(name: "Sơn La", lat: 21.1022284, long: 103.7289167),
                             ProvinceCoordinate(name: "Tây Ninh", lat: 11.3351554, long: 106.1098854),
                             ProvinceCoordinate(name: "Thái Bình", lat: 20.5386936, long: 106.3934777),
                             ProvinceCoordinate(name: "Thái Nguyên", lat: 21.5613771, long: 105.876004),
                             ProvinceCoordinate(name: "Thanh Hóa", lat: 20.1291279, long: 105.3131185),
                             ProvinceCoordinate(name: "Thừa Thiên Huế", lat: 16.4673970, long: 107.5905326),
                             ProvinceCoordinate(name: "Tiền Giang", lat: 10.4493324, long: 106.342050),
                             ProvinceCoordinate(name: "Hồ Chí Minh", lat: 10.8230989, long: 106.6296638),
                             ProvinceCoordinate(name: "Trà Vinh", lat: 9.81274100, long: 106.2992912),
                             ProvinceCoordinate(name: "Tuyên Quang", lat: 21.7767246, long: 105.2280196),
                             ProvinceCoordinate(name: "Vĩnh Long", lat: 10.2395740, long: 105.9571928),
                             ProvinceCoordinate(name: "Vĩnh Phúc", lat: 21.3608805, long: 105.5474373),
                             ProvinceCoordinate(name: "Yên Bái", lat: 21.7167689, long: 104.8985878)]
}

struct TextFieldPlaceHolder {
    static let typeRealEstate = "Loại nhà đất"
    static let typeProject = "Loại dự án"
    static let city = "Tỉnh, thành phố"
    static let district = "Quận, huyện"
    static let ward = "Phường, xã"
    static let street = "Đường phố"
    static let price = "Mức giá"
    static let acreage = "Diện tích"
    static let legal = "Giấy tờ pháp lý"
    static let funiture = "Nội thất"
    static let houseDirection = "Hướng nhà"
    static let balconyDirection = "Hướng ban công"
}

struct PickerTag {
    static let type = 0
    static let province = 1
    static let district = 2
    static let ward = 3
    static let project = 4
    static let price = 5
    static let acreage = 6
    static let legal = 7
    static let funiture = 8
    static let houseDirection = 9
    static let balconyDirection = 10
    static let bedroom = 11
    static let status = 12
    static let gender = 13
    static let dob = 14
}

struct ImageName {
    static let house = "house"
    static let project = "project"
    static let user = "user"
    static let list = "list"
    static let map = "map"
    static let backButton = "chevron.left"
    static let circle = "circle"
    static let checkmarkFill = "checkmark.circle.fill"
    static let save = "save"
    static let edit = "edit"
 }

struct ColorName {
    static let background = "background"
    static let themeText = "themeText"
    static let otpBackground = "otpBackground"
    static let gray = "gray"
    static let white = "white"
    static let black = "black"
    static let redStatusBackground = "redStatusBackground"
    static let greenStatusBackground = "greenStatusBackground"
    static let purpleStatusBackground = "purpleStatusBackground"
    static let redStatusText = "redStatusText"
    static let greenStatusText = "greenStatusText"
    static let purpleStatusText = "purpleStatusText"
}

struct TabBarItemTitle {
    static let sell = "Bán"
    static let forRent = "Cho thuê"
    static let project = "Dự án"
    static let account = "Tài khoản"
}
    
struct ClassNibName {
    static let FilterResultViewController = "FilterResultViewController"
    static let FilterViewController = "FilterViewController"
    static let PostedViewController = "PostedViewController"
    static let OTPViewController = "OTPViewController"
    static let ConfirmPasswordViewController = "ConfirmPasswordViewController"
    static let PostDetailViewController = "PostDetailViewController"
    static let ProjectDetailViewController = "ProjectDetailViewController"
    static let SignUpViewController = "SignUpViewController"
    static let NewPostViewController = "NewPostViewController"
    static let UserDetailViewController = "UserDetailViewController"
}

struct MainTitle {
    static let sell = "Nhà đất bán"
    static let forRent = "Nhà đất cho thuê"
    static let project = "Dự án"
    static let postedPosts = "Các tin đã đăng"
    static let favoritePosts = "Tin đăng yêu thích"
}

struct RealEstateType {
    static let newPostSell = [Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.projectLand, Self.land, Self.farmResort, Self.codontel, Self.wareHouseFactory, Self.otherRealEstate]
    static let sell = [Self.all, Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.projectLand, Self.land, Self.farmResort, Self.codontel, Self.wareHouseFactory, Self.otherRealEstate]
    static let newPostForRent = [Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.motel, Self.office, Self.shopKiosk, Self.wareHouseFactory, Self.land, Self.otherRealEstate]
    static let forRent = [Self.all, Self.apartment, Self.home, Self.villa, Self.streetHouse, Self.shopHouse, Self.motel, Self.office, Self.shopKiosk, Self.wareHouseFactory, Self.land, Self.otherRealEstate]
    
    static let project = ["Tất cả dự án", Self.apartment, "Cao ốc văn phòng", "Trung tâm thương mại", "Khu đô thị mới", "Khu phức hợp", "Nhà ở xã hội", "Khu nghỉ dưỡng, Sinh thái", "Khu công nghiệp", "Biệt thự liền kề", "Shophouse", Self.streetHouse, "Dự án khác"]
    
    static let all = "Tất cả nhà đất"
    static let apartment = "Căn hộ chung cư"
    static let home = "Nhà riêng"
    static let villa = "Nhà biệt thự, liền kề"
    static let streetHouse = "Nhà mặt phố"
    static let shopHouse = "Nhà phố thương mại"
    static let projectLand = "Đất nền dự án"
    static let land = "Đất"
    static let farmResort = "Trang trại, khu nghỉ dưỡng"
    static let codontel = "Codontel"
    static let motel = "Nhà trọ, phòng trọ"
    static let office = "Văn phòng"
    static let shopKiosk = "Cửa hàng, kiot"
    static let wareHouseFactory = "Kho, nhà xưởng"
    static let otherRealEstate = "Bất động sản khác"
}

struct PickerData {
    static let price = ["Tất cả mức giá", "Dưới 500 triệu", "500 - 800 triệu", "800 triệu - 1 tỷ", "1 - 2 tỷ", "2 - 3 tỷ", "3 - 5 tỷ", "5 - 7 tỷ", "7 - 10 tỷ", "10 - 20 tỷ", "20 - 30 tỷ", "30 - 40 tỷ", "40 - 60 tỷ", "Trên 60 tỷ"]
    static let acreage = ["Tất cả diện tích", "Dưới 30 m²", "30 - 50 m²", "50 - 80 m²", "80 - 100 m²", "100 - 150 m²", "150 - 200 m²", "200 - 250 m²", "250 - 300 m²", "300 - 500 m²", "Trên 500 m²"]
    static let bedroom = ["1 phòng ngủ", "2 phòng ngủ", "3 phòng ngủ", "4 phòng ngủ", "Từ 5 phòng ngủ trở lên"]
    static let direction = ["Đông", "Tây", "Nam", "Bắc", "Đông - Bắc", "Tây - Bắc", "Tây - Nam", "Đông - Nam"]
    static let status = ["Sắp mở bán", "Đang mở bán", "Đã bàn giao"]
    static let legal = ["Sổ đỏ/ Sổ hồng", "Hợp đồng mua bán", "Đang chờ sổ"]
    static let funiture = ["Đầy đủ", "Cơ bản", "Không nội thất"]
    static let gender = ["Nam", "Nữ", "Khác"]
    static let day = ["01", "02", "03"]
    static let projectPrice = ["Tất cả mức giá", "Dưới 5 triệu/m2", "5 - 10 triệu/m2", "10 - 20 triệu/m2", "20 - 35 triệu/m2", "35 - 50 triệu/m2", "50 - 80 triệu/m2", "Trên 80 triệu/m2"]
}

enum SubviewTag: Int {
    case otherView
    case detailView
}

struct RegexConstants {
    static let PHONE_NUMBER = "^0\\d{9}$"
    static let PASSWORD = "^\\S{5,20}$"
    static let DOUBLE = #"^\d+(\.\d+)?$"#
    //static let NUMBER = "^\\d{1,}$"
}

struct Alert {
    static let numberOfPhoneNumber = "Số điện thoại phải có 10 chữ số"
    static let numberOfPass = "Mật khẩu phải có ít nhất 5 ký tự"
    static let ok = "OK"
    static let wrongSignInInfo = "Thông tin đăng nhập không đúng"
    static let registedPhoneNumber = "Số điện thoại đã được đăng ký"
    static let nonRegistedPhoneNumber = "Số điện thoại chưa được đăng ký"
    static let wrongOTP = "OTP không đúng"
    static let notTheSamePass = "Mật khẩu và xác nhận mật khẩu không giống nhau"
    static let phoneBeginByZero = "Số điện thoại phải bắt đầu bằng số 0"
    static let pleaseUpdateAccountInfo = "Vui lòng cập nhật thông tin tài khoản"
    static let updatedAccountSuccessfully = "Cập nhật tài khoản thành công"
    static let postSuccessfully = "Tin đăng sẽ được xem xét duyệt và đăng lên sớm nhất"
    static let pleaseChooseTypeProvince = "Vui lòng chọn loại và tỉnh thành"
}
