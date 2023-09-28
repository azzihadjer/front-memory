// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  Category(
      {super.key,
      this.categoryService,
      this.colorText,
      this.colorShadow,
      this.onTap});
  String? categoryService;
  Color? colorText, colorShadow;
  VoidCallback? onTap;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Row(
          children: [
            const SizedBox(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(),
                color: const Color(0xFFDEDFDA),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(10),
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xff7abd87),
                  ),
                ),
                child: Text(
                  widget.categoryService!,
                  //  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: widget.colorText,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: widget.colorShadow!,
                        blurRadius: 10.0,
                        offset: const Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
