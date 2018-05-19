import 'package:flutter/material.dart';


class SwiperPagination{
  /**
   *
   * if alignment is right or left ,then the direction is vertical.
   *
   */
  final AlignmentGeometry align;

  /**
   *
   */
  final double margin;

  /**
   *  indicator builder, if not set, use the default indicator style.
   */
  final WidgetBuilder builder;


  SwiperPagination({
    this.align: Alignment.bottomCenter,
    this.margin : 10.0,
    this.builder,

  }):assert(builder!=null);

}


class SwiperAutoplay{

  final int delay;

  final bool stopOnLastSlide;

  final bool disableOnInteraction;

  final bool reverseDirection;


  SwiperAutoplay({
    this.delay:3000,
    this.stopOnLastSlide:false,
    this.disableOnInteraction:true,
    this.reverseDirection:false
  });



}



typedef void SwiperOnTap(int index);


class SwiperController{

  /**
   *
   * TabController , this property will be set when the wiget is rendered.
   *
   */
  TabController _tabController;

  SwiperController();

  set tabController(TabController tabController){
    _tabController = tabController;
    tabController.animation.addStatusListener(_animationListener);
  }

  TabController get tabController=>_tabController;

  /**
   *
   * notice: if you call this function before the wiget is rendered,
   *          nothing whill happen
   */
  void animateTo(int value, { Duration duration: kTabScrollDuration, Curve curve: Curves.ease }) {
    _tabController?.animateTo(value,duration: duration,curve: curve);
  }

  /**
   * animateTo next
   */
  void next({ Duration duration: kTabScrollDuration, Curve curve: Curves.ease }){
    if(_tabController==null)return;
    int index = _tabController.index;
    ++index;
    if(index >= _tabController.length){
      index = 0;
    }
    _tabController.animateTo(index,duration: duration,curve: curve);
  }

  /**
   * animateTo previous
   */
  void previous({ Duration duration: kTabScrollDuration, Curve curve: Curves.ease }){
    if(_tabController==null)return;
    int index = _tabController.index;
    --index;
    if(index < 0){
      index = _tabController.length-1;
    }
    _tabController.animateTo(index,duration: duration,curve: curve);
  }

  /**
   *
   */
  int get activeIndex=>_tabController?.index;

  /**
   * set current activeIndex
   */
  set activeIndex(int index){
    this._tabController?.index = index;
  }


  void _animationListener(AnimationStatus status){
    print("${status}");
  }

  /**
   *
   */
  void dispose() {
    this._tabController?.animation?.removeStatusListener(_animationListener);
    this._tabController?.dispose();
  }



}

class Swiper extends StatefulWidget{

  /**
   * The data to render items
   */
  final List<dynamic> data;

  /**
   *
   * The children you want to display in swiper
   *
   */
  final List<Widget> children;

  /**
   * The interval (MS) of autopaying , default is 8 sec ( 8000MS),
   * if set to 0, autoplay is disabled.
   */
  final int autoplay;

  /**
   * Style of pagination indicator , if null, there is no pagination
   */
  final SwiperPagination pagination;

  /**
   * width of the widget, all the children share the same with
   */
  final double width;

  /**
   * height of the widget,all the children share the same height
   */
  final double height;

  /**
   *  Define here becourse it is easy to change
   *  initialIndex without set a SwiperController
   */
  final int initialIndex;


  /**
   * Called when tap
   */
  final SwiperOnTap onTap;

  /**
   * Controller of swiper
   */
  final SwiperController controller;


  Swiper({
    this.children,
    this.autoplay:8000,
    this.pagination,
    this.initialIndex:0,
    this.width,
    this.height,
    this.onTap,
    this.controller
  }):
        assert(children != null),
        assert(controller!=null);


  @override
  State<StatefulWidget> createState() {
    return new _SwiperState();
  }

}

class  _SwiperState extends State<Swiper> with SingleTickerProviderStateMixin {


  SwiperController swiperController;


  Widget buildPagination() {
    return null;
  }

  List<Widget> buildChildren(List<Widget> list) {
    if (null == this.widget.onTap) {
      return list;
    }
    List<Widget> result = [];
    int index = 0;
    for (Widget widget in list) {
      result.add(
        //注意这里需要用闭包
          ((index) =>
          new InkWell(
            onTap: () {
              this.widget.onTap(index);
            },
            child: widget,
          ))(index)
      );
      ++index;
    }

    return result;
  }


  @override
  void dispose() {
    this.swiperController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TabController controller = new TabController(
        initialIndex: widget.initialIndex,
        length: widget.children.length,
        vsync: this
    );

    SwiperController swiperController = widget.controller;
    if(swiperController==null){
      swiperController = new SwiperController();
      this.swiperController = swiperController;
    }else{
      swiperController.dispose();
    }

    swiperController.tabController = controller;

    return new SizedBox(
      child: new Stack(
        children: <Widget>[
          new TabBarView(
              children: buildChildren(widget.children),
              controller: controller
          ),
        ],
      ),
      height: widget.height,
      width: widget.width,
    );
  }
}
