// To parse this JSON data, do
//
//     final coinList = coinListFromJson(jsonString);

import 'dart:convert';

Map<String, CoinList> coinListFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, CoinList>(k, CoinList.fromJson(v)));

String coinListToJson(Map<String, CoinList> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CoinList {
    num ?chainId;
    String? symbol;
    String? name;
    String? address;
    num? decimals;
    String? logoUri;
    // List<Provider> providers;
    bool? eip2612;
    bool? isFoT;
    // List<Tag> tags;

    CoinList({
        required this.chainId,
        required this.symbol,
        required this.name,
        required this.address,
        // required this.decimals,
        required this.logoUri,
        // required this.providers,
        required this.eip2612,
        required this.isFoT,
        // required this.tags,
    });

    factory CoinList.fromJson(Map<String, dynamic> json) => CoinList(
        chainId: json["chainId"],
        symbol: json["symbol"],
        name: json["name"],
        address: json["address"],
        // decimals: json["decimals"],
        logoUri: json["logoURI"],
        // providers: List<Provider>.from(json["providers"].map((x) => providerValues.map[x]!)),
        eip2612: json["eip2612"],
        isFoT: json["isFoT"],
        // tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x]!)),
    );

    Map<String, dynamic> toJson() => {
        "chainId": chainId,
        "symbol": symbol,
        "name": name,
        "address": address,
        // "decimals": decimals,
        "logoURI": logoUri,
        // "providers": List<dynamic>.from(providers.map((x) => providerValues.reverse[x])),
        "eip2612": eip2612,
        "isFoT": isFoT,
        // "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
    };
}

enum Provider {
    ARB_WHITELIST_ERA,
    BORGSWAP,
    CMC_DE_FI,
    COINMARKETCAP,
    COIN_GECKO,
    CURVE_TOKEN_LIST,
    DEFIPRIME,
    FURUCOMBO,
    GEMINI_TOKEN_LIST,
    KLEROS_TOKENS,
    PANCAKE_SWAP_DEFAULT_LIST,
    PANCAKE_SWAP_EXTENDED,
    PANCAKE_SWAP_TOP_100,
    THE_1_INCH,
    TRUST_WALLET_ASSETS,
    UNISWAP_LABS_DEFAULT,
    VENUS_DEFAULT_LIST,
    ZERION
}

final providerValues = EnumValues({
    "Arb Whitelist Era": Provider.ARB_WHITELIST_ERA,
    "BORGSWAP": Provider.BORGSWAP,
    "CMC DeFi": Provider.CMC_DE_FI,
    "Coinmarketcap": Provider.COINMARKETCAP,
    "CoinGecko": Provider.COIN_GECKO,
    "Curve Token List": Provider.CURVE_TOKEN_LIST,
    "Defiprime": Provider.DEFIPRIME,
    "Furucombo": Provider.FURUCOMBO,
    "Gemini Token List": Provider.GEMINI_TOKEN_LIST,
    "Kleros Tokens": Provider.KLEROS_TOKENS,
    "PancakeSwap Default List": Provider.PANCAKE_SWAP_DEFAULT_LIST,
    "PancakeSwap Extended": Provider.PANCAKE_SWAP_EXTENDED,
    "PancakeSwap Top 100": Provider.PANCAKE_SWAP_TOP_100,
    "1inch": Provider.THE_1_INCH,
    "Trust Wallet Assets": Provider.TRUST_WALLET_ASSETS,
    "Uniswap Labs Default": Provider.UNISWAP_LABS_DEFAULT,
    "Venus Default List": Provider.VENUS_DEFAULT_LIST,
    "Zerion": Provider.ZERION
});

enum Tag {
    NATIVE,
    PEG_BNB,
    PEG_ETH,
    PEG_EUR,
    PEG_USD,
    TOKENS
}

final tagValues = EnumValues({
    "native": Tag.NATIVE,
    "PEG:BNB": Tag.PEG_BNB,
    "PEG:ETH": Tag.PEG_ETH,
    "PEG:EUR": Tag.PEG_EUR,
    "PEG:USD": Tag.PEG_USD,
    "tokens": Tag.TOKENS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
