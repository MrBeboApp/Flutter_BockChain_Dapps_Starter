import 'package:flutter/material.dart';
import 'package:flutter_dapps_starter/helpers/NameFactory.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var factoryNameInstance = Provider.of<NameFactory>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Arabic Dapps"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: factoryNameInstance.isLoading ? CircularProgressIndicator(color: Colors.red,):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( "My Address is",style: TextStyle(fontSize: 20,color: Colors.redAccent),),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text( factoryNameInstance.mainAddrress,style: TextStyle(fontSize: 20),),
              ),
              Text( "My Brand Name  is",style: TextStyle(fontSize: 20,color: Colors.redAccent),),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text( factoryNameInstance.mainSiteName,style: TextStyle(fontSize: 20),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
