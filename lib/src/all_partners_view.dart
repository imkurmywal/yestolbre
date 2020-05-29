import 'package:flutter/material.dart';
import 'package:yestolbre/src/Firebase/merchant_firebase.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/src/models/merchnat.dart';

class AllPartnersView extends StatefulWidget {
  @override
  _AllPartnersViewState createState() => _AllPartnersViewState();
}

class _AllPartnersViewState extends State<AllPartnersView> {
  List<Merchant> allMerchants = new List<Merchant>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    MerchantDB.shared.getMerchants(fetched: (List<Merchant> merchants) {
      setState(() {
        print("fetched..");
        isLoading = false;
        allMerchants = merchants;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 100;
    final double itemWidth = (size.width / 3) - 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("All Partners"),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : allMerchants.length == 0
              ? Center(
                  child: Text("No partner found"),
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    primary: false,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(allMerchants.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MerchantView(
                                        merchant: allMerchants[index],
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                            allMerchants[index].logoUrl,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
    );
  }
}
