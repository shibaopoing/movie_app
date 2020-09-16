class SmsCodeDto {
  String phoneNumber;
  String verifyCode;
  String useType;

  SmsCodeDto(this.phoneNumber, this.useType);

  SmsCodeDto.fromJson(Map<String, dynamic> json)
      : phoneNumber = json['userName'],
        verifyCode = json['verifyCode'],
        useType = json['useType'];

  Map<String, String> toJson() => {
        'phoneNumber': phoneNumber,
        'verifyCode': verifyCode,
        'useType': useType,
      };
}
