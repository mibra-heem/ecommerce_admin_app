import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/provider/banner_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {

  @override
  void initState() {
    super.initState();
    Provider.of<BannerProvider>(context, listen: false).getBannersHandler();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Card(
        color: Colours.primaryLight,
        // child: ,
      ),
    );
  }
}
