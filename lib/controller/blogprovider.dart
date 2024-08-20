import 'dart:collection';
import 'dart:io';
import 'package:blog_app/models/blogpost_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlogPost extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = storage.ref().child("posts/$fileName");
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addPost(BuildContext context) async {
    if (_selectedImage != null) {
      String imageUrl = await uploadImage(_selectedImage!);
      String Id = DateTime.now().millisecondsSinceEpoch.toString();
      HashMap<String, Object> map = HashMap();
      map["imgUrl"] = imageUrl;
      map["title"] = titleController.text;
      map["desc"] = descController.text;
      await db.collection("UserPost").doc(Id).set(map);
      clearPost();
      notifyListeners();
    }
  }

  void clearPost() {
    titleController.clear();
    descController.clear();
    _selectedImage = null;
    notifyListeners();
  }

  List<BlogPostModel> postList = [];
Future<void> getPost() async {
  try {
    print("Fetching posts from Firestore...");
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('UserPost').get();
    postList = snapshot.docs.map((doc) {
      print("Post title: ${doc['title']}");
      return BlogPostModel(
        title: doc['title'],
        imgUrl: doc['imgUrl'],
        desc: doc['desc'],
      );
    }).toList();
    notifyListeners();
    print("Posts fetched successfully.");
  } catch (e) {
    print("Error fetching posts: $e");
    throw Exception("Error fetching posts: $e");
  }
}}
