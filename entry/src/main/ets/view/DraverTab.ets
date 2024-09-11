
import { Constants } from '../common/Constants';
import { TopView } from './TopView';

@Component
export  struct  DrawerTab {
  @State navList: Array<number> = [0, 1, 2, 3, 4, 5];
  @State active: number = 0;
  @State show: boolean = false;
  private one: number = 1;
  build() {
    SideBarContainer(SideBarContainerType.Embed) {
      Column() {
        Column() {
          ForEach(this.navList, (item: number, index: number) => {
            Column() {
              Row() {
                Image(this.active === item ? $r('app.media.activeList') : $r("app.media.list"))
                  .width(Constants.DRAWER_IMAGE_HEIGHT_WIDTH)
                  .height(Constants.DRAWER_IMAGE_HEIGHT_WIDTH)
                Text($r('app.string.list_name'))
                  .fontSize($r('app.float.text_size'))
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: $r('app.float.margin_list') })
              }
              .height(Constants.LIST_HEIGHT)
              .width(Constants.FULL_WIDTH)

              if (this.navList.length - this.one !== index) {
                Row()
                  .height(Constants.DIVIDER_HEIGHT)
                  .backgroundColor($r('app.color.index_divider_color'))
                  .width(Constants.DIVIDER_DRAWER_WIDTH)
              }
            }
            .onClick(() => {
              this.active = item;
            })
            .margin({
              top: $r('app.float.margin_drawer_list'),
              left:  $r('app.float.margin_drawer_list'),
              right:  $r('app.float.margin_drawer_list'),
              bottom:  $r('app.float.margin_drawer_list')
            })
            .justifyContent(FlexAlign.Center)
            .width(Constants.DRAWER_WIDTH)
            .height(Constants.LIST_HEIGHT)
            .padding({ left: $r('app.float.padding_drawer_row')})
            .borderRadius(Constants.BORDER_RADIUS_DRAWER)
            .backgroundColor(this.active === item ? $r('app.color.current_list_color') : '')
          }, (item: number, index: number) => JSON.stringify(item) + index)

          Row() {
            Image($r('app.media.add'))
              .width(Constants.LIST_IMAGE_HEIGHT_WIDTH)
              .height(Constants.LIST_IMAGE_HEIGHT_WIDTH)
            Text($r('app.string.add_list')).margin({ left: $r('app.float.margin_eight') })
          }
          .width(Constants.FULL_WIDTH)
          .margin({ top: $r('app.float.margin_sidebar_content') })
        }
        .width(Constants.LIST_CARD_WIDTH)
        .height(Constants.LIST_CARD_HEIGHT)
        .backgroundColor(Color.White)
        .borderRadius(Constants.BORDER_RADIUS_DRAWER_CONTENT)
      }
      .height(Constants.FULL_HEIGHT)
      .padding({ top: $r('app.float.drawer_padding') })
      .backgroundColor($r('app.color.list_background_color'))

      Column() {
        // Text($r('app.string.content'))
        //   .width(Constants.FULL_WIDTH)
        //   .height(Constants.FULL_HEIGHT)
        //   .fontSize($r('app.float.content_font_size'))
        //   .textAlign(TextAlign.Center)
        //   .fontColor(Color.Black)
        TopView()
      }
      .onClick(() => {
        animateTo({
          duration: Constants.ANIMATION_DURATION,
          curve: Curve.EaseOut,
          playMode: PlayMode.Normal,
        }, () => {
          this.show = false;
        })
      })
      .width(Constants.FULL_WIDTH)
      .height(Constants.LIST_CONTENT_HEIGHT)
      .backgroundColor(this.show ? $r('app.color.content_background_color') : '')
    }
    .showControlButton(false)
    .showSideBar(this.show)
    .controlButton({
      left: Constants.MARGIN_SIXTEEN,
      top: Constants.MARGIN_BUTTON_TOP,
      height: Constants.LIST_IMAGE_HEIGHT_WIDTH,
      width: Constants.LIST_IMAGE_HEIGHT_WIDTH,
      icons: {
        shown: $r('app.media.changeBack'),
        hidden: $r('app.media.change'),
        switching: $r('app.media.change')
      }
    })
    .onChange((value: boolean) => {
      this.show = value;
    })
    .sideBarWidth(Constants.SUB_LIST_WIDTH)
    .minSideBarWidth(Constants.SUB_LIST_WIDTH)
    .width(Constants.FULL_WIDTH)
    .height(Constants.LIST_CONTENT_HEIGHT)
    .translate({ y: Constants.TRANSLATE_TOP })
  }
}