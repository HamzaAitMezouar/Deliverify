import 'package:get/get.dart';

class TranslationLocale extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "1": "انشاء حساب",
          "2": "تسجيل الدخول",
          "3": "لديك حساب بالفعل ؟",
          "4": "الدخول عبر غوغل",
          "5": "الدخول عبر فيسبوك"
        },
        "en": {
          "1": "Register",
          "2": "Login",
          "3": "You Already Have An Account ?",
          "4": "Sign in with Google",
          "5": "Sign in with Facebook"
        },
        "fr": {
          "1": "S'inscrire",
          "2": "Connexion",
          "3": "Avez vous déjà un compte ?",
          "4": "Connectez-vous avec Google",
          "5": "Connectez-vous avec Facebook"
        },
        "es": {
          "1": "Registro",
          "2": "Acceso",
          "3": "Ya tienes una cuenta ?",
          "4": "Inicia sesión con Google",
          "5": "Inicia sesión con Facebook"
        }
      };
}
