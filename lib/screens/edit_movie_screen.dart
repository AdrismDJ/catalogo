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
  var _isLoading = false;

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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedMovie.id != null) {
      await Provider.of<Movies>(context, listen: false)
          .updateMovie(_editedMovie.id, _editedMovie);
    } else {
      try {
        await Provider.of<Movies>(context, listen: false)
            .addMovie(_editedMovie);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Película'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                          return 'Por favor proporcione un valor.';
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
                          return 'Por favor ingrese un precio.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Por favor ingrese un número valido.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Por favor ingrese un valor más grande que cero.';
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
                          return 'Por favor ingrese un precio.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Por favor ingrese un número valido.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Por favor ingrese un valor más grande que cero.';
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
                          return 'Por favor proporcione un valor.';
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
                          return 'Por favor proporcione un valor.';
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
                          return 'Por favor ingrese una descripción.';
                        }
                        if (value.length < 10) {
                          return 'Debe ser por lo menos de 10 caracteres de longitud.';
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
                              ? Text('Ingrese un URL')
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
                            decoration:
                                InputDecoration(labelText: 'URL de imagen'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor ingrese un URL de imagen.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Por favor ingrese un URL válido.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Por favor ingrese un URL válido.';
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
