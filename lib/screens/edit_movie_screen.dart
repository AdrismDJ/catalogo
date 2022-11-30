import 'package:flutter/material.dart';

import '../providers/movie.dart';

class EditMovieScreen extends StatefulWidget {
  static const routeName = '/edit-movie';

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final _yearFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _directorFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _sinopsisFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedMovie = Movie(
    id: '',
    title: '',
    year: 0,
    price: 0,
    director: '',
    gender: '',
    sinopsis: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _yearFocusNode.dispose();
    _priceFocusNode.dispose();
    _directorFocusNode.dispose();
    _genderFocusNode.dispose();
    _sinopsisFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

/*
  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }
*/
  void _saveForm() {
    _form.currentState!.save();
    print(_editedMovie.title);
    print(_editedMovie.year);
    print(_editedMovie.price);
    print(_editedMovie.director);
    print(_editedMovie.gender);
    print(_editedMovie.sinopsis);
    print(_editedMovie.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Movie'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              // TITLE
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_yearFocusNode);
                },
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: value,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: _editedMovie.imageUrl,
                    id: '',
                  );
                },
              ),
              // YEAR
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _yearFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: _editedMovie.title,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: value,
                    id: '',
                  );
                },
              ),
              // PRICE
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_directorFocusNode);
                },
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: _editedMovie.title,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: value,
                    id: '',
                  );
                },
              ),
              // DIRECTOR
              TextFormField(
                decoration: InputDecoration(labelText: 'Director'),
                textInputAction: TextInputAction.next,
                focusNode: _directorFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_genderFocusNode);
                },
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: value,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: _editedMovie.imageUrl,
                    id: '',
                  );
                },
              ),
              // GENDER
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                textInputAction: TextInputAction.next,
                focusNode: _genderFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_sinopsisFocusNode);
                },
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: value,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: _editedMovie.imageUrl,
                    id: '',
                  );
                },
              ),
              // SINOPSIS
              TextFormField(
                decoration: InputDecoration(labelText: 'Sinopsis'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _sinopsisFocusNode,
                onSaved: (value) {
                  var value; //???
                  _editedMovie = Movie(
                    title: _editedMovie.title,
                    year: _editedMovie.year,
                    price: _editedMovie.price,
                    director: _editedMovie.director,
                    gender: _editedMovie.gender,
                    sinopsis: _editedMovie.sinopsis,
                    imageUrl: value,
                    id: '',
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  // IMAGE
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      /*
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      */
                      onSaved: (value) {
                        var value; //???
                        _editedMovie = Movie(
                          title: _editedMovie.title,
                          year: _editedMovie.year,
                          price: _editedMovie.price,
                          director: _editedMovie.director,
                          gender: _editedMovie.gender,
                          sinopsis: _editedMovie.sinopsis,
                          imageUrl: value,
                          id: '',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
