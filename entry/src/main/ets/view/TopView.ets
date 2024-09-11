

import { hilog } from '@kit.PerformanceAnalysisKit';
import { TabContentConstants } from '../common/TabContentConstants';
import {TabItem } from '../viewmodel/TabItem'
import { Utils } from '../common/Utils';
import {initHomeTabData} from '../viewmodel/TabViewModel'
import {Constants} from '../common/Constants'
import {ShortVideo} from 'shortvideo'
import { VideoTabContent } from './VideoTabContent';

@Component
export struct TopView {
  private utils = new Utils();

  @State tabArray: Array<TabItem> = initHomeTabData();
  @State focusIndex: number = 0;
  @State pre: number = 0;
  @State index: number = 0;
  @State test: boolean = false;
  @State indicatorLeftMargin: number = 40;
  @State indicatorWidth: number = 0;
  private controller: TabsController = new TabsController();
  private listScroller: Scroller = new Scroller();
  private tabsWidth: number = 0;
  private tabWidth: number = 0;
  private init0: number = 0;
  private iteration: number = 1;
  private swipeRatio: number = 0.5;
  @State show: boolean = false;


  // aboutToAppear(): void {
  //   this.focusIndex = this.tabArray.length - 1
  //
  // }
  // onDidBuild(): void {
  //   this.focusIndex = this.tabArray.length - 1
  //
  //   this.listScroller.scrollToIndex(this.focusIndex,true)
  //
  // }
  onPageShow(): void {
  }


  @Builder
  Tab(tabName: string, tabIndex: number) {
    Row() {
      Text(tabName)
        .fontSize($r('app.float.size_text'))
        .fontColor(tabIndex === this.focusIndex ? Color.White : Color.Gray)
        .id(tabIndex.toString())
        .onAreaChange((oldValue: Area, newValue: Area) => {
          hilog.info(0x0000, 'index', oldValue.toString());
          if (this.focusIndex === tabIndex &&
            (this.indicatorLeftMargin === this.init0 || this.indicatorWidth === this.init0)) {
            if (newValue.position.x != undefined) {
              let positionX = Number.parseFloat(newValue.position.x.toString());
              this.indicatorLeftMargin = Number.isNaN(positionX) ? this.init0 : positionX;
            }
            let width = Number.parseFloat(newValue.width.toString());
            this.tabWidth = Number.isNaN(width) ? this.init0 : width;
            this.indicatorWidth = this.tabWidth;
          }
        })
    }
    .justifyContent(FlexAlign.Center)
    .width(Constants.SUB_SLIDE_TAB_WIDTH)
    .height(Constants.SUB_TAB_HEIGHT)
    .onClick(() => {
      this.controller.changeIndex(tabIndex);
      this.focusIndex = tabIndex;
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          Row() {
            Image($r("app.media.sidebar"))
              .width($r('app.integer.tab_search_icon_width'))
              .height($r('app.integer.tab_search_icon_height'))
              .id(TabContentConstants.TAB_SEARCH_IMAGE)
              .alignRules({
                top: { anchor: TabContentConstants.TAB_CONTAINER, align: VerticalAlign.Top },
                left: { anchor: TabContentConstants.TAB_CONTAINER, align: HorizontalAlign.Start }
              })
              .margin({
                // top: $r('app.integer.tab_search_image_margin'),
                left: $r('app.integer.tab_search_image_margin')
              })
              .onClick(() => {
                // this.utils.showPromptAction();
                this.show = false

              })
            List({ initialIndex: this.init0, scroller: this.listScroller }) {
              ForEach(this.tabArray, (item: TabItem, index: number) => {
                this.Tab(item.name, index)
              }, (item: TabItem, index: number) => JSON.stringify(item) + index)
            }
            // .backgroundColor(Color.Yellow)
            .listDirection(Axis.Horizontal)
            .height(Constants.SUB_TAB_HEIGHT)
            .scrollBar(BarState.Off)
            .width($r("app.string.sub_list_width"))
            .margin({left:10,right:10})
            .friction($r('app.float.list_friction'))
            .onWillScroll((xOffset: number) => {
              this.indicatorLeftMargin -= xOffset;
            })

            Image($r("app.media.tab_search_icon"))
              .width($r('app.integer.tab_search_icon_width'))
              .height($r('app.integer.tab_search_icon_height'))
              .id(TabContentConstants.TAB_ADD_IMAGE)
              .alignRules({
                top: { anchor: TabContentConstants.TAB_CONTAINER, align: VerticalAlign.Top },
                right: { anchor: TabContentConstants.TAB_CONTAINER, align: HorizontalAlign.End }
              })
              .margin({
                // top: $r('app.integer.tab_search_image_margin'),
                // left: $r('app.integer.tab_search_image_margin')
              })
              .onClick(() => {
                this.utils.showPromptAction();
              })
            //
            // Image($r('app.media.more'))
            //   .width(Constants.MORE_IMAGE_WIDTH)
            //   .height(Constants.MORE_IMAGE_HEIGHT)
            //   .margin({ left: Constants.MARGIN_SIXTEEN })
          }
          .height($r('app.float.mainPage_barHeight'))
          .width(Constants.FULL_WIDTH)
        }
        .alignItems(HorizontalAlign.Center)
        .width(Constants.FULL_WIDTH)

        // Column()
        //   .height(Constants.STROKE_WIDTH)
        //   .width(this.indicatorWidth)
        //   .margin({ left: this.indicatorLeftMargin, top: $r('app.float.margin_slide_top') })
        //   .backgroundColor($r('app.color.checked_color'))
      }
      .width(Constants.FULL_WIDTH)

      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        ForEach(this.tabArray, (item: TabItem) => {
          TabContent() {
            // Row() {
            //   Text(item.name)
            //     .height(Constants.CONTENT_HEIGHT)
            //     .fontSize($r('app.float.content_font_size'))
            // }
            // .width(Constants.FULL_WIDTH)
            // .justifyContent(FlexAlign.Center)
            // VideoTabContent()
            ShortVideo()
          }
        }, (item: TabItem, index: number) => JSON.stringify(item) + index)
      }
      .onAreaChange((oldValue: Area, newValue: Area) => {
        hilog.info(0x0000, 'index', oldValue.toString());
        let width = Number.parseFloat(newValue.width.toString());
        this.tabsWidth = Number.isNaN(width) ? this.init0 : width;
      })
      .width(Constants.FULL_WIDTH)
      .barHeight(this.init0)
      .animationDuration(Constants.ANIMATION_DURATION)
      .onAnimationStart((index: number, targetIndex: number) => {
        hilog.info(0x0000, 'index', index.toString());
        this.focusIndex = targetIndex;
        let targetIndexInfo = this.getTextInfo(targetIndex);
        this.startAnimateTo(Constants.ANIMATION_DURATION, targetIndexInfo.left, targetIndexInfo.width);
        this.listScroller.scrollToIndex(targetIndex - Constants.TAB_INDEX_THREE, true);
      })
      .onAnimationEnd((index: number, event: TabsAnimationEvent) => {
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event);
        this.startAnimateTo(this.init0, currentIndicatorInfo.left, currentIndicatorInfo.width);
      })
      .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event);
        this.focusIndex = currentIndicatorInfo.index;
        this.indicatorLeftMargin = currentIndicatorInfo.left;
        this.tabWidth = currentIndicatorInfo.width;
        this.indicatorWidth = currentIndicatorInfo.width;
      })
    }
    .height(Constants.FULL_HEIGHT)
  }

  private getTextInfo(index: number): Record<string, number> {
    // let strJson = getInspectorByKey(index.toString());
    // try {
    //   let obj: Record<string, string> = JSON.parse(strJson);
    //   let rectInfo: number[][] = JSON.parse('[' + obj.$rect + ']');
    //   return {
    //     'left': px2vp(rectInfo[Constants.TAB_INDEX_ZERO][Constants.TAB_INDEX_ZERO]),
    //     'width': px2vp(rectInfo[Constants.TAB_INDEX_ONE][Constants.TAB_INDEX_ZERO] -
    //     rectInfo[Constants.TAB_INDEX_ZERO][Constants.TAB_INDEX_ZERO])
    //   }
    // } catch (error) {
    //   return { 'left': this.init0, 'width': this.init0 };
    // }
    return { 'left': this.init0, 'width': this.init0 };

  }

  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index;
    if (index > Constants.TAB_INDEX_ZERO && event.currentOffset > Constants.TAB_INDEX_ZERO) {
      nextIndex--;
    } else if (index < Constants.TAB_INDEX_THREE && event.currentOffset < Constants.TAB_INDEX_ZERO) {
      nextIndex++;
    }
    let indexInfo = this.getTextInfo(index);
    let nextIndexInfo = this.getTextInfo(nextIndex);
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth);
    let currentIndex = swipeRatio > this.swipeRatio ? nextIndex : index;
    let currentLeft = indexInfo.left + (nextIndexInfo.left - indexInfo.left) * swipeRatio;
    let currentWidth = indexInfo.width + (nextIndexInfo.width - indexInfo.width) * swipeRatio;
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth };
  }

  private startAnimateTo(duration: number, leftMargin: number, width: number) {
    animateTo({
      duration: duration,
      curve: Curve.Linear,
      iterations: this.iteration,
      playMode: PlayMode.Normal,
    }, () => {
      this.indicatorLeftMargin = leftMargin;
      this.indicatorWidth = width;
    })
  }
}

//   build() {
//     RelativeContainer() {
//       Image($r("app.media.sidebar"))
//         .width($r('app.integer.tab_search_icon_width'))
//         .height($r('app.integer.tab_search_icon_height'))
//         .id(TabContentConstants.TAB_SEARCH_IMAGE)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_CONTAINER, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_CONTAINER, align: HorizontalAlign.Start }
//         })
//         .margin({
//           top: $r('app.integer.tab_search_image_margin'),
//           left: $r('app.integer.tab_search_image_margin')
//         })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_live'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_FOLLOW_TEXT)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_SEARCH_IMAGE, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_SEARCH_IMAGE, align: HorizontalAlign.End }
//         })
//         .textAlign(TextAlign.Center)
//         .margin({ left: $r('app.integer.tab_search_image_margin') })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_selected'))
//         .fontColor(Color.White)
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_SELECTED_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_FOLLOW_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_FOLLOW_TEXT, align: HorizontalAlign.End }
//         })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_exp'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_RECOMMENDATION_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_SELECTED_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_SELECTED_TEXT, align: HorizontalAlign.End }
//         })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_city'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_SCREENING_HALL_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: HorizontalAlign.End }
//         })
//         .margin({ right: $r('app.integer.tab_search_image_margin') })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_focus'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_SCREENING_HALL_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: HorizontalAlign.End }
//         })
//         .margin({ right: $r('app.integer.tab_search_image_margin') })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_mall'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_SCREENING_HALL_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: HorizontalAlign.End }
//         })
//         .margin({ right: $r('app.integer.tab_search_image_margin') })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Text($r('app.string.tab_recommendation'))
//         .fontColor($r('app.color.tab_font_color'))
//         .fontSize($r('app.integer.tab_tab_font_size'))
//         .width($r('app.string.tab_focus_width'))
//         .id(TabContentConstants.TAB_SCREENING_HALL_TEXT)
//         .textAlign(TextAlign.Center)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: VerticalAlign.Top },
//           left: { anchor: TabContentConstants.TAB_RECOMMENDATION_TEXT, align: HorizontalAlign.End }
//         })
//         .margin({ right: $r('app.integer.tab_search_image_margin') })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//       Divider()
//         .width($r('app.integer.tab_tab_divider_width'))
//         .strokeWidth(TabContentConstants.TAB_TWO)
//         .color(Color.White)
//         .margin({ top: $r('app.integer.tab_divider_margin_top') })
//         .id(TabContentConstants.TAB_TOP_VIEW_DIVIDER)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_SELECTED_TEXT, align: VerticalAlign.Bottom },
//           left: { anchor: TabContentConstants.TAB_SELECTED_TEXT, align: HorizontalAlign.Center }
//         })
//         .margin({
//           top: $r('app.integer.tab_top_view_divider_margin_top'),
//           left: $r('app.integer.tab_top_view_divider_margin_left')
//         })
//       Image($r("app.media.tab_search_icon"))
//         .width($r('app.integer.tab_search_icon_width'))
//         .height($r('app.integer.tab_search_icon_height'))
//         .id(TabContentConstants.TAB_ADD_IMAGE)
//         .alignRules({
//           top: { anchor: TabContentConstants.TAB_CONTAINER, align: VerticalAlign.Top },
//           right: { anchor: TabContentConstants.TAB_CONTAINER, align: HorizontalAlign.End }
//         })
//         .margin({
//           top: $r('app.integer.tab_search_image_margin'),
//           right: $r('app.integer.tab_search_image_margin')
//         })
//         .onClick(() => {
//           this.utils.showPromptAction();
//         })
//     }
//     .height($r('app.integer.tab_top_view_relativecontainer_height'))
//   }
// }