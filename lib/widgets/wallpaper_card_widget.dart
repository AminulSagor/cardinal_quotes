import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WallpaperCard extends StatelessWidget {
  final Map<String, dynamic> wallpaper;
  final void Function(String value) onActionSelected;
  final VoidCallback onTap;

  const WallpaperCard({
    super.key,
    required this.wallpaper,
    required this.onActionSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tags = (wallpaper['tags'] ?? []) as List;
    final viewCount = wallpaper['views'] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4.w,
                  children: tags.isNotEmpty
                      ? tags.take(2).map((tag) => Text(
                    '#$tag',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    overflow: TextOverflow.ellipsis,
                  )).toList()
                      : [
                    Text('#Wallpaper', style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(22.w, 0),
                child: PopupMenuButton<String>(
                  color: Colors.orange.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  icon: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                  onSelected: onActionSelected,
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'views',
                      child: Row(
                        children: [
                          const Icon(Icons.remove_red_eye, size: 18, color: Colors.brown),
                          SizedBox(width: 6.w),
                          Text('$viewCount', style: const TextStyle(color: Colors.brown)),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    _popupItem(Icons.bookmark_border, 'Save'),
                    _popupItem(Icons.share, 'Share'),
                    _popupItem(Icons.download, 'Download'),
                    _popupItem(Icons.lock, 'Set as Lock', 'set_lock'),
                    _popupItem(Icons.home, 'Set as Home', 'set_home'),
                    _popupItem(Icons.wallpaper, 'Set Both', 'set_both'),
                  ],
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              wallpaper['background'] ?? '',
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, loading) => loading == null ? child : const Center(child: CircularProgressIndicator()),
              errorBuilder: (_, __, ___) => Container(
                height: 180.h,
                color: Colors.black26,
                child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _popupItem(IconData icon, String text, [String? value]) {
    return PopupMenuItem<String>(
      value: value ?? text.toLowerCase(),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.brown),
          SizedBox(width: 6.w),
          Text(text, style: const TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
