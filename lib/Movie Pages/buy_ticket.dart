import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Authentication/purchase_service.dart';
import '../Buttons/outline_buttons.dart';
import '../FontStyle/text_style.dart';
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
  String? selectedShow; // Initialize with null
  int selectedTicketCount = 1; // Track the selected ticket count

  Future<void> updateQuantityAndShow(int quantity, String show) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final purchaseOrderService = PurchaseOrderService();

      if (selectedShow != show) {
        // Create a new purchase order collection if the show is changed
        await purchaseOrderService.createPurchaseOrderCollection(
          userId,
          widget.movieName!,
          quantity,
          show,
        );
        // Update the selected show
        selectedShow = show;
      } else {
        // Update the quantity if the show remains the same
        await purchaseOrderService.createPurchaseOrderCollection(
          userId,
          widget.movieName!,
          quantity,
          show,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Purchase Ticket'),
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
                color: Colors.grey[900],
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Outlinebuttons(
                      text: 'Morning Show',
                      price: 'Rs. 175',
                      onPressed: () {
                        // Update the ticket price and show type when the show is selected
                        updateQuantityAndShow(selectedTicketCount, 'Morning Show');
                      },
                    ),
                    Outlinebuttons(
                      text: 'Evening Show',
                      price: 'Rs. 200',
                      onPressed: () {
                        // Update the ticket price and show type when the show is selected
                        updateQuantityAndShow(selectedTicketCount, 'Evening Show');
                      },
                    ),
                    Outlinebuttons(
                      text: 'Night Show',
                      price: 'Rs. 150',
                      onPressed: () {
                        // Update the ticket price and show type when the show is selected
                        updateQuantityAndShow(selectedTicketCount, 'Night Show');
                      },
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
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      // Add logic to handle ticket purchase
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel Purchase'),
                  ),
                  ElevatedButton(
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
                                 Row(
                                    
                                    children: [
                                    selectedShow=='Morning Show'?
                                     KhaltiApp(
                                     price: 175.0,
                                     quantity: selectedTicketCount,
                    ):selectedShow=='Evening Show'?
                                     KhaltiApp(
                                     price: 200.0,
                                     quantity: selectedTicketCount,
                    ):
                                     KhaltiApp(
                                     price: 150.0,
                                     quantity: selectedTicketCount,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}