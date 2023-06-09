import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/api.dart';
import 'package:flutter_mobile/src/pages/dashboardPage.dart';
import 'package:flutter_mobile/src/pages/mobilitasPage.dart';
import 'package:flutter_mobile/src/pages/peminjamanPage.dart';
import 'package:flutter_mobile/src/pages/profilPage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:qrscan/qrscan.dart' as Scanner;
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

import '../api/model/inventori.dart';

class Menu extends StatefulWidget {
  final int? index;

  const Menu({super.key, this.index});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> _buildScreens() {
    return [
      DashboardPage(),
      MobilitasPage(),
      Screen3(),
      peminjamanPage(),
      ProfilPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    Inventori inventori = Inventori();
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.flip_camera_android),
        title: ("Mobilitas"),
        activeColorPrimary: Colors.pink,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        title: ("Check"),
        activeColorPrimary: Color(0xff4d87b7),
        inactiveColorPrimary: Colors.grey,
        onPressed: (p0) async {
          String? qr = await Scanner.scan();
          ProgressDialog progressDialog = ProgressDialog(
            context,
            blur: 10,
            message: Text("Mohon Tunggu..."),
          );
          progressDialog.show();
          if (qr != null) {
            setState(() {
              try {
                API.cekInventori(qr).then((value) {
                  setState(() {
                    inventori = value;
                    if (inventori.success == true) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.scale,
                        headerAnimationLoop: true,
                        title:
                            'Nama Barang :\n ${inventori.nama_barang}\n\nGedung : \n${inventori.gedung}\n\nRuangan : \n${inventori.ruangan}',
                        btnOkOnPress: () {},
                        onDismissCallback: (type) {
                          progressDialog.dismiss();
                        },
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.blue,
                      ).show();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        headerAnimationLoop: true,
                        title: 'Mohon Maaf .. Barang tidak ditemukan',
                        btnOkOnPress: () {},
                        onDismissCallback: (type) {
                          progressDialog.dismiss();
                        },
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.blue,
                      ).show();
                    }
                  });
                });
              } catch (e) {
                API.gagal(context, progressDialog);
              }
            });
          }
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.inventory),
        title: ("Peminjaman"),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profil"),
        activeColorPrimary: Colors.orangeAccent,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(80.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: false,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
