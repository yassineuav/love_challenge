import 'package:app/common/common.dart';
import 'package:app/features/auth/auth_controller.dart';
import 'package:app/theme/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetScreen());

  const CreateTweetScreen({super.key});

  @override
  ConsumerState<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: 'Tweet',
            backgroundColor: Pallet.blueColor,
            textColor: Pallet.whiteColor,
          ),
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(currentUser.profilePic),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: tweetTextController,
                            style: const TextStyle(fontSize: 22),
                            decoration: const InputDecoration(
                                hintText: "What's happening?",
                                hintStyle: TextStyle(
                                  color: Pallet.greyColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
