import 'package:ecommerce_admin_app/core/app/resources/colours.dart';
import 'package:ecommerce_admin_app/core/app/views/loading_view.dart';
import 'package:ecommerce_admin_app/core/app/widgets/app_dialog_box.dart';
import 'package:ecommerce_admin_app/core/constants/route_const.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/bloc/banner_bloc.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/views/widgets/banner_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(const GetBannersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          spacing: 10,
          children: [Icon(IconlyBold.image), Text('Banners')],
        ),
        actionsPadding: const EdgeInsets.only(right: 6),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RouteName.bannerCreate);
            },
            icon: const Row(
              spacing: 5,
              children: [
                Text(
                  'Add',
                  style: TextStyle(
                    color: Colours.grey100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(FontAwesomeIcons.plus),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<BannerBloc>().add(const GetBannersEvent());
          },
          child: BlocConsumer<BannerBloc, BannerState>(
            listener: (context, state) {
              debugPrint('${state.runtimeType}');
            },
            builder: (context, state) {
              if (state is LoadingBanners) {
                return const LoadingView();
              } else if (state is BannerLoaded) {
                if (state.banners.isEmpty) {
                  return const Center(child: Text('No, Banners are found.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.banners.length,
                  itemBuilder: (_, index) {
                    debugPrint('Building the Banner Card $index');
                    final banner = state.banners[index];
                    return BannerCard(
                      banner: banner,
                      onEdit: () {
                        context.pushNamed(
                          RouteName.bannerEdit,
                          pathParameters: {'id': '${banner.id}'},
                          extra: banner,
                        );
                      },
                      onDelete: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) {
                            return AppDialogBox.alert(
                              title: 'Remove',
                              content:
                                  'Are you sure you want to '
                                  'delete this banner?',
                              onConfirm: () {
                                context.read<BannerBloc>()
                                  ..add(DeleteBannerEvent(banner.id!))
                                  ..add(const GetBannersEvent());
                                context.pop();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
