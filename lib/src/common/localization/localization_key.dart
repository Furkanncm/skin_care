import 'package:bloc_clean_architecture/src/common/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_key_extension.dart';

enum LocalizationKey {
  login('Login'), // Giriş Yap
  createAccount('CreateAccount'), // Hesap Oluştur
  username('Username'), // Kullanıcı Adı
  nameSurname('NameSurname'), // Ad Soyad
  phoneNumber('PhoneNumber'), // Telefon Numarası
  phoneNumberMustStartWithFive('PhoneNumberMustStartWithFive'), // Telefon Numarası 5 ile başlamalıdır
  phoneNumberMustBeTenDigits('PhoneNumberMustBeTenDigits'), // Telefon numarası 10 haneli olmalıdır
  nameAndSurnameMustBeAtLeastTwoCharacters('NameAndSurnameMustBeAtLeastTwoCharacters'), // Ad ve soyad en az 2 karakterden oluşmalıdır
  fieldRequired('FieldRequired'), // Zorunlu alan
  passwordMustBeAtLeastFourCharacters('PasswordMustBeAtLeastFourCharacters'), // Şifre en az 4 karakter olmalıdır
  enterValidEmail('EnterValidEmail'), // Geçerli bir e-posta adresi giriniz
  passwordsDoNotMatch('PasswordsDoNotMatch'), // Şifreler eşleşmiyor
  password('Password'), // Şifre
  passwordAgain('PasswordAgain'), // Şifre Tekrar
  forgotPassword('ForgotPassword'), // Şifremi Unuttum
  email('Email'), // E-posta
  sendCode('SendCode'), // Kod Gönder
  myProfile('MyProfile'), // Profilim
  save('Save'), // Kaydet
  dataCouldNotBeFetched('DataCouldNotBeFetched'), // Veri alınamadı
  regenerationTime('RegenerationTime'), // Yeniden oluşturma süresi
  minutes('Minutes'), // Dakika
  unknownErrorOccured('UnknownErrorOccured'), // Bilinmeyen bir hata oluştu
  success('Success'), // Başarılı
  operationSuccessful('OperationSuccessful'), // İşlem Başarılı
  deletionConfirmation('DeletionConfirmation'), // Silme Onayı
  deletionConfirmationExplanation('DeletionConfirmationExplanation'), // Silme işlemi geri alınamaz. Devam etmek istediğinize emin misiniz?
  delete('Delete'), // Sil
  giveUp('GiveUp'), // Vazgeç
  cancel('Cancel'), // İptal
  add('Add'), // Ekle
  changePassword('ChangePassword'), // Şifre Değiştir
  changeLocale('ChangeLocale'), // Dil Değiştir
  logout('Logout'), // Çıkış Yap
  logoutConfirmation('LogoutConfirmation'), // Çıkış yapmak istediğinize emin misiniz?
  currentPassword('CurrentPassword'), // Mevcut Şifre
  newPassword('NewPassword'), // Yeni Şifre
  newPasswordAgain('NewPasswordAgain'), // Yeni Şifre Tekrar
  changePasswordDescription('ChangePasswordDescription'), // Şifrenizi değiştirmek için mevcut şifrenizi ve yeni şifrenizi giriniz
  retry('Retry'), // Tekrar Dene
  noDataInList('NoDataInList'), // Listede veri bulunamadı
  approve('Approve'), // Onayla
  notifications('Notifications'), // Bildirimler
  homePage('HomePage'), // Ana Sayfa
  all('All'), // Tümü
  thisMonth('ThisMonth'), // Bu Ay
  thisWeek('ThisWeek'), // Bu Hafta
  settings('Settings'), // Ayarlar
  update('Update'), // Güncelle
  dateRange('DateRange'), // Tarih Aralığı
  begin('Begin'), // Başlangıç
  end('End'), // Bitiş
  filter('Filter'), // Filtrele
  filters('Filters'), // Filtreler
  applyFilter('ApplyFilter'), // Filtreyi Uygula
  changeTheme('ChangeTheme'), // Tema Değiştir
  light('Light'), // Açık
  dark('Dark'), // Koyu
  error('Error'), // Hata
  ok('Ok'), // Tamam
  newVersionAvailable('NewVersionAvailable'), // Yeni versiyon mevcut
  applicationUnderMaintenance('ApplicationUnderMaintenance'), // Uygulama Bakımda
  applicationUnderMaintenanceDescription('ApplicationUnderMaintenanceDescription'), // Uygulamamız şu anda bakım çalışması nedeniyle kullanıma kapalıdır. Kısa süre içerisinde tekrar hizmetinizde olacağız.
  dailyRoutine('Daily Routine'), 
  goNow("Back to Today"),
  ;

  const LocalizationKey(this.value);

  final String value;
}
