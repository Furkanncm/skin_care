import 'package:bloc_clean_architecture/src/common/localization/bloc/localization_bloc.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/culture.dart';
import 'package:bloc_clean_architecture/src/data/model/localization/response/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_key_extension.dart';

enum LocalizationKey {
  login('Login'), // Giriş Yap
  signUp('Sign Up'),
  routines("Routines"),
  createAccount('Create Account'), // Hesap Oluştur
  alreadyHaveAccount(" Already have an account?"),
  username('Username'), // Kullanıcı Adı
  name('Name'), // ad
  surname('Surname'),
  phoneNumber('PhoneNumber'), // Telefon Numarası
  phoneNumberMustStartWithFive('PhoneNumberMustStartWithFive'), // Telefon Numarası 5 ile başlamalıdır
  phoneNumberMustBeTenDigits('PhoneNumberMustBeTenDigits'), // Telefon numarası 10 haneli olmalıdır
  nameAndSurnameMustBeAtLeastTwoCharacters('NameAndSurnameMustBeAtLeastTwoCharacters'), // Ad ve soyad en az 2 karakterden oluşmalıdır
  fieldRequired('Field Required'), // Zorunlu alan
  passwordMustBeAtLeastFourCharacters('PasswordMustBeAtLeastFourCharacters'), // Şifre en az 4 karakter olmalıdır
  enterValidEmail('EnterValidEmail'), // Geçerli bir e-posta adresi giriniz
  passwordsDoNotMatch('PasswordsDoNotMatch'), // Şifreler eşleşmiyor
  password('Password'), // Şifre
  passwordAgain('Password Again'), // Şifre Tekrar
  forgotPassword('Forgot Password?'), // Şifremi Unuttum
  email('Email'), // E-posta
  sendCode('SendCode'), // Kod Gönder
  myProfile('Profile'), // Profilim
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
  giveUp('Give Up'), // Vazgeç
  cancel('Cancel'), // İptal
  add('Add'), // Ekle
  changePassword('ChangePassword'), // Şifre Değiştir
  changeLocale('ChangeLocale'), // Dil Değiştir
  logout('Log Out'), // Çıkış Yap
  logoutConfirmation('Do you want to log out skin care app?'), // Çıkış yapmak istediğinize emin misiniz?
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
  light('Light Mode'), // Açık
  dark('Dark Mode'), // Koyu
  error('Error'), // Hata
  ok('Ok'), // Tamam
  newVersionAvailable('NewVersionAvailable'), // Yeni versiyon mevcut
  applicationUnderMaintenance('ApplicationUnderMaintenance'), // Uygulama Bakımda
  applicationUnderMaintenanceDescription('ApplicationUnderMaintenanceDescription'), // Uygulamamız şu anda bakım çalışması nedeniyle kullanıma kapalıdır. Kısa süre içerisinde tekrar hizmetinizde olacağız.
  dailyRoutine('Daily Routine'),
  goNow("Back to Today"),
  inValidEmail("Invalid Email "),
  cantEmptyPassword("Password can not be empty"),
  cantEmptyEmail("Email can not be empty"),
  cantEmptyName("Name can not be empty"),
  cantEmptySurname("Surname can not be empty"),
  cantEmptyDescription("Description can not be empty"),
  cantEmptyColor("Color can not be empty"),
  cantEmptyCategory("Category can not be empty"),
  password6char("Password must be at least 6 characters"),
  passwordbigChar("Password must be at least 1 upper case character"),
  password1number("Password must be at least 1 number "),
  welcome("Welcome!"),
  firstLogin("Please log in to continue"),
  noAccount("You don't have an account?"),
  slogan("Your skin glows with you! 🌿✨ Create your own skincare routine and shine!"),
  sloganWithUserName(", your skin deserves the best! ✨🌿 Create your perfect skincare routine today!"),
  sloganForLogin("Radiant skin, confident you! 🌸✨ Start your skincare journey today!"),
  accountCreatedSuccess("Your account has been created successfully."),
  cosmetics("Cosmetics"),
  addNewProduct("Add New Product"),
  plans("Plans"),
  addPhoto("Add Photo"),
  description("Description"),
  descriptionForCosmetic("You can add your cosmetic products to your list by entering the information below."),
  category("Category"),
  chooseCategory("Choose Category"),
  color("Color"),
  pickColor("Pick Color"),
  suggestionFieldToBeCorrected("Please correct the fields below."),
  takePhotoFromCamera("Take Photo From Camera"),
  choosePhotoFromGallery("Choose Photo From Gallery"),
  mustPickAPhoto("You must select a photo"),
  warning("Warning"),
  productAddedSuccessfully("Product added successfully"),
  productRemovedSuccessfully("Product removed successfully"),
  productCouldNotBeAdded("Product could not be added"),
  makeYourRoutine("Make Your Routine"),
  morning("Morning"),
  evening("Evening"),
  thereIsNoCosmetic("There is no cosmetic in your list"),
  prepareYourPlan("Prepare Your Plan"),
  pleaseCheckYourRoutine("Please choose between morning or evening options."),
  pleaseAddCosmetics("Please add at least 1 cosmetic in your routine list"),
  thereIsAPlanForThatDay("There is a plan for that day"),
  youSureUpdate("Do you want to update the plan?"),
  ;

  const LocalizationKey(this.value);

  final String value;
}
