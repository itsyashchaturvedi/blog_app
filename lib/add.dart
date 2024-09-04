import 'package:blog_app/controller/blogprovider.dart';
import 'package:blog_app/homepage.dart';
import 'package:blog_app/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// Import the BlogPost provider

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  dynamic settingImage;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final blogPostProvider = Provider.of<BlogPost>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(35),
                  onTap: () {
                    _getImage(blogPostProvider);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 25,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: isDone
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.file(
                              settingImage,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_box_outlined,
                                  color: Colors.grey, size: 40),
                              Text(
                                "Add Picture",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 27),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 15),
                child: TextFormField(
                  controller: title,
                  style: const TextStyle(color: Colors.white),
                  minLines: 2,
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Title",
                    icon: const Icon(
                      Icons.title_rounded,
                      color: Colors.white,
                    ),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: TextFormField(
                  controller: desc,
                  style: const TextStyle(color: Colors.white),
                  minLines: 8,
                  maxLines: 14,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Description",
                    icon: const Icon(
                      Icons.description_outlined,
                      color: Colors.white,
                    ),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  if(title.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title must not be Empty"),backgroundColor: Colors.redAccent.shade200));
                  }
                  else if(desc.text.length<10){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Description must be of 10 characters at least"),backgroundColor: Colors.redAccent.shade200,));
                  }
                  else{
                    await _postBlog(blogPostProvider);
                  }

                },
                child: const Text(
                  "    Post    ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getImage(BlogPost blogPostProvider) async {
    Get.bottomSheet(
      Container(
        width: MediaQuery.of(context).size.width - 8,
        height: 280,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Add Picture",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await blogPostProvider.pickImageFromCamera();
                          if (blogPostProvider.selectedImage != null) {
                            setState(() {
                              isDone = true;
                              settingImage = blogPostProvider.selectedImage;
                              Navigator.pop(context);
                            });
                          }
                        },
                        icon: const Icon(Icons.camera, size: 80),
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await blogPostProvider.pickImageFromGallery();
                          if (blogPostProvider.selectedImage != null) {
                            setState(() {
                              isDone = true;
                              settingImage = blogPostProvider.selectedImage;
                              Navigator.pop(context);
                            });
                          }
                        },
                        icon: const Icon(Icons.image, size: 80),
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _postBlog(BlogPost blogPostProvider) async {
    blogPostProvider.titleController.text = title.text;
    blogPostProvider.descController.text = desc.text;

    await blogPostProvider.addPost(context);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post added successfully!")),
        
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navigation()));
    }
  }
}
