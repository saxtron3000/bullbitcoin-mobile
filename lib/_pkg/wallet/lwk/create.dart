import 'package:bb_mobile/_model/wallet.dart';
import 'package:bb_mobile/_pkg/error.dart';
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'package:path_provider/path_provider.dart';

class LWKCreate {
  Future<(lwk.Wallet?, Err?)> loadPublicLwkWallet(Wallet wallet) async {
    try {
      // throw 'cool';

      final network = wallet.network == BBNetwork.Mainnet
          ? lwk.Network.mainnet
          : lwk.Network.testnet;

      final appDocDir = await getApplicationDocumentsDirectory();
      final String dbDir = '${appDocDir.path}/db';
      final descriptor = lwk.Descriptor(
        ctDescriptor: wallet.externalPublicDescriptor,
      );

      print('----load wallet: ' + wallet.id);

      final w = await lwk.Wallet.create(
        network: network,
        dbPath: dbDir,
        descriptor: descriptor,
      );

      print('----loaded wallet: ' + wallet.id);

      return (w, null);
    } catch (e) {
      return (
        null,
        Err(
          e.toString(),
          title: 'Error occurred while creating wallet',
          solution: 'Please try again.',
        )
      );
    }
  }
}
