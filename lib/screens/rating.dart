import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/cubit/home/homecubit.dart';
import 'package:project/models/drivermodel.dart';

class RatingView extends StatefulWidget {
  // const RatingView({Key? key}) : super(key: key);
  drivermodel model;
  RatingView({required this.model});
  @override
  State<RatingView> createState() => _RatingViewState(model: model);
}

class _RatingViewState extends State<RatingView> {
  drivermodel model;
  _RatingViewState({required this.model});
  var _ratingPageController = PageController();
  var _starPosition = 250.0;
  var _selectedChipIndex = -1;
  var _isMoreDetialActive = false;
  var _moreDetialFocusNode = FocusNode();
  var _rating = 0;
  var _textFormController = TextEditingController();
  List<String> selectIndex = [
    'Driver',
    'Quicker Pikup',
    'pikup Location',
    "Dropoff Location",
    "Routing",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //Thanks note
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.5),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          //Done button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.teal,
              child: MaterialButton(
                onPressed: _hideDialog,
                child: Text('Done'),
                textColor: Colors.white,
              ),
            ),
          ),
          //Skip button
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: _hideDialog,
              child: Text('Skip'),
            ),
          ),
          //Star rating
          AnimatedPositioned(
            left: 0,
            right: 0,
            top: _starPosition,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: index < _rating
                      ? Icon(Icons.star, size: 32)
                      : Icon(Icons.star_border, size: 32),
                  color: Colors.teal,
                  onPressed: () {
                    _ratingPageController.nextPage(
                        duration: Duration(
                          microseconds: 300,
                        ),
                        curve: Curves.ease);
                    setState(() {
                      _starPosition = 30.0;
                      _rating = index + 1;
                    });
                  },
                ),
              ),
            ),
            duration: Duration(microseconds: 300),
          ),
          //Back button
          if (_isMoreDetialActive)
            Positioned(
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isMoreDetialActive = false;
                  });
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Thanks for riding on Bus on Demand',
          style: TextStyle(
            fontSize: 24,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text("We\'d love to get your feedback"),
        Text(
          'How was your ride today?',
        ),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetialActive,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('What couid be better?'),
              //Cause Selection
              Wrap(
                spacing: 8.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                  5,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        _selectedChipIndex = index;
                      });
                    },
                    child: Chip(
                      backgroundColor: _selectedChipIndex == index
                          ? Colors.teal
                          : Colors.grey[300],
                      label: Text(
                        '${selectIndex[index]}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              //More button
              InkWell(
                onTap: () {
                  _moreDetialFocusNode.requestFocus();
                  setState(() {
                    _isMoreDetialActive = true;
                  });
                },
                child: Text(
                  'Want to tell us more?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tell us more'),
              // Chip(label: Text('Text ${_selectedChipIndex +1}'),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textFormController,
                  focusNode: _moreDetialFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    helperStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _hideDialog() {
    var x;
    if (Navigator.canPop(context)) Navigator.pop(context);
    print(_rating);
    if (_selectedChipIndex != -1) {
      print(selectIndex[_selectedChipIndex]);
      x = selectIndex[_selectedChipIndex];
    }
    print(_textFormController.text);
    homeCubit.get(context).rating(
        model: model,
        comment: _textFormController.text,
        improvements: x,
        ratingnumber: _rating);
  }
}
