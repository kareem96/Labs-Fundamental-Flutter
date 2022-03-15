

import 'package:flutter/material.dart';

class FreePackageCard extends StatelessWidget {
  const FreePackageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Berlangganan 15 Hari',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          const Padding(
            padding:  EdgeInsets.all(8),
            child: Text(
              'Gratis',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: OutlineButton(
              onPressed: (){},
              child: const Text(
                'Coba sekarang',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
