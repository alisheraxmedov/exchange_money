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
  String toCurrency = 'EUR';

  void convertCurrency() async {
    try {
      final exchangeRates = await currencyConverter.getExchangeRates();
      Map<String, dynamic> rates = exchangeRates['conversion_rates'];

      if (amount > 0) {
        setState(() {
          convertedAmount = (amount / rates[fromCurrency]) * rates[toCurrency];
          print(convertedAmount);
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

  void forAnswer()async{
    change_controller.text = await convertedAmount.toString();
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
                      value: fromCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          fromCurrency = newValue!;
                        });
                      },
                      items: <String>['USD', 'EUR', 'GBP', 'RUB', 'CAD', 'UZS']
                          .map<DropdownMenuItem<String>>((String value) {
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
                child: TextField(
                  keyboardType: TextInputType.none,
                  controller: change_controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow,
                    border: const OutlineInputBorder(),
                    suffixIcon: DropdownButton<String>(
                      value: toCurrency,
                      onChanged: (String? newValue) {
                        setState(() {
                          toCurrency = newValue!;
                        });
                      },
                      items: <String>['USD', 'EUR', 'GBP', 'RUB', 'CAD', 'UZS']
                          .map<DropdownMenuItem<String>>((String value) {
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
                          forAnswer();
                        },
                        child: const Text(
                          "Exchange",
                          style: TextStyle(
                            color: Colors.white,
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
              const SizedBox(height: 20),
              Text('Converted Amount: $convertedAmount $toCurrency'),
            ],
          ),
        ],
      ),
    );
  }
}
