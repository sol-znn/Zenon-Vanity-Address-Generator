// Zenon Vanity Address Generator
// Currently limited to the end of the address
// Adjust criteria variable as needed

import 'package:hex/hex.dart';
import 'package:znn_sdk_dart/znn_sdk_dart.dart';
import 'package:bip39/bip39.dart' as bip39;

Future<void> main() async {
  //Example: this will try to find an address like z1qr3uww8uqh75qnsuxqajegvwaesqynfglr1337
  var criteria = '1337'; // <--- update this
  var verbose = true;

  var add = 'z1qr3uww8uqh75qnsuxqajegvwaesqynfglrare2';
  var valid = false;
  var mnemonic = '';
  var match = false;
  var count = 0;

  while (!match) {
    while (!valid) {
      var mnemonic1 = bip39.generateMnemonic();
      var mnemonic2 = bip39.generateMnemonic();
      mnemonic = mnemonic1 + " " + mnemonic2; //please don't laugh at me
      valid = bip39.validateMnemonic(mnemonic);
    }

    var keyStore = KeyStore.fromMnemonic(mnemonic);
    var keyPair = keyStore.getKeyPair(0);
    var privateKey = keyPair.getPrivateKey();
    var publicKey = await keyPair.getPublicKey();
    var address = await keyPair.address;

    var str = address.toString();
    var target = str.substring(add.length - criteria.length, add.length);

    if (verbose) { print("${count}: ${str} || ${mnemonic}"); }

    if (target != criteria) {
      count++;
      valid = false;
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
