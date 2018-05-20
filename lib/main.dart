import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RandomSentences(),
    );
  }
}

//============================
//====== New Section =========
//============================

class RandomSentences extends StatefulWidget {
  @override
  createState() => new _RandomSentencesState();
}

class _RandomSentencesState extends State<RandomSentences>{
final _sentences = <String>[];
List<int> _favorites = [];
List<int> _disliked = [];
final _biggerFont = const TextStyle(fontSize: 14.0);

_favoriteSentence(){
  print("Favorite Sentence Function Firing");
  print(context);
}

_unfavoriteSentence(){
  print("Unfavorite Funtion is Firing");
}

_colorAdjust(){

}

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Word Game"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.star),
            onPressed: () => print("Going to the Favorites Page"),
          ),
        ],
      ),
      body: _buildSentence(),
    );
  }

  String _getSentence() {
    final noun = new WordNoun.random();
    final adjective = new WordAdjective.random();
    return  "The programmer wrote a ${adjective} flutter app and showed it off to his ${noun}";
  }

  Widget _buildRow(String sentence, int index) {
    return new ListTile(
      title: new Text(
        sentence,
        style: _biggerFont
        ),
        trailing: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.thumb_up,
                color: _favorites.contains(index) ? Colors.green : Colors.grey,
                ),
              onPressed: () {
                int uiIndex = index;
                int arrayIndex = _favorites.indexOf(uiIndex);
                this.setState(() {
                  if(arrayIndex == -1){
                  _favorites.add(uiIndex);
                } else if(arrayIndex != -1){
                  _favorites.remove(uiIndex);
                }
                // Check if the line isn't both liked and disliked at the same time.
                if(_disliked.contains(uiIndex) && _favorites.contains(uiIndex)){
                  _disliked.remove(uiIndex);
                }
                });
               print(arrayIndex);
              },
            ),
            new IconButton(
              icon: new Icon(
                Icons.thumb_down,
                color: _disliked.contains(index) ? Colors.red : Colors.grey,
                ),
              onPressed: () {
                int uiIndex = index;
                int arrayIndex = _disliked.indexOf(uiIndex);
                this.setState((){
                  if(arrayIndex == -1){
                    _disliked.add(index);
                  } else if(arrayIndex != -1){
                    _disliked.remove(uiIndex);
                  }
                   // Check if the line isn't both liked and disliked at the same time.
                if(_disliked.contains(uiIndex) && _favorites.contains(uiIndex)){
                  _favorites.remove(uiIndex);
                }
                });
              },
            ),
          ],
        )
    );
  }

  Widget _buildSentence(){
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      itemBuilder: (context, i) {
        if(i.isOdd) return new Divider();
        final index = i ~/ 2;
        if (index >= _sentences.length){
          for(int x = 0; x < 10; x++){
            _sentences.add(_getSentence());
          }
        }
        return _buildRow(_sentences[index], index);
      },
    );
  }
}