import 'package:ecommerce_admin_app/core/app/utils/core_utils.dart';
import 'package:ecommerce_admin_app/core/app/views/blurred_loading_view.dart';
import 'package:ecommerce_admin_app/core/services/dependency_injection.dart';
import 'package:ecommerce_admin_app/src/banner/domain/entities/banner.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/bloc/banner_bloc.dart';
import 'package:ecommerce_admin_app/src/banner/presentation/views/form/banner_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BannerFormView extends StatefulWidget {
  const BannerFormView({super.key, this.banenr});

  final BannerEntity? banenr;

  @override
  State<BannerFormView> createState() => _BannerFormViewState();
}

class _BannerFormViewState extends State<BannerFormView> {
  late final bool isCreate;

  @override
  void initState() {
    super.initState();

    isCreate = widget.banenr == null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BannerBloc>(),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BannerForm(isCreate: isCreate, banner: widget.banenr),
              ),
            ),
          ),
          BlocConsumer<BannerBloc, BannerState>(
            listener: (context, state) {
              if (state is BannerStored) {
                CoreUtils.showSnackbar(
                  context,
                  message : 'Banner created successfully.',
                );
                context.pop();
              }else if (state is BannerUpdated) {
                CoreUtils.showSnackbar(
                  context,
                  message : 'Banner updated successfully.',
                  color: Colors.amber,
                );
                context.pop();
              }
               else if (state is BannerError) {
                CoreUtils.showSnackbar(context, message : state.message);
              }
            },
            builder: (context, state) {
              if (state is StoringBanner) {
                return const BlurredLoadingView(
                  label: 'Creating Banner',
                );
              }else if (state is UpdatingBanner) {
                return const BlurredLoadingView(
                  label: 'Updating Banner',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
