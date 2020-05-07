import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../res/res.dart';
import '../widgets/widgets.dart';

class FullScreenImage extends StatefulWidget{
  FullScreenImage({
    this.photo='',
    this.altDescription='',
    this.userName='',
    this.name='',
    this.userPhoto='',
    Key key,
  }) : super (key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;

  @override 
  State<StatefulWidget> createState(){
    return FullScreenImageState();   
  }
}

class FullScreenImageState extends State<FullScreenImage>{
  @override 
  Widget build(BuildContext context ){
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Photo(photoLink: widget.photo),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h3,
              )   ,  
            ),
            const SizedBox(height:9),
            _buidPhotoMeta(),
            const SizedBox( height:17),
            _buildActionButton(),
          ],

        ),
      ),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau
        ),
        onPressed:()=> Navigator.pop(context),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title:  Text(
        'Photo',
        style: AppStyles.h2Black,
        ),
    );
  }

  Widget _buidPhotoMeta(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5 ),
      child: Row(
        children:[
          UserAvatar(widget.userPhoto),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: AppStyles.h1Black,
              ),
              Text('@${widget.userName}',style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
            ],
          ),
        ]
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:10),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: LikeButton(), 
          ),
          Expanded(
            child: _buildButton('Save'),
          ),  
            const SizedBox(width:12),
          Expanded(
            child: _buildButton ('Visit'),
          ), 
        ],
      ),
    );
  }

  Widget _buildButton(String text){
    return Container(
      alignment: Alignment.center,
      height: 36,
      decoration: BoxDecoration(
        color:AppColors.dodgerBlue,
        borderRadius: BorderRadius.circular(7),
      ),
      child:  Text(
        text,
        style: AppStyles.h4.copyWith(color: AppColors.white),
      ),
    );
  }

}
