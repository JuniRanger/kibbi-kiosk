import 'package:kibbi_kiosk/src/presentation/components/custom_scaffold.dart';
import 'widgets/product_list/menu_page.dart';
import 'widgets/product_list/riverpod/shop_provider.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme/theme_warpper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './widgets/product_list/riverpod/shop_notifier.dart';
import './widgets/menu/menu.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shopProvider.notifier).fetchCategories(context: context);
      ref.read(shopProvider.notifier).fetchProducts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopNotifier = ref.read(shopProvider.notifier);
    return SafeArea(
      child: CustomScaffold(
        extendBody: true,
        backgroundColor: Style.mainBack,
        appBar: (colors) => customAppBar(shopNotifier),
        body: (c) => const MenuPage(),
      ),
    );
  }

  AppBar customAppBar(ShopNotifier shopNotifier) {
    return AppBar(
      backgroundColor: Style.white,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      title: Row(
        children: [
          SvgPicture.asset(Assets.svgLogo),
          12.horizontalSpace,
          Text(
            AppHelpers.getAppName() ?? "Kibbi Kiosk",
            style: GoogleFonts.inter(
                color: Style.black, fontWeight: FontWeight.bold),
          ),
          const VerticalDivider(),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                shopNotifier.setProductsQuery(context, value.trim());
              },
              cursorColor: Style.black,
              decoration: InputDecoration(
                hintText: 'Buscar Productos',
                hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Style.searchHint.withOpacity(0.3),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          // Aquí se agrega el botón del menú
          const VerticalDivider(),
          GestureDetector(
            onTap: () {
              // Aquí puedes agregar la lógica para mostrar el menú
              AppHelpers.showCustomDialog(
                context: context,
                title: 'Opciones',
                child: const Menu(), // Asegúrate de que Menu esté importado
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu, // Puedes cambiar este icono según lo que prefieras
                color: Style.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
