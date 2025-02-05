enum SkincareCategoryEnum {
  // Temizleyiciler (Cleansers)
  gelCleanser('Gel Cleanser'),
  foamCleanser('Foam Cleanser'),
  creamCleanser('Cream Cleanser'),
  oilCleanser('Oil Cleanser'),
  micellarWater('Micellar Water'),

  // Tonikler (Toners)
  hydratingToner('Hydrating Toner'),
  exfoliatingToner('Exfoliating Toner'),
  balancingToner('Balancing Toner'),

  // Serumlar (Serums)
  vitaminCSerum('Vitamin C Serum'),
  hyaluronicAcidSerum('Hyaluronic Acid Serum'),
  niacinamideSerum('Niacinamide Serum'),
  retinolSerum('Retinol Serum'),

  // Nemlendiriciler (Moisturizers)
  gelMoisturizer('Gel Moisturizer'),
  creamMoisturizer('Cream Moisturizer'),
  lotionMoisturizer('Lotion Moisturizer'),
  balmMoisturizer('Balm Moisturizer'),

  // Güneş Koruyucular (Sunscreens)
  chemicalSunscreen('Chemical Sunscreen'),
  physicalSunscreen('Physical Sunscreen'),

  // Maskeler (Masks)
  clayMask('Clay Mask'),
  sheetMask('Sheet Mask'),
  overnightMask('Overnight Mask'),

  // Peeling ve Eksfoliasyon (Exfoliators)
  chemicalExfoliant('Chemical Exfoliant'),
  physicalExfoliant('Physical Exfoliant'),

  // Göz Bakımı (Eye Care)
  eyeCream('Eye Cream'),
  eyeSerum('Eye Serum'),

  // Dudak Bakımı (Lip Care)
  lipBalm('Lip Balm'),
  lipScrub('Lip Scrub');

  final String value;

  const SkincareCategoryEnum(this.value);
}
