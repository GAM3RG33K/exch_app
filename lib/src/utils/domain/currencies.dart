const kUSD = "USD";
const kAED = "AED";
const kAFN = "AFN";
const kALL = "ALL";
const kAMD = "AMD";
const kANG = "ANG";
const kAOA = "AOA";
const kARS = "ARS";
const kAUD = "AUD";
const kAWG = "AWG";
const kAZN = "AZN";
const kBAM = "BAM";
const kBBD = "BBD";
const kBDT = "BDT";
const kBGN = "BGN";
const kBHD = "BHD";
const kBIF = "BIF";
const kBMD = "BMD";
const kBND = "BND";
const kBOB = "BOB";
const kBRL = "BRL";
const kBSD = "BSD";
const kBTC = "BTC";
const kBTN = "BTN";
const kBWP = "BWP";
const kBYN = "BYN";
const kBYR = "BYR";
const kBZD = "BZD";
const kCAD = "CAD";
const kCDF = "CDF";
const kCHF = "CHF";
const kCLF = "CLF";
const kCLP = "CLP";
const kCNY = "CNY";
const kCNH = "CNH";
const kCOP = "COP";
const kCRC = "CRC";
const kCUC = "CUC";
const kCUP = "CUP";
const kCVE = "CVE";
const kCZK = "CZK";
const kDJF = "DJF";
const kDKK = "DKK";
const kDOP = "DOP";
const kDZD = "DZD";
const kEGP = "EGP";
const kERN = "ERN";
const kETB = "ETB";
const kEUR = "EUR";
const kFJD = "FJD";
const kFKP = "FKP";
const kGBP = "GBP";
const kGEL = "GEL";
const kGGP = "GGP";
const kGHS = "GHS";
const kGIP = "GIP";
const kGMD = "GMD";
const kGNF = "GNF";
const kGTQ = "GTQ";
const kGYD = "GYD";
const kHKD = "HKD";
const kHNL = "HNL";
const kHRK = "HRK";
const kHTG = "HTG";
const kHUF = "HUF";
const kIDR = "IDR";
const kILS = "ILS";
const kIMP = "IMP";
const kINR = "INR";
const kIQD = "IQD";
const kIRR = "IRR";
const kISK = "ISK";
const kJEP = "JEP";
const kJMD = "JMD";
const kJOD = "JOD";
const kJPY = "JPY";
const kKES = "KES";
const kKGS = "KGS";
const kKHR = "KHR";
const kKMF = "KMF";
const kKPW = "KPW";
const kKRW = "KRW";
const kKWD = "KWD";
const kKYD = "KYD";
const kKZT = "KZT";
const kLAK = "LAK";
const kLBP = "LBP";
const kLKR = "LKR";
const kLRD = "LRD";
const kLSL = "LSL";
const kLTL = "LTL";
const kLVL = "LVL";
const kLYD = "LYD";
const kMAD = "MAD";
const kMDL = "MDL";
const kMGA = "MGA";
const kMKD = "MKD";
const kMMK = "MMK";
const kMNT = "MNT";
const kMOP = "MOP";
const kMRU = "MRU";
const kMUR = "MUR";
const kMVR = "MVR";
const kMWK = "MWK";
const kMXN = "MXN";
const kMYR = "MYR";
const kMZN = "MZN";
const kNAD = "NAD";
const kNGN = "NGN";
const kNIO = "NIO";
const kNOK = "NOK";
const kNPR = "NPR";
const kNZD = "NZD";
const kOMR = "OMR";
const kPAB = "PAB";
const kPEN = "PEN";
const kPGK = "PGK";
const kPHP = "PHP";
const kPKR = "PKR";
const kPLN = "PLN";
const kPYG = "PYG";
const kQAR = "QAR";
const kRON = "RON";
const kRSD = "RSD";
const kRUB = "RUB";
const kRWF = "RWF";
const kSAR = "SAR";
const kSBD = "SBD";
const kSCR = "SCR";
const kSDG = "SDG";
const kSEK = "SEK";
const kSGD = "SGD";
const kSHP = "SHP";
const kSLE = "SLE";
const kSLL = "SLL";
const kSOS = "SOS";
const kSRD = "SRD";
const kSTD = "STD";
const kSVC = "SVC";
const kSYP = "SYP";
const kSZL = "SZL";
const kTHB = "THB";
const kTJS = "TJS";
const kTMT = "TMT";
const kTND = "TND";
const kTOP = "TOP";
const kTRY = "TRY";
const kTTD = "TTD";
const kTWD = "TWD";
const kTZS = "TZS";
const kUAH = "UAH";
const kUGX = "UGX";
const kUYU = "UYU";
const kUZS = "UZS";
const kVES = "VES";
const kVND = "VND";
const kVUV = "VUV";
const kWST = "WST";
const kXAF = "XAF";
const kXAG = "XAG";
const kXAU = "XAU";
const kXCD = "XCD";
const kXDR = "XDR";
const kXOF = "XOF";
const kXPF = "XPF";
const kYER = "YER";
const kZAR = "ZAR";
const kZMK = "ZMK";
const kZMW = "ZMW";
const kZWL = "ZWL";

const currencyNameMap = <String, String>{
  kUSD: "United States Dollar",
  kAED: "United Arab Emirates Dirham",
  kAFN: "Afghan Afghani",
  kALL: "Albanian Lek",
  kAMD: "Armenian Dram",
  kANG: "Netherlands Antillean Guilder",
  kAOA: "Angolan Kwanza",
  kARS: "Argentine Peso",
  kAUD: "Australian Dollar",
  kAWG: "Aruban Florin",
  kAZN: "Azerbaijani Manat",
  kBAM: "Bosnia and Herzegovina Convertible Mark",
  kBBD: "Barbadian Dollar",
  kBDT: "Bangladeshi Taka",
  kBGN: "Bulgarian Lev",
  kBHD: "Bahraini Dinar",
  kBIF: "Burundian Franc",
  kBMD: "Bermudian Dollar",
  kBND: "Brunei Dollar",
  kBOB: "Bolivian Boliviano",
  kBRL: "Brazilian Real",
  kBSD: "Bahamian Dollar",
  kBTC: "Bitcoin",
  kBTN: "Bhutanese Ngultrum",
  kBWP: "Botswana Pula",
  kBYN: "Belarusian Ruble",
  kBYR: "Belarusian Ruble (old)",
  kBZD: "Belize Dollar",
  kCAD: "Canadian Dollar",
  kCDF: "Congolese Franc",
  kCHF: "Swiss Franc",
  kCLF: "Chilean Unit of Account (UF)",
  kCLP: "Chilean Peso",
  kCNY: "Chinese Yuan",
  kCNH: "Chinese Yuan (offshore)",
  kCOP: "Colombian Peso",
  kCRC: "Costa Rican Colón",
  kCUC: "Cuban Convertible Peso",
  kCUP: "Cuban Peso",
  kCVE: "Cape Verdean Escudo",
  kCZK: "Czech Koruna",
  kDJF: "Djiboutian Franc",
  kDKK: "Danish Krone",
  kDOP: "Dominican Peso",
  kDZD: "Algerian Dinar",
  kEGP: "Egyptian Pound",
  kERN: "Eritrean Nakfa",
  kETB: "Ethiopian Birr",
  kEUR: "Euro",
  kFJD: "Fijian Dollar",
  kFKP: "Falkland Islands Pound",
  kGBP: "British Pound Sterling",
  kGEL: "Georgian Lari",
  kGGP: "Guernsey Pound",
  kGHS: "Ghanaian Cedi",
  kGIP: "Gibraltar Pound",
  kGMD: "Gambian Dalasi",
  kGNF: "Guinean Franc",
  kGTQ: "Guatemalan Quetzal",
  kGYD: "Guyanese Dollar",
  kHKD: "Hong Kong Dollar",
  kHNL: "Honduran Lempira",
  kHRK: "Croatian Kuna",
  kHTG: "Haitian Gourde",
  kHUF: "Hungarian Forint",
  kIDR: "Indonesian Rupiah",
  kILS: "Israeli New Shekel",
  kIMP: "Manx Pound",
  kINR: "Indian Rupee",
  kIQD: "Iraqi Dinar",
  kIRR: "Iranian Rial",
  kISK: "Icelandic Króna",
  kJEP: "Jersey Pound",
  kJMD: "Jamaican Dollar",
  kJOD: "Jordanian Dinar",
  kJPY: "Japanese Yen",
  kKES: "Kenyan Shilling",
  kKGS: "Kyrgyzstani Som",
  kKHR: "Cambodian Riel",
  kKMF: "Comorian Franc",
  kKPW: "North Korean Won",
  kKRW: "South Korean Won",
  kKWD: "Kuwaiti Dinar",
  kKYD: "Cayman Islands Dollar",
  kKZT: "Kazakhstani Tenge",
  kLAK: "Lao Kip",
  kLBP: "Lebanese Pound",
  kLKR: "Sri Lankan Rupee",
  kLRD: "Liberian Dollar",
  kLSL: "Lesotho Loti",
  kLTL: "Lithuanian Litas",
  kLVL: "Latvian Lats",
  kLYD: "Libyan Dinar",
  kMAD: "Moroccan Dirham",
  kMDL: "Moldovan Leu",
  kMGA: "Malagasy Ariary",
  kMKD: "Macedonian Denar",
  kMMK: "Myanmar Kyat",
  kMNT: "Mongolian Tögrög",
  kMOP: "Macanese Pataca",
  kMRU: "Mauritanian Ouguiya",
  kMUR: "Mauritian Rupee",
  kMVR: "Maldivian Rufiyaa",
  kMWK: "Malawian Kwacha",
  kMXN: "Mexican Peso",
  kMYR: "Malaysian Ringgit",
  kMZN: "Mozambican Metical",
  kNAD: "Namibian Dollar",
  kNGN: "Nigerian Naira",
  kNIO: "Nicaraguan Córdoba",
  kNOK: "Norwegian Krone",
  kNPR: "Nepalese Rupee",
  kNZD: "New Zealand Dollar",
  kOMR: "Omani Rial",
  kPAB: "Panamanian Balboa",
  kPEN: "Peruvian Sol",
  kPGK: "Papua New Guinean Kina",
  kPHP: "Philippine Peso",
  kPKR: "Pakistani Rupee",
  kPLN: "Polish Zloty",
  kPYG: "Paraguayan Guarani",
  kQAR: "Qatari Rial",
  kRON: "Romanian Leu",
  kRSD: "Serbian Dinar",
  kRUB: "Russian Ruble",
  kRWF: "Rwandan Franc",
  kSAR: "Saudi Riyal",
  kSBD: "Solomon Islands Dollar",
  kSCR: "Seychellois Rupee",
  kSDG: "Sudanese Pound",
  kSEK: "Swedish Krona",
  kSGD: "Singapore Dollar",
  kSHP: "Saint Helena Pound",
  kSLE: "Sierra Leonean Leone",
  kSLL: "Sierra Leonean Leone (old)",
  kSOS: "Somali Shilling",
  kSRD: "Surinamese Dollar",
  kSTD: "São Tomé and Príncipe Dobra",
  kSVC: "Salvadoran Colón",
  kSYP: "Syrian Pound",
  kSZL: "Swazi Lilangeni",
  kTHB: "Thai Baht",
  kTJS: "Tajikistani Somoni",
  kTMT: "Turkmenistani Manat",
  kTND: "Tunisian Dinar",
  kTOP: "Tongan Paʻanga",
  kTRY: "Turkish Lira",
  kTTD: "Trinidad and Tobago Dollar",
  kTWD: "New Taiwan Dollar",
  kTZS: "Tanzanian Shilling",
  kUAH: "Ukrainian Hryvnia",
  kUGX: "Ugandan Shilling",
  kUYU: "Uruguayan Peso",
  kUZS: "Uzbekistani Som",
  kVES: "Venezuelan Bolívar",
  kVND: "Vietnamese Dong",
  kVUV: "Vanuatu Vatu",
  kWST: "Samoan Tala",
  kXAF: "Central African CFA Franc",
  kXAG: "Silver Ounce",
  kXAU: "Gold Ounce",
  kXCD: "East Caribbean Dollar",
  kXDR: "Special Drawing Rights",
  kXOF: "West African CFA Franc",
  kXPF: "CFP Franc",
  kYER: "Yemeni Rial",
  kZAR: "South African Rand",
  kZMK: "Zambian Kwacha (old)",
  kZMW: "Zambian Kwacha",
  kZWL: "Zimbabwean Dollar",
};

const currencySymbolMap = <String, String>{
  kUSD: r"$",
  kAED: r"د.إ",
  kAFN: r"؋",
  kALL: r"L",
  kAMD: r"֏",
  kANG: r"ƒ",
  kAOA: r"Kz",
  kARS: r"$",
  kAUD: r"$",
  kAWG: r"ƒ",
  kAZN: r"₼",
  kBAM: r"KM",
  kBBD: r"$",
  kBDT: r"৳",
  kBGN: r"лв",
  kBHD: r"د.ب",
  kBIF: r"FBu",
  kBMD: r"$",
  kBND: r"$",
  kBOB: r"Bs.",
  kBRL: r"R$",
  kBSD: r"$",
  kBTC: r"₿",
  kBTN: r"Nu.",
  kBWP: r"P",
  kBYN: r"Br",
  kBYR: r"p.",
  kBZD: r"BZ$",
  kCAD: r"$",
  kCDF: r"FC",
  kCHF: r"CHF",
  kCLF: r"UF",
  kCLP: r"$",
  kCNY: r"¥",
  kCNH: r"¥",
  kCOP: r"$",
  kCRC: r"₡",
  kCUC: r"$",
  kCUP: r"₱",
  kCVE: r"$",
  kCZK: r"Kč",
  kDJF: r"Fdj",
  kDKK: r"kr",
  kDOP: r"RD$",
  kDZD: r"د.ج",
  kEGP: r"ج.م",
  kERN: r"Nfk",
  kETB: r"Br",
  kEUR: r"€",
  kFJD: r"$",
  kFKP: r"£",
  kGBP: r"£",
  kGEL: r"₾",
  kGGP: r"£",
  kGHS: r"₵",
  kGIP: r"£",
  kGMD: r"D",
  kGNF: r"FG",
  kGTQ: r"Q",
  kGYD: r"$",
  kHKD: r"$",
  kHNL: r"L",
  kHRK: r"kn",
  kHTG: r"G",
  kHUF: r"Ft",
  kIDR: r"Rp",
  kILS: r"₪",
  kIMP: r"£",
  kINR: r"₹",
  kIQD: r"ع.د",
  kIRR: r"﷼",
  kISK: r"kr",
  kJEP: r"£",
  kJMD: r"$",
  kJOD: r"د.أ",
  kJPY: r"¥",
  kKES: r"KSh",
  kKGS: r"с",
  kKHR: r"៛",
  kKMF: r"CF",
  kKPW: r"₩",
  kKRW: r"₩",
  kKWD: r"د.ك",
  kKYD: r"$",
  kKZT: r"₸",
  kLAK: r"₭",
  kLBP: r"ل.ل",
  kLKR: r"Rs",
  kLRD: r"$",
  kLSL: r"L",
  kLTL: r"Lt",
  kLVL: r"Ls",
  kLYD: r"ل.د",
  kMAD: r"د.م.",
  kMDL: r"L",
  kMGA: r"Ar",
  kMKD: r"ден",
  kMMK: r"K",
  kMNT: r"₮",
  kMOP: r"MOP$",
  kMRU: r"UM",
  kMUR: r"₨",
  kMVR: r"Rf",
  kMWK: r"MK",
  kMXN: r"$",
  kMYR: r"RM",
  kMZN: r"MT",
  kNAD: r"$",
  kNGN: r"₦",
  kNIO: r"C$",
  kNOK: r"kr",
  kNPR: r"Rs",
  kNZD: r"$",
  kOMR: r"ر.ع.",
  kPAB: r"B/. ",
  kPEN: r"S/.",
  kPGK: r"K",
  kPHP: r"₱",
  kPKR: r"₨",
  kPLN: r"zł",
  kPYG: r"₲",
  kQAR: r"ر.ق",
  kRON: r"lei",
  kRSD: r"дин.",
  kRUB: r"₽",
  kRWF: r"FRw",
  kSAR: r"ر.س",
  kSBD: r"$",
  kSCR: r"₨",
  kSDG: r"ج.س.",
  kSEK: r"kr",
  kSGD: r"$",
  kSHP: r"£",
  kSLE: r"Le",
  kSLL: r"Le",
  kSOS: r"S",
  kSRD: r"$",
  kSTD: r"Db",
  kSVC: r"₡",
  kSYP: r"ل.س",
  kSZL: r"E",
  kTHB: r"฿",
  kTJS: r"ЅМ",
  kTMT: r"m",
  kTND: r"د.ت",
  kTOP: r"T$",
  kTRY: r"₺",
  kTTD: r"$",
  kTWD: r"NT$",
  kTZS: r"TSh",
  kUAH: r"₴",
  kUGX: r"UGX",
  kUYU: r"$",
  kUZS: r"лв",
  kVES: r"Bs.S",
  kVND: r"₫",
  kVUV: r"Vt",
  kWST: r"T",
  kXAF: r"FCFA",
  kXAG: r"XAG",
  kXAU: r"XAU",
  kXCD: r"$",
  kXDR: r"XDR",
  kXOF: r"CFA",
  kXPF: r"₣",
  kYER: r"﷼",
  kZAR: r"R",
  kZMK: r"ZK",
  kZMW: r"K",
  kZWL: r"Z$",
};
