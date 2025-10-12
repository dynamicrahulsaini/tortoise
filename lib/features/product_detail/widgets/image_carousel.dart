import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/theme/app_colors.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return Container(
        height: 300,
        color: AppColors.grey100,
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            size: 64,
            color: AppColors.grey400,
          ),
        ),
      );
    }

    return Column(
      spacing: 8,
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return SizedBox(
              width: double.infinity,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  height: 250,
                  widget.imageUrls[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.grey200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey400,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            initialPage: widget.initialIndex,
            enableInfiniteScroll: widget.imageUrls.length > 1,
            autoPlay: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.imageUrls.length,
              effect: const WormEffect(
                dotHeight: 5,
                dotWidth: 5,
                spacing: 4,
                dotColor: AppColors.black4,
                activeDotColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
