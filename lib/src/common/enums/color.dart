enum ColorCode {
  // Kırmızı tonları
  brightRed('#FF0000'),
  darkRed('#8B0000'),
  crimsonRed('#DC143C'),
  fireBrickRed('#B22222'),

  // Mavi tonları
  skyBlue('#87CEEB'),
  navyBlue('#000080'),
  royalBlue('#4169E1'),
  dodgerBlue('#1E90FF'),

  // Yeşil tonları
  limeGreen('#32CD32'),
  darkGreen('#006400'),
  forestGreen('#228B22'),
  mediumSeaGreen('#3CB371'),

  // Sarı tonları
  lightYellow('#FFFFE0'),
  goldenrod('#DAA520'),
  mustardYellow('#FFDB58'),
  lemonChiffon('#FFFACD'),

  // Mor tonları
  mediumPurple('#9370DB'),
  darkOrchid('#9932CC'),
  slateBlue('#6A5ACD'),
  lavender('#E6E6FA'),

  // Turuncu tonları
  orange('#FFA500'),
  darkOrange('#FF8C00'),
  coral('#FF7F50'),
  salmon('#FA8072'),

  // Pembe tonları
  deepPink('#FF1493'),
  hotPink('#FF69B4'),
  lightPink('#FFB6C1'),
  paleVioletRed('#DB7093'),

  // Kahverengi tonları
  saddlebrown('#8B4513'),
  chocolate('#D2691E'),
  peru('#CD853F'),
  sienna('#A0522D'),

  // Gri tonları
  lightGray('#D3D3D3'),
  gray('#808080'),
  dimGray('#696969'),
  darkGray('#A9A9A9'),

  // Beyaz ve siyah tonları
  white('#FFFFFF'),
  black('#000000'),
  ivory('#FFFFF0'),
  snow('#FFFAFA');

  final String hexCode;

  const ColorCode(this.hexCode);
}
