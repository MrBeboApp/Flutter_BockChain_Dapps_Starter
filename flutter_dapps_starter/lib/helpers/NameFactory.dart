import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
class NameFactory extends ChangeNotifier {




  final String _netWorkUrl = "https://ropsten.infura.io/v3/24517b325a5c46d8b8e02d72ab4b9000";
  final String _netWorkSoketUrl = "wss://ropsten.infura.io/ws/v3/24517b325a5c46d8b8e02d72ab4b9000";

  final String walletPrivatKey ="af45491dfb1f137dc826a965ae873eb0eb80d2d50b7bc2d613735912f5ce84a3";
  String ropostenContractAddress = "0xd0e713117c2fa3674f4b9d288ceed41310c7084e";

   late Web3Client _client ;

  late Credentials _credentials;
  late EthereumAddress walletAddress ;
  late EthereumAddress  _contractAddress;
  late DeployedContract _contract;
  late ContractFunction _siteName;

  String mainAddrress = "" ;
  String mainSiteName = "" ;
  bool isLoading = true;

  NameFactory(){
    setUp();
  }
  String _abiCode = "";

  Future <void>setUp() async{
    _client = Web3Client(_netWorkUrl, Client(),socketConnector: (){
      return IOWebSocketChannel.connect(_netWorkSoketUrl).cast<String>();
    });

    await getWalletAddress();
    await geAbi();
    await getDeployedContract();

  }


 Future <void> getWalletAddress()async {

   _credentials = await _client.credentialsFromPrivateKey(walletPrivatKey);

   walletAddress = await _credentials.extractAddress();

   mainAddrress = walletAddress.toString();


   notifyListeners();
 }
 //Get The ABI

 Future<void>geAbi() async{
    String abiFile = await rootBundle.loadString("src/abis/abiName.json");
    var jsonAbi = jsonDecode(abiFile);
    _abiCode = jsonEncode(jsonAbi);
    print(_abiCode);
    _contractAddress =EthereumAddress.fromHex(ropostenContractAddress);

 }

 //Get Deploy Contract
Future<void>getDeployedContract() async{
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Name"), _contractAddress);
    _siteName = _contract.function("siteName");
    getName();

}
//Get Name Contract

getName() async{
    try{
      List <dynamic> currentname = await _client.call(contract: _contract, function: _siteName, params: []);
     mainSiteName = currentname[0];
     isLoading =false;
    }catch (err) {

      print(err);

    }
    notifyListeners();
}


}