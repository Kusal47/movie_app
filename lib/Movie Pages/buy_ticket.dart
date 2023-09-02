import 'package:flutter/material.dart';

import '../FontStyle/text_style.dart';
import '../Payment Method/esewa.dart';
import '../Payment Method/khaltipay.dart';
import '../const/export.dart';

class BuyTicketPage extends StatefulWidget {
  final String? movieName;
  final String? movieImage;
  final String? movieReleaseDate;

  const BuyTicketPage(
      {super.key, this.movieName, this.movieImage, this.movieReleaseDate});
  @override
  _BuyTicketPageState createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  String selectedPaymentMethod = '';
  int selectedTicketCount = 1; // Track the selected ticket count

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Buy Ticket'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFont(
                text: 'Ticket Details',
                size: 20,
              ),
              Image.network(
                widget.movieImage!,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[900],
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFont(
                      text: widget.movieName!,
                      size: 16,
                    ),
                    const SizedBox(height: 10.0),
                    TextFont(
                      text:
                          '${AppStrings.release_on} ${widget.movieReleaseDate!}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const TextFont(
                text: 'Ticket Pricing',
                size: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[900],
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            // Add logic to handle ticket purchase
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFont(
                                text: 'Morning Show',
                              ),
                              TextFont(
                                text: 'Price: Rs. 175',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFont(
                                  text: 'Evening Show',
                                ),
                                TextFont(
                                  text: 'Price: Rs. 200',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFont(
                            text: 'Night Show',
                          ),
                          TextFont(
                            text: 'Price: Rs. 150',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const TextFont(
                text: 'Number of Tickets',
                size: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[900],
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonFormField<int>(
                  value: selectedTicketCount,
                  onChanged: (value) {
                    setState(() {
                      selectedTicketCount = value!;
                    });
                  },
                  items: List.generate(10, (index) {
                    final ticketCount = index + 1;
                    return DropdownMenuItem<int>(
                      value: ticketCount,
                      child: Text('$ticketCount'),
                    );
                  }),
                  decoration: const InputDecoration(
                    labelText: 'Select Number of Tickets',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add logic to handle ticket purchase
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: const TextFont(
                            text: 'Payment Method',
                            color: Colors.black,
                          ),
                          content: Container(
                            height: 80 * 1.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    EsewaApp(),
                                    KhaltiApp(
                                      price: 2,
                                      productId: 2,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20)),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Purchase Ticket'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
