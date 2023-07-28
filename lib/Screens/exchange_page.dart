import 'package:flutter/material.dart';
import 'package:money_exchange/Services/api.dart';

final TextEditingController change_controller = TextEditingController();
double convertedAmount = 0.0;

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final CurrencyConverter currencyConverter = CurrencyConverter();
  double amount = 0.0;
  String fromCurrency = 'USD';
  String toCurrency = 'UZS';

  void convertCurrency() async {
    try {
      final exchangeRates = await currencyConverter.getExchangeRates();
      Map<String, dynamic> rates = exchangeRates['conversion_rates'];

      if (amount > 0) {
        setState(() {
          convertedAmount = (amount / rates[fromCurrency]) * rates[toCurrency];
        });
      } else {
        setState(() {
          convertedAmount = 0.0;
        });
      }
    } catch (e) {
      setState(() {
        convertedAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.yellow.shade900,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.red,
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "lib/images/exchange.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      amount = double.parse(value);
                    });
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow,
                    border: const OutlineInputBorder(),
                    suffixIcon: DropdownButton<String>(
                      elevation: 0,
                      value: fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          fromCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'RUB',
                        'CAD',
                        'UZS',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "  $convertedAmount",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton<String>(
                        elevation: 0,
                        value: toCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            toCurrency = newValue!;
                            convertedAmount = 0.0;
                          });
                        },
                        items: <String>[
                          'USD',
                          'EUR',
                          'GBP',
                          'RUB',
                          'CAD',
                          'UZS'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Divider(
                      thickness: 2.0,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          convertCurrency();
                        },
                        child: Text(
                          "Exchange",
                          style: TextStyle(
                            color: Colors.yellow.shade900,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Divider(
                      thickness: 2.0,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
