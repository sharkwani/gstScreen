import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import 'file:///C:/Users/LENOVO/AndroidStudioProjects/gstscreen/lib/application/DataController.dart';

import 'SplashScreen.dart';

class GstProfileProvider extends StatefulWidget {
  final String profileId;

  const GstProfileProvider({this.profileId});
  @override
  _GstProfileProviderState createState() => _GstProfileProviderState();
}

class _GstProfileProviderState extends State<GstProfileProvider> {
  @override
  Widget build(BuildContext context) {
    final profileDataModel = FutureProvider(
        (_) => DataController.callHttpClient(widget.profileId.toUpperCase()));

    return Consumer(builder: (context, watch, child) {
      AsyncValue data = watch(profileDataModel);
      return data.when(
          data: (data) => data is bool
              ? Scaffold(
                  body: Center(
                      child: Text(
                          "No data retrieved using the id ${widget.profileId}")))
              : Scaffold(
                  body: SafeArea(
                  child: CustomScrollView(
                    physics: ClampingScrollPhysics(),
                    slivers: <Widget>[
                      _buildHeader(data.name, data.status),
                      _buildContainer(data.address),
                      _buildContainerTwo(data.taxPayerType),
                      _buildContainerThree("Constitution of Bussiness",
                          data.businessType, false),
                      _buildContainerThree("Date of Registration",
                          data.dateOfRegistration, true),
                      _buildButton()
                    ],
                  ),
                )),
          loading: () => Scaffold(body: SplashScreen()),
          error: (e, stackTrace) =>
              Center(child: Text("SomeThing went wrong")));
    });
  }

  SliverPadding _buildHeader(companyName, isActive) {
    return SliverPadding(
        padding: const EdgeInsets.all(0.0),
        sliver: SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  color: Colors.green,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        label: Text(
                          "GST Profile",
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "GSTIN of the Tax player",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        widget.profileId,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        companyName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: isActive
                            ? FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.white,
                                onPressed: () {},
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 12.0),
                                icon: const Icon(
                                  Icons.lens,
                                  color: Colors.green,
                                  size: 10,
                                ),
                                label: Text(
                                  "Active",
                                  style: TextStyle(color: Colors.green),
                                ))
                            : FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.white,
                                onPressed: () {},
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 12.0),
                                icon: const Icon(
                                  Icons.lens,
                                  color: Colors.red,
                                  size: 10,
                                ),
                                label: Text(
                                  "Not Active",
                                  style: TextStyle(color: Colors.red),
                                ))),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }

  SliverPadding _buildButton() {
    return SliverPadding(
      sliver: SliverToBoxAdapter(
          child: SizedBox(
              width: double.infinity,
              height: 60,
              child: FlatButton(
                color: Colors.green,
                onPressed: () {},
                child: Text(
                  "Get Return Filing Status",
                  style: TextStyle(color: Colors.white),
                ),
              ))),
      padding: EdgeInsets.all(15.0),
    );
  }

  SliverPadding _buildContainer(address) {
    return SliverPadding(
      sliver: SliverToBoxAdapter(child: UpperContainer(address)),
      padding: EdgeInsets.all(15.0),
    );
  }

  SliverPadding _buildContainerTwo(businessType) {
    return SliverPadding(
      sliver: SliverToBoxAdapter(child: LowerContainer(businessType)),
      padding: EdgeInsets.all(15.0),
    );
  }

  SliverPadding _buildContainerThree(header, footer, haveTrailing) {
    return SliverPadding(
      sliver: SliverToBoxAdapter(
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              header,
                              style: TextStyle(fontSize: 9),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(footer,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      haveTrailing
                          ? Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Date of Cancelation",
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("--",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          : Flexible(
                              flex: 0,
                              child: Container(),
                            )
                    ],
                  )))),
      padding: EdgeInsets.all(15.0),
    );
  }
}

class LowerContainer extends StatefulWidget {
  final String businessType;

  LowerContainer(this.businessType);

  @override
  _LowerContainerState createState() => _LowerContainerState();
}

class _LowerContainerState extends State<LowerContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildComponentTwo("State Junction", "Ward 75", 1),
                _buildComponentTwo("Center Jurisdiction", "Range-139", 1),
                _buildComponentTwo("Taxpayer Type", widget.businessType, 1)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UpperContainer extends StatefulWidget {
  final String address;

  const UpperContainer(this.address);
  @override
  _UpperContainerState createState() => _UpperContainerState();
}

class _UpperContainerState extends State<UpperContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
              child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              _buildComponentOne(
                  Icons.location_on,
                  MediaQuery.of(context).size.width * 0.8,
                  "Principal Place of Bussiness",
                  widget.address),
              SizedBox(height: 20),
              _buildComponentOne(
                  Icons.account_balance,
                  MediaQuery.of(context).size.width * 0.8,
                  "Additional Place of Bussiness",
                  "Floor"),
              SizedBox(height: 20),
            ],
          ))
        ],
      ),
    );
  }
}

Column _buildComponentOne(
    IconData icon, widthValue, String heading, String address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 5),
          Icon(
            icon,
            color: Colors.green,
          ),
          SizedBox(width: 10),
          Container(
            width: widthValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(heading,
                    style: TextStyle(fontSize: 9), textAlign: TextAlign.left),
                SizedBox(
                  height: 10,
                ),
                Text(address,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

Expanded _buildComponentTwo(header, footer, number) {
  return Expanded(
      flex: number,
      child: Card(
          child: Container(
        //margin: const EdgeInsets.all(8.0),
        //padding: const EdgeInsets.all(1),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              header,
              style: TextStyle(fontSize: 9),
            ),
            SizedBox(
              height: 20,
            ),
            Text(footer,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ],
        ),
      )));
}
