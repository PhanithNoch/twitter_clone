import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/controllers/news_feed_controller.dart';

import 'post_screen.dart';

class NewsFeedScreen extends StatelessWidget {
  NewsFeedScreen({super.key});
  final _controller = Get.put(NewsFeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("News Feed"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text("A"),
                ),
                SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "What's happening?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      _controller.pickImage();
                    },
                    icon: Icon(Icons.photo)),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 0.5,
          ),
          Expanded(child: GetBuilder<NewsFeedController>(
            builder: (_) {
              return RefreshIndicator(
                onRefresh: () async {
                  _controller.getAllPost();
                },
                child: ListView.builder(
                  itemCount: _controller.posts.data != null
                      ? _controller.posts.data!.length
                      : 0,
                  itemBuilder: (context, index) {
                    final post = _controller.posts.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                post.user!.profileUrl != null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          "http://192.168.0.156:8000/posts/${post.user!.profileUrl}",
                                        ),
                                      )
                                    : const CircleAvatar(
                                        child: Text("A"),
                                      ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.user!.name.toString()),
                                    const Row(
                                      children: [
                                        Text(
                                          "1 hr ago",
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.blueGrey),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.public,
                                          size: 10,
                                          color: Colors.blueGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "${post.caption}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          post.imageUrl == null
                              ? SizedBox()
                              : Image.network(
                                  "http://192.168.0.156:8000/posts/${post.imageUrl}"),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "😘",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      "😍",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(
                                      "😂",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text("${post.likesCount} Likes"),
                                  ],
                                ),
                                Spacer(),
                                Text("${post.commentsCount} Comments"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _controller.likeDisLike(post.id!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.thumb_up,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Like"),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    foregroundColor:
                                        post.liked! ? Colors.blue : Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Comment"),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    foregroundColor: Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Share"),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    foregroundColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
