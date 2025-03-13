import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:users/models/user_model.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key, required this.user});

  final User user;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.firstName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.user.image.isNotEmpty
                  ? Image.network(
                      widget.user.image,
                      fit: BoxFit.contain,
                      height: ImageSizes.imageHeight,
                      width: MediaQuery.sizeOf(context).width,
                      loadingBuilder: (
                        BuildContext context,
                        Widget image,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) return image;
                        return SizedBox(
                          height: ImageSizes.imageHeight,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(
                        Icons.person_pin_rounded,
                        size: 128.0,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.user.firstName} ${widget.user.lastName}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      widget.user.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      widget.user.university,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
