import 'package:kibbi_kiosk/src/models/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';

class CartItem extends StatelessWidget {
  final List<OrderProduct> products;  // Lista de productos con cantidad y precio
  final Function(OrderProduct) onDeleteProduct;
  final Function(OrderProduct) onDecreaseProduct;
  final Function(OrderProduct) onIncreaseProduct;
  final Function onOrderComplete;  // Función para limpiar el carrito después de la orden

  const CartItem({
    super.key,
    required this.products,
    required this.onDeleteProduct,
    required this.onDecreaseProduct,
    required this.onIncreaseProduct,
    required this.onOrderComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Carrito de compras',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Style.black,
                  letterSpacing: -0.4,
                ),
              ),
              Text(
                '${products.length} productos',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Style.black,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
        22.verticalSpace,
        Divider(
          height: 1.r,
          thickness: 1.r,
          color: Style.black.withOpacity(0.1),
        ),
        // Lista de productos
        for (var orderProduct in products)
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                // Nombre del producto
                Text(
                  orderProduct.product.name ?? 'Producto',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Style.black,
                  ),
                ),
                const Spacer(),
                // Botones de aumentar y disminuir cantidad
                GestureDetector(
                  onTap: () => onDecreaseProduct(orderProduct),
                  child: Icon(Icons.remove, color: Style.black),
                ),
                4.horizontalSpace,
                Text(
                  '${orderProduct.quantity}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Style.black,
                  ),
                ),
                4.horizontalSpace,
                GestureDetector(
                  onTap: () => onIncreaseProduct(orderProduct),
                  child: Icon(Icons.add, color: Style.black),
                ),
                8.horizontalSpace,
                // Eliminar producto
                GestureDetector(
                  onTap: () => onDeleteProduct(orderProduct),
                  child: Icon(Icons.delete, color: Style.red),
                ),
              ],
            ),
          ),
        // Botón para completar la orden y limpiar el carrito
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          child: ElevatedButton(
            onPressed: () {
              // Aquí se ejecuta la función de limpieza del carrito
              onOrderComplete.call();
            },
            child: Text(
              'Realizar Orden',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Style.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              iconColor: Style.primary,
              minimumSize: Size(double.infinity, 48.h),
            ),
          ),
        ),
      ],
    );
  }
}

// Ahora tu carrito tiene cantidad y precio unitario, y puedes mandar bien la orden al servidor 🚀🔥
