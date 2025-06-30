import 'package:flutter/material.dart';
import 'dropdown.widget.dart';
import 'package:notifi/i18n/strings.g.dart' as nt;

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final Function(String) onPageChanged;
  final TextEditingController pageController;

  const Pagination({super.key, 
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.previousPage,
    required this.nextPage,
    required this.onPageChanged,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 400) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: currentPage > 0 ? previousPage : null,
                    child: Text(nt.t.previous),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                      'Page ${currentPage + 1} of ${(totalItems / itemsPerPage).ceil()}'),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomDropdownPage(
                    title: 'Select Page',
                    isShowTitle: false,
                    isShowPlaceholder: false,
                    controller: pageController,
                    items: const ['2', '5', '10', '15', '20'],
                    onChanged: onPageChanged,
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: currentPage < (totalItems / itemsPerPage).ceil() - 1 ? nextPage : null,
                    child: Text(nt.t.next),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                      'Page ${currentPage + 1} of ${(totalItems / itemsPerPage).ceil()}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: currentPage > 0 ? previousPage : null,
                        child: const Text('<'),
                      ),
                    ),
                    Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomDropdownPage(
                        title: 'Select Page',
                        isShowTitle: false,
                        isShowPlaceholder: false,
                        controller: pageController,
                        items: const ['2', '5', '10', '15', '20'],
                        onChanged: onPageChanged,
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed:
                            currentPage < (totalItems / itemsPerPage).ceil() - 1 ? nextPage : null,
                        child: const Text('>'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
