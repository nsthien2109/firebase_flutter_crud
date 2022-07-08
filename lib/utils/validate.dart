// ignore_for_file: unnecessary_null_comparison

class ValidationForm {

 static String? emailValidate(String val){
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (val == null || val.isEmpty) {
        return 'Please enter email';
    }else if (!regExp.hasMatch(val)) {
        return 'Email Incorrect';
    }
    return null;
  }

 static String? passwordValidate(String val){
    const pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    final regExp = RegExp(pattern);
    if (val == null || val.isEmpty) {
        return 'Please enter your password';
    }else if (!regExp.hasMatch(val)) {
        return 'Password must be minimum eight characters, at least one letter and one number';
    }
    return null;
  }


 static String? textBoxValidate(String val){
    if (val == null || val.isEmpty) {
        return 'Please enter this field';
    }
    return null;
  }  
}