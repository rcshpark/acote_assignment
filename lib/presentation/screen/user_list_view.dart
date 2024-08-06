import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:acote_assignment/presentation/view_model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListView extends ConsumerStatefulWidget {
  const UserListView({super.key});

  @override
  ConsumerState<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<UserListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialUsers();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(userViewModel.notifier).fetchUsers();
      }
    });
  }

  Future<void> _fetchInitialUsers() async {
    await ref.read(userViewModel.notifier).fetchUsers(isInitialLoad: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userViewModel);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub User List'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(RemoteFetchUserState state) {
    if (state is RemoteFetchUserLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is RemoteFetchUserError) {
      return Center(child: Text(state.message));
    } else if (state is RemoteFetchUserSuccess) {
      return _buildUserList(state.userInfo);
    } else {
      return const Center(child: Text('NOT EXITST DATA'));
    }
  }

  Widget _buildUserList(List<UserModel> users) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: users.length + 1,
      itemBuilder: (context, index) {
        if (index == users.length) {
          return const Center(child: CircularProgressIndicator());
        } else if ((index + 1) % 10 == 0) {
          return GestureDetector(
            onTap: () async {
              final url = Uri.parse('https://taxrefundgo.kr');
              await launchUrl(url);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Image.network('https://placehold.it/500x100?text=ad'),
            ),
          );
        }
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(users[index].avatarUrl),
          ),
          title: Text(users[index].userName),
        );
      },
    );
  }
}
