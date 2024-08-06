import 'package:acote_assignment/domain/model/repo_model.dart';
import 'package:acote_assignment/domain/model/user_model.dart';
import 'package:acote_assignment/presentation/view_model/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailView extends ConsumerStatefulWidget {
  final UserModel userModel;
  const UserDetailView({required this.userModel, super.key});

  @override
  ConsumerState<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends ConsumerState<UserDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchRepos();
    });
  }

  Future<void> _fetchRepos() async {
    await ref
        .read(repoViewModelProvider.notifier)
        .fetchUserRepos(widget.userModel.userName);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(repoViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.userModel.userName}'s Repositories"),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(RepoFetchState state) {
    if (state is RepoFetchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is RepoFetchSuccess) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            userCard(),
            const SizedBox(height: 20),
            const Text(
              "repository",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Divider(),
            repoList(state.repos),
          ]),
        ),
      );
    } else if (state is RepoFetchError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(child: Text("Not Exist Data"));
    }
  }

  Widget userCard() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(widget.userModel.avatarUrl),
          radius: 60,
        ),
        const SizedBox(width: 10),
        Text(
          widget.userModel.userName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget repoList(List<RepoModel> repos) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: repos.length,
        itemBuilder: (context, index) {
          RepoModel repoModel = repos[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(repoModel.title),
                if (repoModel.subTitle == null)
                  const SizedBox()
                else
                  Text(repoModel.subTitle!,
                      maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 20,
                ),
                Text(
                  " ${repoModel.starCount}",
                  style: const TextStyle(height: 2),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.circle_outlined,
                  size: 16,
                ),
                Text(" ${repoModel.language}")
              ],
            ),
          );
        });
  }
}
