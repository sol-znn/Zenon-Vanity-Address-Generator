// Zenon Vanity Address Generator
// Currently limited to the end of the address
// Adjust criteria variable as needed

import 'package:hex/hex.dart';
import 'package:znn_sdk_dart/znn_sdk_dart.dart';

Future<void> main() async {
  //Example: this will try to find an address like z1qr3uww8uqh75qnsuxqajegvwaesqynfglr1337
  var criteria = '1337'; // <--- update this
  var verbose = true;

  var match = false;
  var count = 0;

  while (!match) {
    var keyStore = await KeyStore.newRandom();
    var mnemonic = keyStore.mnemonic;
    var keyPair = keyStore.getKeyPair(0);
    var privateKey = keyPair.getPrivateKey();
    var publicKey = await keyPair.getPublicKey();
    var address = await keyPair.address;
    var addressLength = address.toString().length;

    var str = address.toString();
    var target = str.substring(addressLength - criteria.length, addressLength);

    if (verbose) { print("${count}: ${str} || ${mnemonic}"); }

    if (target != criteria) {
      count++;
    }
    else {
      print('mnemonic: ${mnemonic}');
      print('entropy: ${keyStore.entropy}');
      print('private key: ${HEX.encode(privateKey!)}');
      print('public key: ${HEX.encode(publicKey)}');
      print('address: $address');
      print('core bytes: ${HEX.encode(address!.core!)}');
      print('total addresses calculated: ${count}');
      match = true;
    }
  }
}
