import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie.dart';
import '../providers/movies.dart';

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
    id: null,
    title: '',
    year: 0,
    price: 0,
    director: '',
    gender: '',
    sinopsis: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'year': '',
    'price': '',
    'director': '',
    'gender': '',
    'sinopsis': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final movieId = ModalRoute.of(context).settings.arguments as String;
      if (movieId != null) {
        _editedMovie =
            Provider.of<Movies>(context, listen: false).findById(movieId);
        _initValues = {
          'title': _editedMovie.title,
          'year': _editedMovie.year.toString(),
          'price': _editedMovie.price.toString(),
          'director': _editedMovie.director,
          'gender': _editedMovie.gender,
          'sinopsis': _editedMovie.sinopsis,
          // 'imageUrl': _editedMovie.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedMovie.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedMovie.id != null) {
      Provider.of<Movies>(context, listen: false)
          .updateMovie(_editedMovie.id, _editedMovie);
    } else {
      Provider.of<Movies>(context, listen: false).addMovie(_editedMovie);
    }
    Navigator.of(context).pop();
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
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_yearFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                      title: value,
                      year: _editedMovie.year,
                      price: _editedMovie.price,
                      director: _editedMovie.director,
                      gender: _editedMovie.gender,
                      sinopsis: _editedMovie.sinopsis,
                      imageUrl: _editedMovie.imageUrl,
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite);
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
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
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_directorFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                      title: _editedMovie.title,
                      year: _editedMovie.year,
                      price: _editedMovie.price,
                      director: _editedMovie.director,
                      gender: _editedMovie.gender,
                      sinopsis: _editedMovie.sinopsis,
                      imageUrl: value,
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite);
                },
              ),
              // DIRECTOR
              TextFormField(
                initialValue: _initValues['director'],
                decoration: InputDecoration(labelText: 'Director'),
                textInputAction: TextInputAction.next,
                focusNode: _directorFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_genderFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                      title: value,
                      year: _editedMovie.year,
                      price: _editedMovie.price,
                      director: _editedMovie.director,
                      gender: _editedMovie.gender,
                      sinopsis: _editedMovie.sinopsis,
                      imageUrl: _editedMovie.imageUrl,
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite);
                },
              ),
              // GENDER
              TextFormField(
                initialValue: _initValues['gender'],
                decoration: InputDecoration(labelText: 'Gender'),
                textInputAction: TextInputAction.next,
                focusNode: _genderFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_sinopsisFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                      title: value,
                      year: _editedMovie.year,
                      price: _editedMovie.price,
                      director: _editedMovie.director,
                      gender: _editedMovie.gender,
                      sinopsis: _editedMovie.sinopsis,
                      imageUrl: _editedMovie.imageUrl,
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite);
                },
              ),
              // SINOPSIS
              TextFormField(
                initialValue: _initValues['sinopsis'],
                decoration: InputDecoration(labelText: 'Sinopsis'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _sinopsisFocusNode,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMovie = Movie(
                      title: _editedMovie.title,
                      year: _editedMovie.year,
                      price: _editedMovie.price,
                      director: _editedMovie.director,
                      gender: _editedMovie.gender,
                      sinopsis: _editedMovie.sinopsis,
                      imageUrl: value,
                      id: _editedMovie.id,
                      isFavorite: _editedMovie.isFavorite);
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
                      onSaved: (value) {
                        _editedMovie = Movie(
                            title: _editedMovie.title,
                            year: _editedMovie.year,
                            price: _editedMovie.price,
                            director: _editedMovie.director,
                            gender: _editedMovie.gender,
                            sinopsis: _editedMovie.sinopsis,
                            imageUrl: value,
                            id: _editedMovie.id,
                            isFavorite: _editedMovie.isFavorite);
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
